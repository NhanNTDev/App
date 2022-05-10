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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Net;
using System.Threading.Tasks;

namespace DiCho.DataService.Services
{
    public partial interface IProductHarvestService
    {
        Task<DynamicModelsResponse<ProductHarvestModel>> Gets(ProductHarvestModel model, string farmerId, int page, int size);
        Task<ProductHarvestModel> GetById(int id);
        Task<ProductHarvestCreateModel> Create(ProductHarvestCreateInputModel model);
        Task<ProductHarvest> Update(int id, ProductHarvestUpdateInputModel model);
        Task<ProductHarvest> Delete(int id);
        Task<int> CountHarvestByFarmerId(string farmerId);
        Task<List<ProductHarvestSearchNameModel>> SearchHarvestName(string farmerId, ProductHarvestSearchNameModel model);
        Task<ProductHarvestDetailViewModel> HarvestDetail(int harvestId, int campaignId);

    }
    public partial class ProductHarvestService
    {
        private readonly IConfigurationProvider _mapper;
        private readonly IFirebaseService _firebaseService;
        private readonly IProductSystemService _productSystemService;
        private readonly IProductSalesCampaignService _productSalesCampaignService;

        public ProductHarvestService(IProductHarvestRepository repository, IProductSalesCampaignService productSalesCampaignService,
            IFirebaseService firebaseService, IProductSystemService productSystemService,
            IUnitOfWork unitOfWork, IMapper mapper = null) : base(unitOfWork, repository)
        {
            _mapper = mapper.ConfigurationProvider;
            _firebaseService = firebaseService;
            _productSystemService = productSystemService;
            _productSalesCampaignService = productSalesCampaignService;
        }

        public async Task<DynamicModelsResponse<ProductHarvestModel>> Gets(ProductHarvestModel model, string farmerId, int page, int size)
        {
            if (farmerId != null)
            {
                var resultFilter = Get(x => x.Active && x.Farm.FarmerId == farmerId).ProjectTo<ProductHarvestModel>(_mapper)
                    .DynamicFilter(model).OrderByDescending(x => x.Id)
                    .Select<ProductHarvestModel>(ProductHarvestModel.Fields.ToArray().ToDynamicSelector<ProductHarvestModel>())
                    .PagingIQueryable(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
                var rs = new DynamicModelsResponse<ProductHarvestModel>
                {
                    Metadata = new PagingMetadata { Page = page, Size = size, Total = resultFilter.Item1 },
                    Data = await resultFilter.Item2.ToListAsync()
                };
                return rs;
            }
            else
            {
                var resultFilter = Get(x => x.Active).ProjectTo<ProductHarvestModel>(_mapper)
                    .DynamicFilter(model).OrderByDescending(x => x.Id)
                    .Select<ProductHarvestModel>(ProductHarvestModel.Fields.ToArray().ToDynamicSelector<ProductHarvestModel>())
                    .PagingIQueryable(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
                var rs = new DynamicModelsResponse<ProductHarvestModel>
                {
                    Metadata = new PagingMetadata { Page = page, Size = size, Total = resultFilter.Item1 },
                    Data = await resultFilter.Item2.ToListAsync()
                };
                return rs;
            }
        }

        public async Task<ProductHarvestModel> GetById(int id)
        {
            var result = await Get(x => x.Id == id && x.Active).ProjectTo<ProductHarvestModel>(_mapper).FirstOrDefaultAsync();
            if (result == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"'{id}' not found!");
            return result;
        }

        public async Task<ProductHarvestDetailViewModel> HarvestDetail(int harvestId, int campaignId)
        {
            var harvest = await Get(x => x.Id == harvestId).ProjectTo<ProductHarvestDetailViewModel>(_mapper).FirstOrDefaultAsync();
            if (harvest == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy");
            var productSale = _productSalesCampaignService.Get(x => x.CampaignId == campaignId && x.ProductSystemId == harvest.ProductSystemId).FirstOrDefault();
            if (productSale != null)
            {
                harvest.CampaignId = productSale.CampaignId;
                harvest.MaxCapacity = productSale.MaxCapacity;
                harvest.MinCapacity = productSale.MinCapacity;
            }

            return harvest;
        }

        public async Task<ProductHarvestCreateModel> Create(ProductHarvestCreateInputModel modelInput)
        {
            if (modelInput.Images == null)
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, $"Hình ảnh không được bỏ trống!");

            var folderUpload = "Harvest";
            List<string> listLink = await _firebaseService.UploadFilesToFirebase(modelInput.Images, folderUpload);

            if (modelInput.ActualProduction == null)
                modelInput.ActualProduction = 0;
            var model = new ProductHarvestCreateModel
            {
                EstimatedProduction = modelInput.EstimatedProduction,
                EstimatedTime = modelInput.EstimatedTime,
                Description = modelInput.Description,
                FarmId = modelInput.FarmId,
                ProductName = modelInput.ProductName,
                ProductSystemId = modelInput.ProductSystemId,
                StartAt = modelInput.StartAt,
                Name = modelInput.Name,
                ActualProduction = modelInput.ActualProduction,
            };

            if (model.ActualProduction != 0)
                model.InventoryTotal = model.ActualProduction;
            else
                model.InventoryTotal = model.EstimatedProduction;

            switch (listLink.Count)
            {
                case 1:
                    model.Image1 = listLink[0];
                    break;
                case 2:
                    model.Image1 = listLink[0];
                    model.Image2 = listLink[1];
                    break;
                case 3:
                    model.Image1 = listLink[0];
                    model.Image2 = listLink[1];
                    model.Image3 = listLink[2];
                    break;
                case 4:
                    model.Image1 = listLink[0];
                    model.Image2 = listLink[1];
                    model.Image3 = listLink[2];
                    model.Image4 = listLink[3];
                    break;
                case 5:
                    model.Image1 = listLink[0];
                    model.Image2 = listLink[1];
                    model.Image3 = listLink[2];
                    model.Image4 = listLink[3];
                    model.Image5 = listLink[4];
                    break;
            }

            var entity = _mapper.CreateMapper().Map<ProductHarvest>(model);

            var productSystem =  _productSystemService.Get(x => x.Id == model.ProductSystemId).FirstOrDefault();
            entity.Price = (productSystem.MinPrice + productSystem.MaxPrice) / 2;
            if (modelInput.ProductName == null)
                entity.ProductName = productSystem.Name;
            await CreateAsyn(entity);
            return model;
        }
        public async Task<ProductHarvest> Update(int id, ProductHarvestUpdateInputModel modelInput)
        {
            var entity = await GetAsyn(id);
            if (modelInput.Id != id)
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, $"Vui lòng nhập đúng!");
            if (entity == null || !entity.Active)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");

            var folderUpload = "Harvest";
            List<string> listLink = await _firebaseService.UploadFilesToFirebase(modelInput.Images, folderUpload);

            var model = new ProductHarvestUpdateModel
            {
                EstimatedTime = modelInput.EstimatedTime,
                Description = modelInput.Description,
                ProductName = modelInput.ProductName,
                Name = modelInput.Name,
                Id = modelInput.Id,
                ActualProduction = modelInput.ActualProduction
            };

            if (model.ActualProduction != 0 && entity.ActualProduction != 0)
            {
                double? ActualProduction = entity.ActualProduction;
                double inventoryTotal = entity.InventoryTotal;
                double? product = model.ActualProduction - ActualProduction;

                model.InventoryTotal = inventoryTotal + product;
                if (model.InventoryTotal < 0)
                    model.InventoryTotal = 0;
            }

            if (model.ActualProduction != 0 && entity.ActualProduction == 0)
            {
                double estimatedProduction = entity.EstimatedProduction;
                double inventoryTotal = entity.InventoryTotal;
                double? product = modelInput.ActualProduction - estimatedProduction;

                model.InventoryTotal = inventoryTotal + product;
                if (model.InventoryTotal < 0)
                    model.InventoryTotal = 0;
            }

            switch (listLink.Count)
            {
                case 1:
                    model.Image1 = listLink[0];
                    break;
                case 2:
                    model.Image1 = listLink[0];
                    model.Image2 = listLink[1];
                    break;
                case 3:
                    model.Image1 = listLink[0];
                    model.Image2 = listLink[1];
                    model.Image3 = listLink[2];
                    break;
                case 4:
                    model.Image1 = listLink[0];
                    model.Image2 = listLink[1];
                    model.Image3 = listLink[2];
                    model.Image4 = listLink[3];
                    break;
                case 5:
                    model.Image1 = listLink[0];
                    model.Image2 = listLink[1];
                    model.Image3 = listLink[2];
                    model.Image4 = listLink[3];
                    model.Image5 = listLink[4];
                    break;
                default:
                    model.Image1 = entity.Image1;
                    model.Image2 = entity.Image2;
                    model.Image3 = entity.Image3;
                    model.Image4 = entity.Image4;
                    model.Image5 = entity.Image5;
                    break;
            }

            var updateEntity = _mapper.CreateMapper().Map(model, entity);
            await UpdateAsyn(updateEntity);
            return updateEntity;
        }

        public async Task<ProductHarvest> Delete(int id)
        {
            var entity = Get(x => x.Id == id).ProjectTo<ProductHarvest>(_mapper).FirstOrDefault();
            if (entity == null && !entity.Active)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");
            if (entity.ProductHarvestInCampaigns.Count > 0 && entity.ProductHarvestInCampaigns.Any(x => x.Status != (int)HarvestCampaignEnum.Đãbịtừchối))
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, $"Mùa vụ đang có sản phẩm được bày bán. Không thể xóa!");
            entity.Active = false;
            await UpdateAsyn(entity);
            return entity;
        }

        public async Task<int> CountHarvestByFarmerId(string farmerId)
        {
            var result = await Get(x => x.Active && x.Farm.FarmerId == farmerId).CountAsync();
            return result;
        }

        public async Task<List<ProductHarvestSearchNameModel>> SearchHarvestName(string farmerId, ProductHarvestSearchNameModel model)
        {
            var search = Get(x => x.Active && x.Farm.FarmerId == farmerId).ProjectTo<ProductHarvestSearchNameModel>(_mapper).DynamicFilter(model)
                .Select<ProductHarvestSearchNameModel>(ProductHarvestSearchNameModel.Fields.ToArray().ToDynamicSelector<ProductHarvestSearchNameModel>()).ToList();
            foreach (var item in search)
            {
                var data = await Get(x => x.Id == item.Id).ProjectTo<HarvestMapNotiModel>(_mapper).FirstOrDefaultAsync();
                item.FarmName = data.Farm.Name;
            }
            return search;
        }
    }
}
