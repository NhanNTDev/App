using AutoMapper;
using AutoMapper.QueryableExtensions;
using DiCho.Core.BaseConnect;
using DiCho.Core.Custom;
using DiCho.Core.Utilities;
using DiCho.DataService.Commons;
using DiCho.DataService.Enums;
using DiCho.DataService.Models;
using DiCho.DataService.Repositories;
using DiCho.DataService.Response;
using DiCho.DataService.ViewModels;
using Microsoft.EntityFrameworkCore;
using StackExchange.Redis.Extensions.Core.Abstractions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Net;
using System.Threading.Tasks;

namespace DiCho.DataService.Services
{
    public partial interface IProductHarvestInCampaignService
    {
        Task<DynamicModelsResponse<ProductHarvestInCampaignModel>> Gets(int deliveryZoneId, ProductHarvestInCampaignModel model, List<string> categorys, int page, int size);
        Task<ProductHarvestInCampaignDetailByIdModel> GetHarvestCampaignDetailById(int id);
        Task<DynamicModelsResponse<ProductHarvestCampaignOfFarmModel>> GetHarvestCampaignOfFarm(int campaignId, int farmId, int page, int size);
        Task<int> CountHarvestCampaignOfFarm(int campaignId, int farmId);
        Task<ProductHarvestCampaignDetailModel> GetById(int id);
        Task<List<ProductHarvestCampaignCreateModel>> Create(List<ProductHarvestCampaignCreateModel> listModel);
        Task<ProductHarvestInCampaign> Update(int id, ProductHarvestCampaignUpdateModel model);
        Task UpdateAccept(List<int> id);
        Task UpdateReject(int id, string note);
        Task<ProductHarvestInCampaign> Delete(int id);
        Task<List<ProductHarvestCampaignSearchModel>> SearchHarvestCampaignOfFarm(int campaignId, int farmId, ProductHarvestCampaignSearchModel model);
        Task<List<ProductHarvestCampaignSearchModel>> SearchHarvestCampaignOfCustomer(int deliveryZoneId, ProductHarvestCampaignSearchModel model);
        Task<ProductHarvestInCampaginOriginModel> GetOriginProductHarvestById(int id);
    }
    public partial class ProductHarvestInCampaignService
    {
        private readonly IConfigurationProvider _mapper;
        private readonly IProductHarvestService _harvestService;
        private readonly IFirebaseService _firebaseService;
        public ProductHarvestInCampaignService(IProductHarvestInCampaignRepository repository, IFirebaseService firebaseService,
            IProductHarvestService harvestService,
            IUnitOfWork unitOfWork, IMapper mapper = null) : base(unitOfWork, repository)
        {
            _mapper = mapper.ConfigurationProvider;
            _harvestService = harvestService;
            _firebaseService = firebaseService;
        }

        public async Task<DynamicModelsResponse<ProductHarvestInCampaignModel>> Gets(int deliveryZoneId, ProductHarvestInCampaignModel model, List<string> categorys, int page, int size)
        {
            var resultFilter = Get(x => (x.Status == (int)HarvestCampaignEnum.Đãxácnhận || x.Status == (int)HarvestCampaignEnum.Đãhếthàng) && x.Campaign.CampaignDeliveryZones.Any(y => y.DeliveryZoneId == deliveryZoneId) && x.Campaign.Status == (int)CampaignEnum.Đangdiễnra).ProjectTo<ProductHarvestInCampaignModel>(_mapper).DynamicFilter(model)
                .Select<ProductHarvestInCampaignModel>(ProductHarvestInCampaignModel.Fields.ToArray().ToDynamicSelector<ProductHarvestInCampaignModel>());
            var listHarvestCampaign = await resultFilter.ToListAsync();

            foreach (var harvestCampaign in listHarvestCampaign)
            {
                harvestCampaign.UnitOfSystem = harvestCampaign.Harvest.ProductSystem.Unit;
                harvestCampaign.Status = harvestCampaign.Status switch
                {
                    "1" => "Đã được xác nhận",
                    "2" => "Đã hết hàng",
                    _ => ""
                };
            }
            if (categorys.Count != 0)
            {
                var listResult = new List<ProductHarvestInCampaignModel>();
                foreach (var category in categorys)
                    listResult.AddRange(listHarvestCampaign.Where(x => x.Harvest.ProductSystem.ProductCategory.Name.ToUpper() == category.ToUpper()).ToList());
                var listPaging = listResult.PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
                var result2 = new DynamicModelsResponse<ProductHarvestInCampaignModel>
                {
                    Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
                    Data = listPaging.Item2
                };
                return result2;
            }

            var resultPaging = listHarvestCampaign.PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
            var result = new DynamicModelsResponse<ProductHarvestInCampaignModel>
            {
                Metadata = new PagingMetadata { Page = page, Size = size, Total = resultPaging.Item1 },
                Data = resultPaging.Item2
            };
            return result;
        }

        public async Task<DynamicModelsResponse<ProductHarvestCampaignOfFarmModel>> GetHarvestCampaignOfFarm(int campaignId, int farmId, int page, int size)
        {
            var harvestCampaigns = await Get(x => x.CampaignId == campaignId && x.Harvest.FarmId == farmId).ProjectTo<ProductHarvestCampaignOfFarmModel>(_mapper).ToListAsync();

            foreach (var harvestCampaign in harvestCampaigns)
            {
                harvestCampaign.Status = harvestCampaign.Status switch
                {
                    "0" => "Chờ xác nhận",
                    "1" => "Đã được xác nhận",
                    "2" => "Đã hết hàng",
                    "3" => "Đã hủy",
                    "4" => "Đã ngừng bán",
                    _ => "",
                };
                var harvest = _harvestService.Get(x => x.Id == harvestCampaign.HarvestId).ProjectTo<ProductHarvestModel>(_mapper).FirstOrDefault();
                harvestCampaign.Image1 = harvest.Image1;
                harvestCampaign.Image2 = harvest.Image2;
                harvestCampaign.Image3 = harvest.Image3;
                harvestCampaign.Image4 = harvest.Image4;
                harvestCampaign.Image5 = harvest.Image5;
                harvestCampaign.HarvestName = harvest.Name;
                harvestCampaign.ProductCategoryName = harvest.ProductSystem.ProductCategory.Name;
            }

            var listPaging = harvestCampaigns.PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
            var result = new DynamicModelsResponse<ProductHarvestCampaignOfFarmModel>
            {
                Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
                Data = listPaging.Item2
            };

            return result;
        }

        public async Task<int> CountHarvestCampaignOfFarm(int campaignId, int farmId)
        {
            var harvestCampaigns = await Get(x => x.CampaignId == campaignId && x.Harvest.FarmId == farmId).CountAsync();
            return harvestCampaigns;
        }

        public async Task<ProductHarvestInCampaignDetailByIdModel> GetHarvestCampaignDetailById(int id)
        {
            var harvestCampaign = await Get(x => x.Id == id).ProjectTo<ProductHarvestInCampaignDetailByIdModel>(_mapper).FirstOrDefaultAsync();
            harvestCampaign.Status = harvestCampaign.Status switch
            {
                "0" => "Chờ xác nhận",
                "1" => "Đã được xác nhận",
                "2" => "Đã hết hàng",
                "3" => "Đã hủy",
                "4" => "Đã ngừng bán",
                _ => ""
            };
            var data = _harvestService.Get(x => x.Id == harvestCampaign.HarvestId).ProjectTo<HarvestMappingHarvestCampaignModel>(_mapper).FirstOrDefault();
            harvestCampaign.Image1 = data.Image1;
            harvestCampaign.Image2 = data.Image2;
            harvestCampaign.Image3 = data.Image3;
            harvestCampaign.Image4 = data.Image4;
            harvestCampaign.Image5 = data.Image5;
            harvestCampaign.HarvestName = data.Name;
            harvestCampaign.SystemUnit = data.ProductSystem.Unit;
            harvestCampaign.HarvestDescription = data.Description;
            harvestCampaign.ProductCategoryName = data.ProductSystem.ProductCategory.Name;
            harvestCampaign.ProductNameSystem = data.ProductSystem.Name;
            harvestCampaign.FarmName = data.Farm.Name;
            harvestCampaign.MinPrice = data.ProductSystem.MinPrice;
            harvestCampaign.MaxPrice = data.ProductSystem.MaxPrice;

            if (harvestCampaign == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");

            return harvestCampaign;
        }

        public async Task<ProductHarvestCampaignDetailModel> GetById(int id)
        {
            var harvestCampaign = await Get(x => x.Id == id).ProjectTo<ProductHarvestCampaignDetailModel>(_mapper).FirstOrDefaultAsync();
            if (harvestCampaign == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");
            harvestCampaign.Status = harvestCampaign.Status switch
            {
                "0" => "Chờ xác nhận",
                "1" => "Đã được xác nhận",
                "2" => "Đã hết hàng",
                "3" => "Đã hủy",
                "4" => "Đã ngừng bán",
                _ => ""
            };
            var data = _harvestService.Get(x => x.Id == harvestCampaign.HarvestId).ProjectTo<HarvestMappingHarvestCampaignModel>(_mapper).FirstOrDefault();
            harvestCampaign.Image1 = data.Image1;
            harvestCampaign.Image2 = data.Image2;
            harvestCampaign.Image3 = data.Image3;
            harvestCampaign.Image4 = data.Image4;
            harvestCampaign.Image5 = data.Image5;
            harvestCampaign.HarvestName = data.Name;
            harvestCampaign.SystemUnit = data.ProductSystem.Unit;
            harvestCampaign.HarvestDescription = data.Description;
            harvestCampaign.ProductCategoryName = data.ProductSystem.ProductCategory.Name;
            harvestCampaign.ProductNameSystem = data.ProductSystem.Name;
            harvestCampaign.FarmName = data.Farm.Name;
            harvestCampaign.FarmId = data.FarmId;

            return harvestCampaign;
        }

        public async Task<List<ProductHarvestCampaignCreateModel>> Create(List<ProductHarvestCampaignCreateModel> listModel)
        {
            foreach (var model in listModel)
            {
                if (model.ValueChangeOfUnit == 0)
                    model.ValueChangeOfUnit = 1;

                var harvest = _harvestService.Get(x => x.Id == model.HarvestId).FirstOrDefault();
                if (model.Unit == null)
                    model.Unit = harvest.ProductSystem.Unit;
                var entity = _mapper.CreateMapper().Map<ProductHarvestInCampaign>(model);

                entity.ProductName = harvest.ProductName;
                var inventoryTotal = harvest.InventoryTotal;
                harvest.InventoryTotal -= model.Inventory * model.ValueChangeOfUnit;

                if (harvest.InventoryTotal > inventoryTotal)
                    throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Số lượng trong kho không đủ! Chỉ còn {inventoryTotal}");
                entity.Quantity = model.Inventory;
                await _harvestService.UpdateAsyn(harvest);
                await CreateAsyn(entity);
            }
            return listModel;
        }

        public async Task<ProductHarvestInCampaign> Update(int id, ProductHarvestCampaignUpdateModel model)
        {
            var entity = await GetAsyn(id);
            if (model.Id != id)
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, $"Vui lòng nhập đúng!");
            if (entity.Status == (int)HarvestCampaignEnum.Đãngừngbán || entity == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");
            var updateEntity = _mapper.CreateMapper().Map(model, entity);
            await UpdateAsyn(updateEntity);
            return updateEntity;
        }

        public async Task UpdateAccept(List<int> id)
        {
            string campaignId = "";
            string campaignName = "";
            string farmerId = "";
            var nameProducts = new List<string>();
            string farmName = "";
            foreach (var item in id)
            {
                var entity = await GetAsyn(item);
                if (entity == null)
                    throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");

                var data = Get(x => x.Id == item).ProjectTo<HarvestCampaignMapNotiModel>(_mapper).FirstOrDefault();
                campaignId = entity.CampaignId.ToString();
                campaignName = data.Campaign.Name;
                farmerId = data.Harvest.Farm.Farmer.Id;
                nameProducts.Add(entity.ProductName);
                farmName = data.Harvest.Farm.Name;
                entity.Status = (int)HarvestCampaignEnum.Đãxácnhận;
                await UpdateAsyn(entity);
            }
            string topic = $"{farmerId}";
            string title = $"Chiến dịch {campaignName}";
            
            string body = $"Chúc mừng! các sản phẩm {string.Join($", ", nameProducts)} của {farmName} đã được phép bày bán";
            await _firebaseService.SendNotification(title, body, campaignId, topic);

            await _firebaseService.AddNotiToRedis(new NotificationModel { UserId = farmerId, Title = title, Body = body });
        }

        public async Task UpdateReject(int id, string note)
        {
            string campaignId = "";
            string campaignName = "";
            string farmerId = "";

            var entity = await GetAsyn(id);

            if (entity == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");

            var data = Get(x => x.Id == id).ProjectTo<HarvestCampaignMapNotiModel>(_mapper).FirstOrDefault();
            campaignId = entity.CampaignId.ToString();
            campaignName = data.Campaign.Name;
            farmerId = data.Harvest.Farm.Farmer.Id;
            var productName = data.ProductName;
            var farmName = data.Harvest.Farm.Name;

            entity.Status = (int)HarvestCampaignEnum.Đãbịtừchối;
            entity.Note = note;
            var inventory = entity.Inventory * entity.ValueChangeOfUnit;
            var harvest = _harvestService.Get(x => x.Id == entity.HarvestId).FirstOrDefault();
            harvest.InventoryTotal += inventory;
            await _harvestService.UpdateAsyn(harvest);
            await UpdateAsyn(entity);

            string topic = $"{farmerId}";
            string title = $"Chiến dịch {campaignName}";
            string body = $"Thông báo! sản phẩm {productName} của {farmName} {note} nên không thể tham gia";
            await _firebaseService.SendNotification(title, body, campaignId, topic);

            await _firebaseService.AddNotiToRedis(new NotificationModel { UserId = farmerId, Title = title, Body = body });
        }

        public async Task<ProductHarvestInCampaign> Delete(int id)
        {
            var entity = Get(id);
            if (entity == null || entity.Status == (int)HarvestCampaignEnum.Đãngừngbán)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");
            if (entity.Status != (int)HarvestCampaignEnum.Chờxácnhận)
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, $"Đang được bán trong chiến dịch. Không thể xóa!");

            var inventory = entity.Inventory * entity.ValueChangeOfUnit;
            var harvest = _harvestService.Get(x => x.Id == entity.HarvestId).FirstOrDefault();
            harvest.InventoryTotal += inventory;
            await _harvestService.UpdateAsyn(harvest);

            await DeleteAsyn(entity);
            return entity;
        }

        public async Task<List<ProductHarvestCampaignSearchModel>> SearchHarvestCampaignOfFarm(int campaignId, int farmId, ProductHarvestCampaignSearchModel model)
        {
            var searchs = Get(x => x.CampaignId == campaignId && x.Harvest.FarmId == farmId).ProjectTo<ProductHarvestCampaignSearchModel>(_mapper)
                .DynamicFilter(model)
                .Select<ProductHarvestCampaignSearchModel>(ProductHarvestCampaignSearchModel.Fields.ToArray().ToDynamicSelector<ProductHarvestCampaignSearchModel>()).ToList();
            foreach (var item in searchs)
            {
                var data = await Get(x => x.Id == item.Id).ProjectTo<HarvestCampaignMapNotiModel>(_mapper).FirstOrDefaultAsync();
                item.HarvestName = data.Harvest.Name;
                item.FarmName = data.Harvest.Farm.Name;
                item.Image1 = data.Harvest.Image1;
            }
            return searchs;
        }

        public async Task<List<ProductHarvestCampaignSearchModel>> SearchHarvestCampaignOfCustomer(int deliveryZoneId, ProductHarvestCampaignSearchModel model)
        {
            var searchs = Get(x => (x.Status == (int)HarvestCampaignEnum.Đãxácnhận || x.Status == (int)HarvestCampaignEnum.Đãhếthàng) && x.Campaign.Status == (int)CampaignEnum.Đangdiễnra && x.Campaign.CampaignDeliveryZones.Any(y => y.DeliveryZoneId == deliveryZoneId)).ProjectTo<ProductHarvestCampaignSearchModel>(_mapper)
                    .DynamicFilter(model)
                    .Select<ProductHarvestCampaignSearchModel>(ProductHarvestCampaignSearchModel.Fields.ToArray().ToDynamicSelector<ProductHarvestCampaignSearchModel>()).ToList();
            foreach (var item in searchs)
            {
                var data = await Get(x => x.Id == item.Id).ProjectTo<HarvestCampaignMapNotiModel>(_mapper).FirstOrDefaultAsync();
                item.HarvestName = data.Harvest.Name;
                item.FarmName = data.Harvest.Farm.Name;
                item.Image1 = data.Harvest.Image1;
            }
            return searchs;
        }

        public async Task<ProductHarvestInCampaginOriginModel> GetOriginProductHarvestById(int id)
        {
            var productHarvest = await Get(x => x.Id == id).ProjectTo<ProductHarvestInCampaginOriginModel>(_mapper).FirstOrDefaultAsync();
            if (productHarvest == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy");
            productHarvest.Status = productHarvest.Status switch
            {
                "0" => "Chờ xác nhận",
                "1" => "Đã được xác nhận",
                "2" => "Đã hết hàng",
                "3" => "Đã hủy",
                "4" => "Đã ngừng bán",
                _ => ""
            };
            productHarvest.Harvest.Farm.FarmOrders = productHarvest.Harvest.Farm.FarmOrders.Where(x => x.Star > 0).ToList();
            var stars = productHarvest.Harvest.Farm.FarmOrders.Select(x => x.Star).ToList();
            if (stars.Count > 0)
            {
                decimal star = (decimal)stars.Sum(x => x);
                decimal total = star / stars.Count;
                double multiplier = Math.Pow(10, 1);
                total = Math.Ceiling(total * (decimal)multiplier) / (decimal)multiplier;
                productHarvest.Harvest.Farm.TotalStar = total;
            }
            productHarvest.Harvest.Farm.Feedbacks = stars.Count();
            return productHarvest;
        }
    }
}
