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
using Google.OrTools.LinearSolver;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;
using StackExchange.Redis.Extensions.Core.Abstractions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Net;
using System.Threading.Tasks;
using System.Web;

namespace DiCho.DataService.Services
{
    public partial interface IOrderService
    {
        Task<DynamicModelsResponse<OrderModel>> GetAllOrder(OrderModel model, int page, int size);
        Task<List<WarehouseGroupModel>> GetOrderGroup(int warehouseId);
        Task<OrderDetailModel> GetById(int id);
        Task<double> ShipCostOfOrder(double productCost, string address, int campaignId);
        Task<string> Create(OrderCreateModelInput model);
        Task UpdateOrderStatus(int id, OrderUpdateModel model);
        Task Feedback(int id, FeedbackOrderModel model);
        Task RejectOrder(int id, string note);
        Task StatusOrderByTime();
        TotalBinModel BinPackingMip(double[] weights, int[] NumItems);
        //Task<DynamicModelsResponse<OrderForWarehouseManagerModel>> DeliveryToCustomerForWareHouseManger(string warehouseManagerId, bool flag, int page, int size);
        Task AssignTaskOrderForDriver(List<UpdateDriverForOrderByWarehouse> model);
        //Task<DynamicModelsResponse<OrderGroupDeliveryForDriverViewModel>> DeliveryToCustomerForDriver(string driverId, bool complete, int page, int size);
        bool DeliveryToCustomerForDriverBool(string deliveryCode);
        Task<List<OrderGroupCustomerDeliveryModel>> GetOrderGroupForDelivery(int warehouseId, bool asigned);

        // MoMo
        Task<string> ReturnUrl(UrlReturn model);
        // farmorder
        Task UpdateCancelFarmOrderStatus(int id, string note);
        Task UpdateFarmOrderStatus(int id, string status);
        Task<DynamicModelsResponse<FarmOrderModel>> GetAllFarmOrder(string farmerId, FarmOrderModel model, int page, int size);
        Task<int> CountAllFarmOrderbyStatus(string farmerId, string status);
        Task<FarmOrderDetailModel> GetFarmOrderDetail(int id);
        //Task<DynamicModelsResponse<FarmOrderGroupFarmDeliveryModel>> GetGroupFarmOrderForDelivery(string warehouseManagerId, bool flag, int page, int size);
        Task<List<FarmOrderGroupFarmDeliveryModel>> GetGroupFarmOrderForDelivery(int warehouseId, bool asigned);
        Task<List<FarmOrderDetail>> GetFarmOrderByFarm(int farmId);
        //Task<DynamicModelsResponse<FarmOrderGroupFarm>> GetGroupFarmOrderForDriver(string driverId, bool completed, int page, int size);
        bool GetGroupFarmOrderForDriverBool(string collectionCode);
        Task<DynamicModelsResponse<FarmOrderFeedbackViewModel>> GetFeedbackOfFarm(int farmId, int page, int size);
        Task<DashBoardOfAdmin> DashBoardOfAdmin();
        Task<DynamicModelsResponse<InfomationOfUserModel>> GetInfomationOfUsers(string farmerId, int page, int size);
        Task<StatisticalOfFarmer> StatisticalOfFarmer(string farmerId);
        Task<List<CampaignStatisticalOfAdmin>> StatisticalOfAdmin();
        TotalBinModel BinPackingMip1(double[] weights);
    }
    public partial class OrderService
    {
        private readonly IConfigurationProvider _mapper;
        private readonly Microsoft.Extensions.Configuration.IConfiguration _configuration;
        private readonly IFarmOrderService _farmOrderService;
        private readonly IProductHarvestOrderService _harvestOrderService;
        private readonly IProductHarvestInCampaignService _harvestCampaignService;
        private readonly IItemCartService _itemCartService;
        private readonly IProductHarvestService _harvestService;
        private readonly IAddressService _addressService;
        private readonly ITradeZoneMapService _tradeZoneMapService;
        private readonly ICampaignService _campaignService;
        private readonly IPaymentService _paymentService;
        private readonly IRedisCacheClient _redisCacheClient;
        private readonly IWareHouseService _wareHouseService;
        private readonly IJWTService _jWTService;
        private readonly IProductSystemService _productSystemService;
        private readonly IFarmService _farmService;
        private readonly IPaymentTypeService _paymentTypeService;
        private readonly IFirebaseService _firebaseService;
        private readonly IPostService _postService;
        public OrderService(IOrderRepository repository, IWareHouseService wareHouseService, IJWTService jWTService, IProductSystemService productSystemService, IFarmService farmService, IPaymentTypeService paymentTypeService, Microsoft.Extensions.Configuration.IConfiguration configuration,
            IPostService postService, IRedisCacheClient redisCacheClient, IPaymentService paymentService, ICampaignService campaignService, ITradeZoneMapService tradeZoneMapService, IAddressService addressService, IProductHarvestService harvestService,
            IProductHarvestOrderService harvestOrderService, IItemCartService itemCartService, IFarmOrderService farmOrderService, IProductHarvestInCampaignService harvestCampaignService, IFirebaseService firebaseService,
            IUnitOfWork unitOfWork, IMapper mapper = null) : base(unitOfWork, repository)
        {
            _mapper = mapper.ConfigurationProvider;
            _configuration = configuration;
            _farmOrderService = farmOrderService;
            _harvestOrderService = harvestOrderService;
            _harvestCampaignService = harvestCampaignService;
            _itemCartService = itemCartService;
            _harvestService = harvestService;
            _addressService = addressService;
            _tradeZoneMapService = tradeZoneMapService;
            _campaignService = campaignService;
            _paymentService = paymentService;
            _redisCacheClient = redisCacheClient;
            _wareHouseService = wareHouseService;
            _jWTService = jWTService;
            _productSystemService = productSystemService;
            _farmService = farmService;
            _paymentTypeService = paymentTypeService;
            _firebaseService = firebaseService;
            _postService = postService;
        }

        public TotalBinModel BinPackingMip(double[] weights, int[] OrderId)
        {
            var data = new BinPackingModel
            {
                Weights = weights
            };
            data.NumBins = data.Weights.Length;
            data.NumItems = OrderId.Length;
            data.BinCapacity = 100;

            Solver solver = Solver.CreateSolver("SCIP");

            Variable[,] x = new Variable[data.NumItems, data.NumBins];
            for (int i = 0; i < data.NumItems; i++)
            {
                for (int j = 0; j < data.NumBins; j++)
                {
                    x[i, j] = solver.MakeIntVar(0, 1, $"x_{i}_{j}");
                }
            }
            Variable[] y = new Variable[data.NumBins];
            for (int j = 0; j < data.NumBins; j++)
            {
                y[j] = solver.MakeIntVar(0, 1, $"y_{j}");
            }

            for (int i = 0; i < data.NumItems; ++i)
            {
                Constraint constraint = solver.MakeConstraint(1, 1, "");
                for (int j = 0; j < data.NumBins; ++j)
                {
                    constraint.SetCoefficient(x[i, j], 1);
                }
            }

            for (int j = 0; j < data.NumBins; ++j)
            {
                Constraint constraint = solver.MakeConstraint(0, Double.PositiveInfinity, "");
                constraint.SetCoefficient(y[j], data.BinCapacity);
                for (int i = 0; i < data.NumItems; ++i)
                {
                    constraint.SetCoefficient(x[i, j], -data.Weights[i]);
                }
            }

            Objective objective = solver.Objective();
            for (int j = 0; j < data.NumBins; ++j)
            {
                objective.SetCoefficient(y[j], 1);
            }
            objective.SetMinimization();

            Solver.ResultStatus resultStatus = solver.Solve();

            if (resultStatus != Solver.ResultStatus.OPTIMAL)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"The problem does not have an optimal solution!");
            var result = new TotalBinModel();
            result.TotalBin = solver.Objective().Value();
            double TotalWeight = 0.0;
            var binResult = new List<BinResultModel>();
            for (int j = 0; j < data.NumBins; ++j)
            {
                var binDetail = new BinDetailModel();

                double BinWeight = 0.0;
                if (y[j].SolutionValue() == 1)
                {
                    var items = new List<int>();
                    for (int i = 0; i < data.NumItems; ++i)
                    {
                        if (x[i, j].SolutionValue() == 1)
                        {
                            items.Add(OrderId[i]);
                            BinWeight += data.Weights[i];
                        }
                    }
                    binDetail.Items = items;
                    binDetail.TotalWeight = BinWeight;
                    binResult.Add(new BinResultModel { BinNumber = j, BinDetail = binDetail });
                    TotalWeight += BinWeight;
                }
            }
            result.BinResult = binResult;
            return result;
        }
        public TotalBinModel BinPackingMip1(double[] weights)
        {
            var data = new BinPackingModel
            {
                Weights = weights
            };
            data.NumBins = data.Weights.Length;
            data.NumItems = data.Weights.Length;
            data.BinCapacity = 500;

            Solver solver = Solver.CreateSolver("SCIP");

            Variable[,] x = new Variable[data.NumItems, data.NumBins];
            for (int i = 0; i < data.NumItems; i++)
            {
                for (int j = 0; j < data.NumBins; j++)
                {
                    x[i, j] = solver.MakeIntVar(0, 1, $"x_{i}_{j}");
                }
            }
            Variable[] y = new Variable[data.NumBins];
            for (int j = 0; j < data.NumBins; j++)
            {
                y[j] = solver.MakeIntVar(0, 1, $"y_{j}");
            }

            for (int i = 0; i < data.NumItems; ++i)
            {
                Constraint constraint = solver.MakeConstraint(1, 1, "");
                for (int j = 0; j < data.NumBins; ++j)
                {
                    constraint.SetCoefficient(x[i, j], 1);
                }
            }

            for (int j = 0; j < data.NumBins; ++j)
            {
                Constraint constraint = solver.MakeConstraint(0, Double.PositiveInfinity, "");
                constraint.SetCoefficient(y[j], data.BinCapacity);
                for (int i = 0; i < data.NumItems; ++i)
                {
                    constraint.SetCoefficient(x[i, j], -data.Weights[i]);
                }
            }

            Objective objective = solver.Objective();
            for (int j = 0; j < data.NumBins; ++j)
            {
                objective.SetCoefficient(y[j], 1);
            }
            objective.SetMinimization();

            Solver.ResultStatus resultStatus = solver.Solve();

            if (resultStatus != Solver.ResultStatus.OPTIMAL)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"The problem does not have an optimal solution!");
            var result = new TotalBinModel();
            result.TotalBin = solver.Objective().Value();
            double TotalWeight = 0.0;
            var binResult = new List<BinResultModel>();
            for (int j = 0; j < data.NumBins; ++j)
            {
                var binDetail = new BinDetailModel();

                double BinWeight = 0.0;
                if (y[j].SolutionValue() == 1)
                {
                    var items = new List<int>();
                    for (int i = 0; i < data.NumItems; ++i)
                    {
                        if (x[i, j].SolutionValue() == 1)
                        {
                            items.Add(i);
                            BinWeight += data.Weights[i];
                        }
                    }
                    binDetail.Items = items;
                    binDetail.TotalWeight = BinWeight;
                    binResult.Add(new BinResultModel { BinNumber = j, BinDetail = binDetail });
                    TotalWeight += BinWeight;
                }
            }
            result.BinResult = binResult;
            return result;
        }

        public async Task<DynamicModelsResponse<OrderModel>> GetAllOrder(OrderModel model, int page, int size)
        {
            model.Status = model.Status switch
            {
                "Chờ xác nhận" => "0",
                "Đang chuẩn bị hàng" => "1",
                "Chờ bên giao hàng" => "2",
                "Đã đến WareHouse 1" => "3",
                "Đang vận chuyển" => "4",
                "Đã đến WareHouse 2" => "5",
                "Đang giao hàng" => "6",
                "Đã hoàn thành" => "7",
                "Đã hủy" => "8",
                "0" => "0",
                "1" => "1",
                "2" => "2",
                "3" => "3",
                "4" => "4",
                "5" => "5",
                "6" => "6",
                "7" => "7",
                "8" => "8",
                _ => ""
            };
            var resultFilter = Get(x => !x.Payments.Any(x => x.Status == (int)PaymentEnum.Chưathanhtoán && x.PaymentTypeId != 1)).ProjectTo<OrderModel>(_mapper).DynamicFilter(model).OrderByDescending(x => x.CreateAt)
                .Select<OrderModel>(OrderModel.Fields.ToArray().ToDynamicSelector<OrderModel>())
                .PagingIQueryable(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
            var listOrder = await resultFilter.Item2.ToListAsync();
            foreach (var order in listOrder)
            {
                order.DateTimeParse = order.CreateAt?.ToString("HH:mm dd/MM/yyyy");
                string warehouseFromName = "";
                var warehouseFrom = _wareHouseService.Get(x => x.WareHouseZones.Any(y => y.ZoneId == order.Campaign.CampaignZoneId)).FirstOrDefault();
                if (warehouseFrom != null)
                    warehouseFromName = warehouseFrom.Name;
                order.Status = order.Status switch
                {
                    "0" => "Chờ xác nhận",
                    "1" => "Đang chuẩn bị hàng",
                    "2" => "Chờ bên giao hàng",
                    "3" => $"Đã đến {warehouseFromName}",
                    "4" => "Đang vận chuyển",
                    "5" => $"Đã đến Kho",
                    "6" => "Đang giao hàng",
                    "7" => "Đã hoàn thành",
                    "8" => "Đã hủy",
                    _ => ""
                };
                if (order.Status == "Đã hoàn thành")
                {
                    var farmOrder = _farmOrderService.Get(x => x.OrderId == order.Id && x.Status == (int)FarmOrderEnum.Đãhoànthành).FirstOrDefault();
                    order.Star = farmOrder.Star;
                    order.Content = farmOrder.Content;
                    order.FeedbackCreateAt = farmOrder.FeedBackCreateAt;
                }
            }
            var result = new DynamicModelsResponse<OrderModel>
            {
                Metadata = new PagingMetadata { Page = page, Size = size, Total = resultFilter.Item1 },
                Data = listOrder.ToList()
            };
            return result;
        }

        public async Task<List<WarehouseGroupModel>> GetOrderGroup(int warehouseId)
        {
            var warehouses = _wareHouseService.Get(x => x.Id != warehouseId).ProjectTo<WareHouseDataMapModel>(_mapper).ToList();
            var warehouseFrom = _wareHouseService.Get(x => x.Id == warehouseId).FirstOrDefault();
            var warehouseGroups = new List<WarehouseGroupModel>();
            var zoneOrderGroup = new List<OrderGroupZoneModel>();
            foreach (var warehouse in warehouses)
            {
                warehouseGroups.Add(new WarehouseGroupModel { WarehouseId = warehouse.Id, WarehouseAddress = warehouse.Address });
                foreach (var zone in warehouse.WareHouseZones)
                    zoneOrderGroup.Add(new OrderGroupZoneModel { ZoneId = zone.ZoneId });
            }

            foreach (var listZone in zoneOrderGroup)
            {
                var listOrderGroup = new List<OrderGroupModel>();
                var orderGroups = await Get(x => x.Status == (int)OrderEnum.ĐãđếnWareHouse1 && x.DeliveryZoneId == listZone.ZoneId && x.DriverId == null && x.ShipmentId == null).ToListAsync();

                foreach (var orderGroup in orderGroups)
                {
                    double weight = 0;
                    var order = Get(x => x.Id == orderGroup.Id).ProjectTo<OrderGroupModel>(_mapper).FirstOrDefault();
                    var data = Get(x => x.Id == orderGroup.Id).ProjectTo<OrderGroupDataModel>(_mapper).FirstOrDefault();
                    foreach (var farmOrder in data.FarmOrders)
                    {
                        foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                            weight += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                    }
                    order.Weight = weight;
                    if (weight > 100)
                    {
                        var orderEntity = Get(x => x.Id == order.Id).FirstOrDefault();
                        var rnd = new Random();
                        var code = rnd.Next(100000, 999999);
                        orderEntity.DeliveryCode = DateTime.Now.ToString("ddMMyy") + "-" + code;
                        orderEntity.Note = $"Đơn hàng của {warehouseFrom.Name} vượt quá khối lượng của xe.";
                        await UpdateAsyn(orderEntity);
                    } else
                        listOrderGroup.Add(order);
                }
                listZone.Orders = listOrderGroup;
                listZone.WeightOfZone = listOrderGroup.Sum(x => x.Weight);
            }
            var dataOrderGroups = zoneOrderGroup.Where(x => x.Orders.Count > 0).ToList();
            foreach (var warehouseGroup in warehouseGroups)
            {
                double totalWeight = 0;
                var warehouse = _wareHouseService.Get(x => x.Id == warehouseGroup.WarehouseId).ProjectTo<WareHouseDataMapModel>(_mapper).FirstOrDefault();
                var orderNew = new List<OrderGroupZoneModel>();
                foreach (var dataOrderGroup in dataOrderGroups)
                {
                    if (warehouse.WareHouseZones.Any(x => x.ZoneId == dataOrderGroup.ZoneId))
                    {
                        totalWeight += dataOrderGroup.WeightOfZone;
                        orderNew.Add(dataOrderGroup);
                    }
                }
                warehouseGroup.TotalWeight = totalWeight;
                warehouseGroup.OrderGroupZones = orderNew;
            }

            return warehouseGroups.Where(x => x.OrderGroupZones.Count > 0).ToList();
        }

        public async Task<List<OrderGroupCustomerDeliveryModel>> GetOrderGroupForDelivery(int warehouseId, bool asigned)
        {
            var warehouses = _wareHouseService.Get(x => x.Id == warehouseId).ProjectTo<WareHouseDataMapModel>(_mapper).FirstOrDefault();
            var warehouseGroups = new List<WarehouseGroupModel>();

            var listOrderGroup = new List<OrderGroupCustomerDeliveryModel>();
            foreach (var listZone in warehouses.WareHouseZones)
            {
                var orderGroups = new List<Order>();
                if (!asigned)
                    orderGroups = await Get(x => x.Status == (int)OrderEnum.ĐãđếnWareHouse2 && x.DeliveryZoneId == listZone.ZoneId && x.DriverId == null && x.ShipmentId != null).ToListAsync();
                else
                    orderGroups = await Get(x => x.Status == (int)OrderEnum.Đanggiaohàng && x.DeliveryZoneId == listZone.ZoneId && x.DriverId != null && x.ShipmentId != null).ToListAsync();
                foreach (var orderGroup in orderGroups)
                {
                    double weight = 0;
                    var order = Get(x => x.Id == orderGroup.Id).ProjectTo<OrderGroupDeliveryModel>(_mapper).FirstOrDefault();
                    var data = Get(x => x.Id == orderGroup.Id).ProjectTo<OrderGroupDataModel>(_mapper).FirstOrDefault();

                    foreach (var farmOrder in data.FarmOrders)
                    {
                        foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                            weight += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                    }
                    order.Weight = weight;
                    if (order.Weight > 100)
                    {
                        var orderEntity = Get(x => x.Id == order.Id).FirstOrDefault();
                        var rnd = new Random();
                        var code = rnd.Next(100000, 999999);
                        orderEntity.DeliveryCode = DateTime.Now.ToString("ddMMyy") + "-" + code;
                        orderEntity.Note = $"Đơn hàng của {warehouses.Name} vượt quá khối lượng của xe.";
                        await UpdateAsyn(orderEntity);
                    }
                    else
                    {

                        if (listOrderGroup.Count == 0)
                            listOrderGroup.Add(new OrderGroupCustomerDeliveryModel { Address = order.Address, Orders = new List<OrderGroupDeliveryModel> { order } });
                        else if (listOrderGroup.Count > 0 && listOrderGroup.Any(x => x.Address == order.Address))
                        {
                            var orderAdd = listOrderGroup.Where(x => x.Address == order.Address).FirstOrDefault();
                            orderAdd.Orders.Add(order);
                            listOrderGroup.Remove(new OrderGroupCustomerDeliveryModel { Address = order.Address, Orders = new List<OrderGroupDeliveryModel> { order } });
                        }
                        else
                            listOrderGroup.Add(new OrderGroupCustomerDeliveryModel { Address = order.Address, Orders = new List<OrderGroupDeliveryModel> { order } });
                    }

                }
            }

            foreach (var listOrder in listOrderGroup)
                listOrder.TotalWeight = listOrder.Orders.Sum(x => x.Weight);

            return listOrderGroup;
        }

        public async Task<OrderDetailModel> GetById(int id)
        {
            var order = await Get(x => x.Id == id).ProjectTo<OrderDetailModel>(_mapper).FirstOrDefaultAsync();
            if (order == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");
            order.DateTimeParse = order.CreateAt?.ToString("HH:mm dd/MM/yyyy");
            var orderData = Get(x => x.Id == id).ProjectTo<GetOrderDetailDataModel>(_mapper).FirstOrDefault();
            var harvestOrders = new List<ProductHarvestOrderOfDetailModel>();
            foreach (var farmOrder in orderData.FarmOrders)
            {
                farmOrder.Status = farmOrder.Status switch
                    {
                        "0" => "Chờ xác nhận",
                        "1" => "Đã xác nhận",
                        "2" => "Đang chờ xử lý",
                        "3" => "Đang bàn giao cho bên vận chuyển",
                        "4" => "Đã bàn giao cho bên vận chuyển",
                        "5" => "Đang vận chuyển",
                        "6" => "Đã hoàn thành",
                        "7" => "Đã hủy",
                        _ => ""
                    };
                foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                {
                    double? total = harvestOrder.Quantity * harvestOrder.Price;
                    
                    harvestOrders.Add(new ProductHarvestOrderOfDetailModel
                    {
                        Id = harvestOrder.Id,
                        ProductName = harvestOrder.ProductName,
                        Unit = harvestOrder.Unit,
                        Price = harvestOrder.Price,
                        Quantity = harvestOrder.Quantity,
                        HarvestCampaignId = harvestOrder.HarvestCampaignId,
                        Total = total,
                        FarmName = farmOrder.Farm.Name,
                        Phone = farmOrder.Farm.Farmer.PhoneNumber,
                        Status = farmOrder.Status,
                        Note = farmOrder.Note
                    });
                }
            }
            order.ProductHarvestOrders = harvestOrders;
            order.CampaignId = orderData.CampaignId;
            order.CampaignName = orderData.Campaign.Name;
            if (order.DriverName != null)
                order.DriverName = await _jWTService.GetNameOfUser(orderData.DriverId);
            switch (order.Status)
            {
                case "0":
                    order.Status = "Chờ xác nhận";
                    break;
                case "1":
                    order.Status = "Đang chuẩn bị hàng";
                    break;
                case "2":
                    order.Status = "Chờ bên giao hàng";
                    break;
                case "3":
                    order.Status = "Đã đến Kho";
                    break;
                case "4":
                    order.Status = "Đang vận chuyển";
                    break;
                case "5":
                    order.Status = "Đã đến Kho";
                    break;
                case "6":
                    order.Status = "Đang giao hàng";
                    break;
                case "7":
                    order.Status = "Đã hoàn thành";
                    break;
                case "8":
                    order.Status = "Đã hủy";
                    break;
                default:
                    break;
            }
            if (order.Status == "Đã hoàn thành")
            {
                var farmOrder = _farmOrderService.Get(x => x.OrderId == order.Id && x.Status == (int)FarmOrderEnum.Đãhoànthành).FirstOrDefault();
                order.Star = farmOrder.Star;
                order.Content = farmOrder.Content;
                order.FeedbackCreateAt = farmOrder.FeedBackCreateAt;
            }

            return order;
        }

        public async Task<double> ShipCostOfOrder(double productCost, string address, int campaignId)
        {
            var zone = await _tradeZoneMapService.CheckZone(address);
            var campaign = _campaignService.Get(x => x.Id == campaignId).ProjectTo<CampaignMapCampaignDeliveryZoneModel>(_mapper).FirstOrDefault();
            if (!campaign.CampaignDeliveryZones.Any(x => x.CampaignId == campaignId && x.DeliveryZoneId == zone.f4))
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Chiến dịch không hỗ trợ giao hàng tại địa chỉ này!");

            var shipCost = (productCost * 3) / 100;
            switch (shipCost)
            {
                case < 20000:
                    shipCost = 20000;
                    break;
                case > 50000:
                    shipCost = 50000;
                    break;
                default:
                    {
                        var cost = shipCost / 1000;
                        shipCost = Math.Round(cost) * 1000;
                        break;
                    }
            }
            return shipCost;
        }

        public async Task<string> Create(OrderCreateModelInput model)
        {
            var zone = await _tradeZoneMapService.CheckZone(model.Address);
            var campaign = _campaignService.Get(x => x.Id == model.CampaignId).ProjectTo<CampaignMapCampaignDeliveryZoneModel>(_mapper).FirstOrDefault();
            if (!campaign.CampaignDeliveryZones.Any(x => x.CampaignId == campaign.Id && x.DeliveryZoneId == zone.f4))
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Chiến dịch không hỗ trợ giao hàng tại địa chỉ này!");
            if (_campaignService.Get(x => x.Id == campaign.Id).FirstOrDefault().Status != (int)CampaignEnum.Đangdiễnra)
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, $"Chiến dịch chưa được mở bán hoặc đã kết thúc!");

            var date = DateTime.Now.ToString("ddMMyyyy");

            var rnd = new Random();

            var codeOrder = rnd.Next(1000,9999);
            var codeFarmOrder = rnd.Next(1000, 9999);
            var paymentCode = rnd.Next(1000, 9999);
            if (model.Name == null)
                model.Name = await _jWTService.GetNameOfUser(model.CustomerId);
            var listFarmOrder = new List<FarmOrderCreateModel>();
            var listHarvestOrder = new List<ProductHarvestOrderCreateModel>();
            var order = new OrderCreateModel()
            {
                CustomerName = model.Name,
                Address = model.Address,
                Email = model.Email,
                DeliveryZoneId = zone.f4,
                Phone = model.Phone,
                CampaignId = model.CampaignId,
                CustomerId = model.CustomerId,
            };

            var itemCartsRedises = await _redisCacheClient.Db1.GetAsync<List<ItemCartModel>>("MyList");

            var listItemCart = new List<ItemCartModel>();
            foreach (var farmOrder in model.FarmOrders)
            {
                listFarmOrder.Add(new FarmOrderCreateModel
                {
                    FarmId = farmOrder.FarmId
                });
                order.FarmOrders = listFarmOrder;

                foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                {
                    var itemCartsRedis = itemCartsRedises.Where(x => x.HarvestCampaignId == harvestOrder.HarvestCampaignId && x.CustomerId == model.CustomerId).ToList();
                    foreach (var item in itemCartsRedis)
                    {
                        listItemCart.Add(item);
                    }
                }
            }
            if (listItemCart.Count == 0)
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, "Cần có ít nhất một sản phẩm mới có thể đặt hàng!");

            foreach (var farmOrder in order.FarmOrders)
            {
                foreach (var itemCart in listItemCart)
                {
                    var harvestCampaign = _harvestCampaignService.Get(x => x.Id == itemCart.HarvestCampaignId).ProjectTo<HarvestCampaignMapItemCartModel>(_mapper).FirstOrDefault();
                    if (farmOrder.FarmId == harvestCampaign.Harvest.FarmId)
                    {
                        listHarvestOrder.Add(new ProductHarvestOrderCreateModel
                        {
                            HarvestCampaignId = itemCart.HarvestCampaignId,
                            Price = harvestCampaign.Price,
                            ProductName = harvestCampaign.ProductName,
                            Quantity = itemCart.Quantity,
                            Unit = harvestCampaign.Unit
                        });
                    }
                }
            }
            var list = new List<ProductHarvestOrderCreateModel>();
            foreach (var farmOrder in order.FarmOrders)
            {
                foreach (var harvestOrder in listHarvestOrder)
                {
                    var harvestCampaign = _harvestCampaignService.Get(x => x.Id == harvestOrder.HarvestCampaignId).ProjectTo<HarvestCampaignMappingModel>(_mapper).FirstOrDefault();
                    if (harvestCampaign.Harvest.FarmId == farmOrder.FarmId)
                        list.Add(harvestOrder);
                    else
                        list.Remove(harvestOrder);
                }
                farmOrder.ProductHarvestOrders = list.Distinct().ToList();
            }

            var entity = _mapper.CreateMapper().Map<Order>(order);
            entity.Code = "DCNC-" + date + codeOrder;

            double totalProduct = 0;
            foreach (var farmOrder in entity.FarmOrders)
            {
                farmOrder.Id = entity.Id;
                codeFarmOrder += 1;
                farmOrder.Code = "DCNF-" + date + codeFarmOrder;

                var errorsOfQuantity = new List<string>();
                foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                {
                    var harvestCampaign = _harvestCampaignService.Get(x => x.Id == harvestOrder.HarvestCampaignId).FirstOrDefault();
                    var quantity = harvestCampaign.Quantity;
                    harvestCampaign.Quantity -= harvestOrder.Quantity;
                    if (harvestCampaign.Quantity < 0)
                        errorsOfQuantity.Add($"{harvestOrder.ProductName} chỉ còn lại {quantity} ({harvestCampaign.Unit})");
                    else
                    {
                        if (harvestCampaign.Quantity == 0)
                            harvestCampaign.Status = (int)HarvestCampaignEnum.Đãhếthàng;
                        await _harvestCampaignService.UpdateAsyn(harvestCampaign);
                        harvestOrder.FarmOrderId = farmOrder.Id;
                        farmOrder.Total += (harvestOrder.Price * harvestOrder.Quantity);
                    }
                }
                if (errorsOfQuantity.Count > 0)
                    throw new ErrorResponse((int)HttpStatusCode.BadRequest, string.Join($", ", errorsOfQuantity));
                totalProduct += farmOrder.Total;
            }

            //calculate ship cost
            entity.ShipCost = (totalProduct * 3) / 100;
            if (entity.ShipCost < 20000)
                entity.ShipCost = 20000;
            else if (entity.ShipCost > 50000)
                entity.ShipCost = 50000;
            else
            {
                var cost = entity.ShipCost / 1000;
                entity.ShipCost = Math.Round(cost) * 1000;
            }
            entity.Total = totalProduct + entity.ShipCost;

            entity.Payments.Add(new Payment
            {
                Status = 0,
                Amount = (int)entity.Total,
                OrderId = entity.Id,
                Code = "DCNP-" + date + paymentCode,
                PaymentTypeId = model.PaymentTypeId,
            });
            await CreateAsyn(entity);

            if (model.PaymentTypeId == 1)
            {
                // delete itemCart
                foreach (var item in listItemCart)
                {
                    var customerName = _jWTService.GetNameOfUser(item.CustomerId).Result;
                    var harvestCampaign = _harvestCampaignService.Get(x => x.Id == item.HarvestCampaignId).ProjectTo<ProductHarvestInCampaign>(_mapper).FirstOrDefault();
                    var post = new Post {
                        ProductHarvestInCampaignId = item.HarvestCampaignId,
                        CampaignId = harvestCampaign.CampaignId,
                        CampaignName = harvestCampaign.Campaign.Name,
                        CustomerId = item.CustomerId,
                        FarmId = harvestCampaign.Harvest.FarmId,
                        FarmName = harvestCampaign.Harvest.Farm.Name,
                        ProductName = harvestCampaign.ProductName,
                        ProductImage = harvestCampaign.Harvest.Image1,
                        CreateAt = DateTime.Now,
                        Title = customerName + " đã mua " + harvestCampaign.ProductName + " từ " + campaign.Name + " tại " + harvestCampaign.Harvest.Farm.Name
                    };
                    _postService.Create(post);
                    await _itemCartService.Delete(item.CustomerId, item.HarvestCampaignId);
                }
                return "Order Successfully!";
            }
            else
            {
                var url = CreateOrderMoMoPay(entity.Code);
                return url;
            }
        }

        private string CreateOrderMoMoPay(string orderId)
        {
            string endpoint = _configuration["MoMo:endpoint"];
            string partnerCode = _configuration["MoMo:partnerCode"];
            string accessKey = _configuration["MoMo:accessKey"];
            string secretKey = _configuration["MoMo:secretKey"];
            string returnUrl = _configuration["MoMo:returnUrl"];
            string notifyUrl = _configuration["MoMo:notifyUrl"];
            string requestType = _configuration["MoMo:requestType"];

            var rnd = new Random();
            string requestId = Guid.NewGuid().ToString();

            var order = Get(x => x.Code == orderId).ProjectTo<OrderModel>(_mapper).FirstOrDefault();
            var newId = orderId.Split("-")[1];
            string orderInfo = order.Code.ToString();
            var amount = order.Total.ToString();
            var extraData = "";

            string rawHash = $"partnerCode={partnerCode}" + $"&accessKey={accessKey}" + $"&requestId={requestId}"
               + $"&amount={amount}" + $"&orderId={newId}" + $"&orderInfo={orderInfo}" + $"&returnUrl={returnUrl}"
               + $"&notifyUrl={notifyUrl}" + $"&extraData={extraData}";

            MoMoSecurity crypto = new();
            string signature = crypto.signSHA256(rawHash, secretKey);

            var message = new JObject
            {
                { "partnerCode", partnerCode },
                { "accessKey", accessKey },
                { "requestId", requestId },
                { "amount", amount },
                { "orderId", newId },
                { "orderInfo", orderInfo },
                { "returnUrl", returnUrl },
                { "notifyUrl", notifyUrl },
                { "requestType", requestType },
                { "signature", signature },
            };

            var respone = PaymentRequest.sendPaymentRequest(endpoint, message.ToString());
            var data = JObject.Parse(respone);
            return data.GetValue("payUrl").ToString();
        }

        public async Task<string> ReturnUrl(UrlReturn model)
        {
            var uri = new Uri(model.Url);
            string signatureParam = HttpUtility.ParseQueryString(uri.Query).ToString().Substring(0, HttpUtility.ParseQueryString(uri.Query).ToString().IndexOf("signature") - 1);
            signatureParam = WebUtility.UrlDecode(signatureParam);
            string secretKey = _configuration["MoMo:secretKey"];

            var crypto = new MoMoSecurity();
            string signature = crypto.signSHA256(signatureParam, secretKey);

            string orderId = HttpUtility.ParseQueryString(uri.Query).Get("orderId");
            var newId = "DCNC-" /*+ DateTime.Now.ToString("ddMMyyyy") */+ orderId;

            var oldSign = HttpUtility.ParseQueryString(uri.Query).Get("signature");
            var order = Get(x => x.Code == newId).ProjectTo<OrderPaymentModel>(_mapper).FirstOrDefault();
            if (signature != oldSign)
            {
                var orderEntity = Get(x => x.Code == newId).FirstOrDefault();
                orderEntity.Status = (int)OrderEnum.ĐãHủy;
                orderEntity.Note = "Thanh toán thất bại.";
                foreach (var farmOrder in order.FarmOrders)
                {
                    var farmOrderEntity = _farmOrderService.Get(x => x.Id == farmOrder.Id).FirstOrDefault();
                    farmOrderEntity.Status = (int)FarmOrderEnum.Đãhủy;
                    farmOrderEntity.Note = "Thanh toán thất bại.";
                    foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                    {
                        var harvestCampaignEntity = _harvestCampaignService.Get(x => x.Id == harvestOrder.HarvestCampaignId).FirstOrDefault();
                        harvestCampaignEntity.Quantity += harvestOrder.Quantity;
                        await _harvestCampaignService.UpdateAsyn(harvestCampaignEntity);
                    }
                    await _farmOrderService.UpdateAsyn(farmOrderEntity);
                }
                foreach (var payment in order.Payments)
                {
                    var paymentEntity = _paymentService.Get(x => x.Id == payment.Id).FirstOrDefault();
                    paymentEntity.Status = (int)PaymentEnum.Đãhủy;
                    await _paymentService.UpdateAsyn(paymentEntity);
                }
                await UpdateAsyn(orderEntity);
                return "Thông tin yêu cầu không hợp lệ!";
            }
            if (!HttpUtility.ParseQueryString(uri.Query).Get("errorCode").Equals("0"))
            {
                var orderEntity = Get(x => x.Code == newId).FirstOrDefault();
                orderEntity.Status = (int)OrderEnum.ĐãHủy;
                orderEntity.Note = "Thanh toán thất bại.";
                foreach (var farmOrder in order.FarmOrders)
                {
                    var farmOrderEntity = _farmOrderService.Get(x => x.Id == farmOrder.Id).FirstOrDefault();
                    farmOrderEntity.Status = (int)FarmOrderEnum.Đãhủy;
                    farmOrderEntity.Note = "Thanh toán thất bại.";
                    foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                    {
                        var harvestCampaignEntity = _harvestCampaignService.Get(x => x.Id == harvestOrder.HarvestCampaignId).FirstOrDefault();
                        harvestCampaignEntity.Quantity += harvestOrder.Quantity;
                        await _harvestCampaignService.UpdateAsyn(harvestCampaignEntity);
                    }
                    await _farmOrderService.UpdateAsyn(farmOrderEntity);
                }
                foreach (var payment in order.Payments)
                {
                    var paymentEntity = _paymentService.Get(x => x.Id == payment.Id).FirstOrDefault();
                    paymentEntity.Status = (int)PaymentEnum.Đãhủy;
                    await _paymentService.UpdateAsyn(paymentEntity);
                }
                await UpdateAsyn(orderEntity);
                return "Thanh toán thất bại!";
            }
            else
            {
                var customerId = order.CustomerId;
                var itemCarts = new List<int>();
                foreach (var farmOrder in order.FarmOrders)
                    itemCarts.AddRange(farmOrder.ProductHarvestOrders.Select(x => x.HarvestCampaignId).ToList());
                foreach (var item in itemCarts)
                {
                    var customerName = _jWTService.GetNameOfUser(customerId).Result;
                    var harvestCampaign = _harvestCampaignService.Get(x => x.Id == item).ProjectTo<ProductHarvestInCampaign>(_mapper).FirstOrDefault();
                    var post = new Post
                    {
                        ProductHarvestInCampaignId = item,
                        CampaignId = harvestCampaign.CampaignId,
                        CampaignName = harvestCampaign.Campaign.Name,
                        CustomerId = customerId,
                        FarmId = harvestCampaign.Harvest.FarmId,
                        FarmName = harvestCampaign.Harvest.Farm.Name,
                        ProductName = harvestCampaign.ProductName,
                        ProductImage = harvestCampaign.Harvest.Image1,
                        CreateAt = DateTime.Now,
                        Title = customerName + " đã mua " + harvestCampaign.ProductName + " từ " + harvestCampaign.Campaign.Name + " tại " + harvestCampaign.Harvest.Farm.Name
                    };
                    _postService.Create(post);
                    await _itemCartService.Delete(customerId, item);
                }
                foreach (var payment in order.Payments)
                {
                    var paymentEntity = _paymentService.Get(x => x.Id == payment.Id).FirstOrDefault();
                    paymentEntity.Status = (int)PaymentEnum.Đãthanhtoán;
                    await _paymentService.UpdateAsyn(paymentEntity);
                }
                return "Thanh toán thành công!";
            }
        }

        public async Task UpdateOrderStatus(int id, OrderUpdateModel model)
        {
            var entity = await GetAsyn(id);
            if (model.Id != id || entity == null)
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, $"Vui lòng nhập đúng!");
            if (entity.Status == model.Status)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Hóa đơn đang ở trạng thái: {entity.Status}!");

            var updateEntity = _mapper.CreateMapper().Map(model, entity);
            await UpdateAsyn(updateEntity);

            if (model.Status == (int)OrderEnum.ĐãHoànthành)
            {
                var farmOrderEntitys = _farmOrderService.Get(x => x.OrderId == updateEntity.Id).ToList();
                foreach (var farmOrderEntity in farmOrderEntitys)
                {
                    farmOrderEntity.Status = (int)FarmOrderEnum.Đãhoànthành;
                    await _farmOrderService.UpdateAsyn(farmOrderEntity);
                }
                var paymentEntity = _paymentService.Get(x => x.OrderId == updateEntity.Id).FirstOrDefault();
                paymentEntity.Status = (int)PaymentEnum.Đãthanhtoán;
                await _paymentService.UpdateAsyn(paymentEntity);

                string code = entity.Code;
                string campaignName = _campaignService.Get(x => x.Id == entity.CampaignId).FirstOrDefault().Name;
                string topic = "customer";
                string title = "Đơn hàng đã hoàn thành";
                string body = $"Đơn hàng {code} từ {campaignName} đã được hoàn thành.";
                await _firebaseService.SendNotification(title, body, entity.CampaignId.ToString(), topic);
                await _firebaseService.AddNotiToRedis(new NotificationModel { UserId = entity.CustomerId, Title = title, Body = body });
            }
        }

        public async Task Feedback(int id, FeedbackOrderModel model)
        {
            var order = await Get(x => x.Id == id && x.Status == (int)OrderEnum.ĐãHoànthành).ProjectTo<OrderFarmOrderModel>(_mapper).FirstOrDefaultAsync();
            if (order == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy");
            foreach (var farmOrder in order.FarmOrders.Where(x => x.Status == (int)FarmOrderEnum.Đãhoànthành))
            {
                farmOrder.Star = model.Star;
                farmOrder.Content = model.Content;
                farmOrder.FeedBackCreateAt = DateTime.Now;
                await _farmOrderService.UpdateAsyn(farmOrder);
            }
        }

        public async Task StatusOrderByTime()
        {
            var current = DateTime.Now;

            var orders = await Get(x => x.Status == (int)OrderEnum.Chờxácnhận && x.CreateAt.Value.AddHours(12) < current).ToListAsync();

            if (orders.Count == 0)
            {
                var newOrders = Get(x => x.Payments.Any(x => x.PaymentTypeId != 1 && x.Status == (int)PaymentEnum.Chưathanhtoán) && x.CreateAt.Value.AddMinutes(10) < current).ProjectTo<Order>(_mapper).ToList();
                if (newOrders.Count != 0)
                {
                    foreach (var order in newOrders)
                    {
                        order.Note = "Thanh toán thất bại.";
                        order.Status = (int)OrderEnum.ĐãHủy;
                        foreach (var farmOrder in order.FarmOrders)
                        {
                            farmOrder.Status = (int)FarmOrderEnum.Đãhủy;
                            farmOrder.Note = "Thanh toán thất bại.";
                            foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                            {
                                var harvestCampaignEntity = _harvestCampaignService.Get(x => x.Id == harvestOrder.HarvestCampaignId).FirstOrDefault();
                                harvestCampaignEntity.Quantity += harvestOrder.Quantity;
                                await _harvestCampaignService.UpdateAsyn(harvestCampaignEntity);
                            }
                            await _farmOrderService.UpdateAsyn(farmOrder);
                        }
                        foreach (var payment in order.Payments)
                        {
                            var paymentEntity = _paymentService.Get(x => x.Id == payment.Id).FirstOrDefault();
                            paymentEntity.Status = (int)PaymentEnum.Đãhủy;
                            await _paymentService.UpdateAsyn(paymentEntity);
                        }
                        await UpdateAsyn(order);
                    }
                }
            }
            if (orders.Count == 0)
            {
                var farmOrders = _farmOrderService.Get(x => x.Status == (int)FarmOrderEnum.Chờxácnhận && x.CreateAt.Value.AddHours(12) < current).ToList();
                foreach (var farmOrder in farmOrders)
                {
                    var farmOrderEntity = _farmOrderService.Get(x => x.Id == farmOrder.Id).FirstOrDefault();
                    farmOrderEntity.Status = (int)FarmOrderEnum.Đãhủy;
                    farmOrderEntity.Note = "Đơn hàng đã qua thời gian xác nhận.";
                    foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                    {
                        var harvestCampaignEntity = _harvestCampaignService.Get(x => x.Id == harvestOrder.HarvestCampaignId).FirstOrDefault();
                        harvestCampaignEntity.Quantity += harvestOrder.Quantity;
                        await _harvestCampaignService.UpdateAsyn(harvestCampaignEntity);
                    }
                    await _farmOrderService.UpdateAsyn(farmOrderEntity);
                }
            }
            else
            {
                foreach (var order in orders)
                {
                    order.Note = "Đơn hàng đã qua thời gian xác nhận.";
                    order.Status = (int)OrderEnum.ĐãHủy;
                    var orderdata = Get(x => x.Id == order.Id).ProjectTo<OrderFarmOrderModel>(_mapper).FirstOrDefault();
                    foreach (var farmOrder in orderdata.FarmOrders)
                    {
                        var farmOrderEntity = _farmOrderService.Get(x => x.Id == farmOrder.Id).FirstOrDefault();
                        farmOrderEntity.Status = (int)FarmOrderEnum.Đãhủy;
                        farmOrderEntity.Note = "Thanh toán thất bại.";
                        foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                        {
                            var harvestCampaignEntity = _harvestCampaignService.Get(x => x.Id == harvestOrder.HarvestCampaignId).FirstOrDefault();
                            harvestCampaignEntity.Quantity += harvestOrder.Quantity;
                            await _harvestCampaignService.UpdateAsyn(harvestCampaignEntity);
                        }
                        await _farmOrderService.UpdateAsyn(farmOrderEntity);
                    }
                    await UpdateAsyn(order);
                }
            }
        }

        public async Task RejectOrder(int id, string note)
        {
            var entity = Get(id);
            if (entity == null || entity.Status == (int)OrderEnum.ĐãHủy)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");

            var order = Get(x => x.Id == id).ProjectTo<OrderMappingFarmOrderModel>(_mapper).FirstOrDefault();

            entity.Status = (int)OrderEnum.ĐãHủy;
            entity.Note = note;
            foreach (var farmOrder in order.FarmOrders)
            {
                var farmOrderEntity = _farmOrderService.Get(x => x.Id == farmOrder.Id).FirstOrDefault();
                farmOrderEntity.Status = (int)FarmOrderEnum.Đãhủy;
                farmOrderEntity.Note = note;
                await _farmOrderService.UpdateAsyn(farmOrderEntity);
                foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                {
                    var harvestCampaignEntity = _harvestCampaignService.Get(x => x.Id == harvestOrder.HarvestCampaignId).FirstOrDefault();
                    harvestCampaignEntity.Quantity += harvestOrder.Quantity;
                    await _harvestCampaignService.UpdateAsyn(harvestCampaignEntity);
                }
            }

            await UpdateAsyn(entity);
            string code = entity.Code;
            string campaignName = _campaignService.Get(x => x.Id == entity.CampaignId).FirstOrDefault().Name;
            //string topic = "customer";
            string title = "Đơn hàng đã bị hủy";
            string body = $"Đơn hàng {code} từ {campaignName} đã bị hủy.";
            //await _firebaseService.SendNotification(title, body, entity.CampaignId.ToString(), topic);
            await _firebaseService.AddNotiToRedis(new NotificationModel { UserId = entity.CustomerId, Title = title, Body = body });
        }

        public async Task AssignTaskOrderForDriver(List<UpdateDriverForOrderByWarehouse> model)
        {
            foreach (var order in model)
            {
                var entitys = await Get(x => x.DeliveryCode == order.DeliveryCode).ToListAsync();
                foreach (var entity in entitys)
                {
                    entity.DriverId = order.DriverId;
                    entity.Status = (int)OrderEnum.Đanggiaohàng;
                    await UpdateAsyn(entity);
                }

                string topic = $"{order.DriverId}";
                string title = "Đơn hàng mới cần giao";
                string body = $"Đơn hàng {order.DeliveryCode} đang cần được giao.";
                await _firebaseService.SendNotification(title, body, order.DeliveryCode.ToString(), topic);
                await _firebaseService.AddNotiToRedis(new NotificationModel { UserId = order.DriverId, Title = title, Body = body });
            }
        }

        //public async Task<DynamicModelsResponse<OrderGroupDeliveryForDriverViewModel>> DeliveryToCustomerForDriver(string driverId, bool completed, int page, int size)
        //{
        //    var orderForDriver = await Get(x => x.DriverId == driverId && x.DeliveryCode != null 
        //    && (x.Status == (int)OrderEnum.Đanggiaohàng || x.Status == (int)OrderEnum.ĐãHoànthành || x.Status == (int)OrderEnum.ĐãHủy)).ProjectTo<OrderForDriverModel>(_mapper).OrderBy(x => x.Status).ToListAsync();

        //    var addressList = new List<OrderGroupForDriverViewModel>();
        //    var orderGroupDeliverys = new List<OrderGroupDeliveryForDriverViewModel>();
        //    foreach (var order in orderForDriver)
        //    {
        //        if (orderGroupDeliverys.Count == 0 || orderGroupDeliverys.Any(x => x.DeliveryCode == order.DeliveryCode))
        //        {
        //        double weights = 0;
        //        var dataOrder = Get(x => x.Id == order.Id).ProjectTo<OrderDataMapHarvestCampaignModel>(_mapper).FirstOrDefault();
        //        foreach (var farmOrder in dataOrder.FarmOrders)
        //        {
        //            foreach (var productHarvestOder in farmOrder.ProductHarvestOrders)
        //                weights += productHarvestOder.Quantity * productHarvestOder.HarvestCampaign.ValueChangeOfUnit;
        //        }
        //        order.Status = order.Status switch
        //        {
        //            "6" => "Đang giao hàng",
        //            "7" => "Đã hoàn thành",
        //            "8" => "Đã hủy",
        //            _ => ""
        //        };
        //        order.WeightOfOrder = weights;

        //        if (addressList.Count == 0)
        //            addressList.Add(new OrderGroupForDriverViewModel { Address = dataOrder.Address, Orders = new List<OrderForDriverModel>{ order } });
        //        else if (addressList.Count > 0 && addressList.Any(x => x.Address == dataOrder.Address))
        //        {
        //            var address = addressList.Where(x => x.Address == dataOrder.Address).FirstOrDefault();
        //            address.Orders.Add(order);
        //            addressList.Remove(new OrderGroupForDriverViewModel { Address = dataOrder.Address, Orders = new List<OrderForDriverModel> { order } });
        //        } 
        //        else
        //            addressList.Add(new OrderGroupForDriverViewModel { Address = dataOrder.Address, Orders = new List<OrderForDriverModel> { order } });

        //            if (orderGroupDeliverys.Count == 0)
        //                orderGroupDeliverys.Add(new OrderGroupDeliveryForDriverViewModel { DeliveryCode = dataOrder.DeliveryCode, Addresses = new List<OrderGroupForDriverViewModel> { } });
        //            else if (orderGroupDeliverys.Count > 0 && orderGroupDeliverys.Any(x => x.DeliveryCode == dataOrder.DeliveryCode))
        //                orderGroupDeliverys.Remove(new OrderGroupDeliveryForDriverViewModel { DeliveryCode = dataOrder.DeliveryCode, Addresses = new List<OrderGroupForDriverViewModel> { } });
        //            else
        //                orderGroupDeliverys.Add(new OrderGroupDeliveryForDriverViewModel { DeliveryCode = dataOrder.DeliveryCode, Addresses = new List<OrderGroupForDriverViewModel> { } });
        //        }
        //    }

        //    foreach (var orderGroupDelivery in orderGroupDeliverys)
        //    {
        //        if (!completed)
        //        {
        //            if (!addressList.All(x => x.Orders.All(y => y.Status == "Đã hoàn thành" || y.Status == "Đã hủy")))
        //            {
        //                foreach (var address in addressList)
        //                {
        //                    if (address.Orders.Any(x => x.DeliveryCode == orderGroupDelivery.DeliveryCode))
        //                    {
        //                        address.Weight = address.Orders.Sum(x => x.WeightOfOrder);
        //                        orderGroupDelivery.Addresses.Add(address);
        //                    }
        //                }
        //                orderGroupDelivery.TotalWeight = orderGroupDelivery.Addresses.Sum(x => x.Weight);
        //            }
        //            else
        //            {
        //                orderGroupDelivery.Addresses = new List<OrderGroupForDriverViewModel> { };
        //            }
        //        }
        //        else
        //        {
        //            if (addressList.All(x => x.Orders.All(y => y.Status == "Đã hoàn thành" || y.Status == "Đã hủy")))
        //            {
        //                addressList = addressList.Where(x => x.Orders.Count > 0 && x.Orders.Any(y => y.DeliveryCode == orderGroupDelivery.DeliveryCode)).ToList();
        //                foreach (var address in addressList)
        //                {
        //                    address.Weight = address.Orders.Sum(x => x.WeightOfOrder);
        //                    if (address.Orders.Any(x => x.DeliveryCode == orderGroupDelivery.DeliveryCode))
        //                        orderGroupDelivery.Addresses.Add(address);
        //                }
        //                orderGroupDelivery.TotalWeight = orderGroupDelivery.Addresses.Sum(x => x.Weight);
        //            }
        //            else
        //            {
        //                orderGroupDelivery.Addresses = new List<OrderGroupForDriverViewModel> { };
        //            }
        //        }
        //    }

        //    var listPaging = orderGroupDeliverys.Where(x => x.Addresses.Count > 0).ToList().PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
        //    var result = new DynamicModelsResponse<OrderGroupDeliveryForDriverViewModel>
        //    {
        //        Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
        //        Data = listPaging.Item2
        //    };
        //    return result;
        //}

        public bool DeliveryToCustomerForDriverBool(string deliveryCode)
        {
            var orderForDriver = Get(x => x.DeliveryCode == deliveryCode
            && (x.Status == (int)OrderEnum.Đanggiaohàng || x.Status == (int)OrderEnum.ĐãHoànthành || x.Status == (int)OrderEnum.ĐãHủy)).ProjectTo<OrderForDriverModel>(_mapper).ToList();
            if (orderForDriver.All(x => x.Status == "7" || x.Status == "8"))
                return true;
            return false;
        }

        // farmorder
        public async Task UpdateCancelFarmOrderStatus(int id, string note)
        {
            var entity = await _farmOrderService.GetAsyn(id);
            if (entity == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");
            var model = new FarmOrderUpdateCancelModel { Id = id, Status = (int)FarmOrderEnum.Đãhủy, Note = note };
            var updateEntity = _mapper.CreateMapper().Map(model, entity);
            await _farmOrderService.UpdateAsyn(updateEntity);

            var order = Get(x => x.FarmOrders.Any(x => x.Id == updateEntity.Id)).ProjectTo<OrderUpdateFarmOrderModel>(_mapper).FirstOrDefault();
            if (order.FarmOrders.All(x => x.Status == (int)FarmOrderEnum.Đãhủy))
            {
                var orderEntity = Get(x => x.Id == order.Id).FirstOrDefault();
                orderEntity.Status = (int)OrderEnum.ĐãHủy;
                var campaign = _campaignService.Get(x => x.Id == orderEntity.CampaignId).FirstOrDefault();
                //string topic = "customer";
                string title = "Đơn hàng đã bị hủy";
                string body = $"Đơn hàng {orderEntity.Code} từ {campaign.Name} đã bị hủy.";
                //await _firebaseService.SendNotification(title, body, entity.CampaignId.ToString(), topic);
                await _firebaseService.AddNotiToRedis(new NotificationModel { UserId = orderEntity.CustomerId, Title = title, Body = body });
                await UpdateAsyn(orderEntity);
            }
        }

        public async Task UpdateFarmOrderStatus(int id, string status)
        {
            var entity = await _farmOrderService.GetAsyn(id);
            if (entity == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");

            switch (status)
            {
                case "Chờ xác nhận":
                    status = "0";
                    break;
                case "Đã xác nhận":
                    status = "1";
                    break;
                case "Đang chờ xử lý":
                    status = "2";
                    break;
                case "Đang bàn giao cho bên vận chuyển":
                    status = "3";
                    break;
                case "Đã bàn giao cho bên vận chuyển":
                    status = "4";
                    break;
                case "Đang vận chuyển":
                    status = "5";
                    break;
                case "Đã hoàn thành":
                    status = "6";
                    break;
                case "Đã hủy":
                    throw new ErrorResponse((int)HttpStatusCode.BadRequest, $"Không thể cập nhật trạng thái này!");
                case "7":
                    throw new ErrorResponse((int)HttpStatusCode.BadRequest, $"Không thể cập nhật trạng thái này!");
            }

            var model = new FarmOrderUpdateModel { Id = id, Status = Int32.Parse(status) };

            var updateEntity = _mapper.CreateMapper().Map(model, entity);
            await _farmOrderService.UpdateAsyn(updateEntity);
            if (updateEntity.Status == 1)
            {
                var orderEntity = Get(x => x.FarmOrders.Any(x => x.Id == updateEntity.Id)).FirstOrDefault();
                orderEntity.Status = (int)OrderEnum.Đangchuẩnbịhàng;
                await UpdateAsyn(orderEntity);
            }
            else if (updateEntity.Status == 3)
            {
                var orderEntity = Get(x => x.FarmOrders.Any(x => x.Id == updateEntity.Id)).FirstOrDefault();
                orderEntity.Status = (int)OrderEnum.Chờbêngiaohàng;
                await UpdateAsyn(orderEntity);
            }
            else if (updateEntity.Status == 4)
            {
                var order = Get(x => x.FarmOrders.Any(x => x.Id == updateEntity.Id)).ProjectTo<OrderUpdateFarmOrderModel>(_mapper).FirstOrDefault();
                if (order.FarmOrders.All(x => x.Status == (int)FarmOrderEnum.Đãbàngiaochobênvậnchuyển || x.Status == (int)FarmOrderEnum.Đãhủy))
                {
                    var orderEntity = Get(x => x.Id == order.Id).FirstOrDefault();
                    orderEntity.Status = (int)OrderEnum.ĐãđếnWareHouse1;
                    await UpdateAsyn(orderEntity);
                }
            }
        }

        public async Task<DynamicModelsResponse<FarmOrderModel>> GetAllFarmOrder(string farmerId, FarmOrderModel model, int page, int size)
        {
            model.Status = model.Status switch
            {
                "Chờ xác nhận" => "0",
                "Đã xác nhận" => "1",
                "Đang chờ xử lý" => "2",
                "Đang bàn giao cho bên vận chuyển" => "3",
                "Đã bàn giao cho bên vận chuyển" => "4",
                "Đang vận chuyển" => "5",
                "Đã hoàn thành" => "6",
                "Đã hủy" => "7",
                "1" => "1",
                "2" => "2",
                "3" => "3",
                "4" => "4",
                "5" => "5",
                "6" => "6",
                "7" => "7",
                _ => "0"
            };

            if (farmerId == null)
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, $"Vui lòng chọn tài khoản quản lý!");

            var farmOrdersFilter = _farmOrderService.Get(x => x.Farm.FarmerId == farmerId && x.Status == Int32.Parse(model.Status) && !x.Order.Payments.Any(x => x.PaymentTypeId != 1 && x.Status == (int)PaymentEnum.Chưathanhtoán)).ProjectTo<FarmOrderModel>(_mapper)
                .DynamicFilter(model).OrderByDescending(x => x.CreateAt)
                .Select<FarmOrderModel>(FarmOrderModel.Fields.ToArray().ToDynamicSelector<FarmOrderModel>());
            var farmOrders = await farmOrdersFilter.ToListAsync();

            foreach (var farmOrder in farmOrders)
            {
                farmOrder.DateTimeParse = farmOrder.CreateAt?.ToString("HH:mm dd/MM/yyyy");
                var order = Get(x => x.Id == farmOrder.OrderId).ProjectTo<OrderMapDataPaymentType>(_mapper).FirstOrDefault();

                foreach (var payment in order.Payments)
                {
                    farmOrder.PaymentTypeName = payment.PaymentType.Name;
                    farmOrder.PaymentStatus = payment.Status switch
                    {
                        "0" => "Chưa thanh toán",
                        "1" => "Đã thanh toán",
                        "2" => "Đã huỷ",
                        _ => ""
                    };
                }

                farmOrder.CustomerName = order.CustomerName;
                farmOrder.CampaignName = order.Campaign.Name;

                farmOrder.Status = farmOrder.Status switch
                {
                    "0" => "Chờ xác nhận",
                    "1" => "Đã xác nhận",
                    "2" => "Đang chờ xử lý",
                    "3" => "Đang bàn giao cho bên vận chuyển",
                    "4" => "Đã bàn giao cho bên vận chuyển",
                    "5" => "Đang vận chuyển",
                    "6" => "Đã hoàn thành",
                    "7" => "Đã hủy",
                    _ => ""
                };
            }

            var listPaging = farmOrders.PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
            var result = new DynamicModelsResponse<FarmOrderModel>
            {
                Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
                Data = listPaging.Item2
            };
            return result;
        }

        public async Task<int> CountAllFarmOrderbyStatus(string farmerId, string status)
        {
            status = status switch
            {
                "Chờ xác nhận" => "0",
                "Đã xác nhận" => "1",
                "Đang chờ xử lý" => "2",
                "Đang bàn giao cho bên vận chuyển" => "3",
                "Đã bàn giao cho bên vận chuyển" => "4",
                "Đang vận chuyển" => "5",
                "Đã hoàn thành" => "6",
                "Đã hủy" => "7",
                "1" => "1",
                "2" => "2",
                "3" => "3",
                "4" => "4",
                "5" => "5",
                "6" => "6",
                "7" => "7",
                _ => "0"
            };
            var farmOrdersFilter = await _farmOrderService.Get(x => x.Farm.FarmerId == farmerId && x.Status == Int32.Parse(status) && !x.Order.Payments.Any(x => x.PaymentTypeId != 1 && x.Status == (int)PaymentEnum.Chưathanhtoán)).CountAsync();
            return farmOrdersFilter;
        }

        public async Task<FarmOrderDetailModel> GetFarmOrderDetail(int id)
        {
            var farmOrder = await _farmOrderService.Get(x => x.Id == id).ProjectTo<FarmOrderDetailModel>(_mapper).FirstOrDefaultAsync();
            if (farmOrder == null)
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, $"Không tìm thấy!");
            var order = Get(x => x.Id == farmOrder.OrderId).ProjectTo<OrderMapDataPaymentType>(_mapper).FirstOrDefault();

            foreach (var payment in order.Payments)
            {
                farmOrder.PaymentTypeName = payment.PaymentType.Name;
                farmOrder.PaymentStatus = payment.Status switch
                {
                    "0" => "Chưa thanh toán",
                    "1" => "Đã thanh toán",
                    "2" => "Đã huỷ",
                    _ => ""
                };
            }

            farmOrder.DateTimeParse = farmOrder.CreateAt?.ToString("HH:mm dd/MM/yyyy");
            farmOrder.CustomerName = order.CustomerName;
            farmOrder.CampaignName = order.Campaign.Name;
            farmOrder.Address = order.Address;
            farmOrder.Phone = order.Phone;

            farmOrder.Status = farmOrder.Status switch
            {
                "0" => "Chờ xác nhận",
                "1" => "Đã xác nhận",
                "2" => "Đang chờ xử lý",
                "3" => "Đang bàn giao cho bên vận chuyển",
                "4" => "Đã bàn giao cho bên vận chuyển",
                "5" => "Đang vận chuyển",
                "6" => "Đã hoàn thành",
                "7" => "Đã hủy",
                _ => ""
            };
            return farmOrder;
        }

        public async Task<List<FarmOrderGroupFarmDeliveryModel>> GetGroupFarmOrderForDelivery(int warehouseId, bool asigned)
        {
            var wareHouse = _wareHouseService.Get(x => x.Id == warehouseId).ProjectTo<WareHouseDataMapModel>(_mapper).FirstOrDefault();
            if (wareHouse == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy");
            var zones = wareHouse.WareHouseZones;

            var listGroup = new List<FarmOrderGroupFarmDeliveryModel>();
            foreach (var zoneGroup in zones)
            {
                var dataFarmOrderGroups = new List<FarmOrderDataMapToHarvestCampaignModel>();
                if (!asigned)
                    dataFarmOrderGroups =  _farmOrderService.Get(x => x.Status == (int)FarmOrderEnum.Đangbàngiaochobênvậnchuyển && x.Farm.FarmZoneId == zoneGroup.ZoneId && x.DriverId == null /*&& x.Order.Campaign.Status == (int)CampaignEnum.Đãkếtthúc*/).ProjectTo<FarmOrderDataMapToHarvestCampaignModel>(_mapper).ToList();
                else
                    dataFarmOrderGroups = await _farmOrderService.Get(x => (x.Status == (int)FarmOrderEnum.Đangbàngiaochobênvậnchuyển || x.Status == (int)FarmOrderEnum.Đãbàngiaochobênvậnchuyển) && x.Farm.FarmZoneId == zoneGroup.ZoneId && x.DriverId != null /*&& x.Order.Campaign.Status == (int)CampaignEnum.Đãkếtthúc*/).ProjectTo<FarmOrderDataMapToHarvestCampaignModel>(_mapper).ToListAsync();

                if (dataFarmOrderGroups.Count == 0)
                    return new List<FarmOrderGroupFarmDeliveryModel> { };
                foreach (var farmOrderGroup in dataFarmOrderGroups)
                {
                    var farmOrders = dataFarmOrderGroups.Where(x => x.FarmId == farmOrderGroup.FarmId).ToList();
                    var farmOrderGroupModel = new List<FarmOrderGroupModel>();
                    foreach (var farmOrder in farmOrders)
                    {
                        double weights = 0;
                        foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                            weights += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                        if (weights < 100)
                        {
                            farmOrderGroupModel.Add(new FarmOrderGroupModel { Id = farmOrder.Id, Weight = weights });
                        } else
                        {
                            var farmOrderEntity = _farmOrderService.Get(x => x.Id == farmOrder.Id).FirstOrDefault();
                            if (farmOrderEntity.CollectionCode == null || !asigned)
                            {
                                var rnd = new Random();
                                var code = rnd.Next(100000, 999999);
                                farmOrderEntity.Note = $"Đơn hàng của {wareHouse.Name} vượt quá khối lượng của xe.";
                                farmOrderEntity.CollectionCode = DateTime.Now.ToString("ddMMyy") + "-" + code;
                                await _farmOrderService.UpdateAsyn(farmOrderEntity);
                            }
                        }
                    }
                    listGroup.Add(new FarmOrderGroupFarmDeliveryModel
                    {
                        FarmId = farmOrderGroup.FarmId,
                        FarmAddress = farmOrderGroup.Farm.Address,
                        TotalWeight = farmOrderGroupModel.Sum(x => x.Weight),
                        FarmOrderGroups = farmOrderGroupModel
                    });
                }
            }

            var listResult = new List<FarmOrderGroupFarmDeliveryModel>();
            foreach (var list in listGroup)
            {
                if (listResult.Count == 0)
                    listResult.Add(list);
                else if (listResult.Count > 0 && listResult.Any(x => x.FarmId == list.FarmId))
                {
                    var count = listResult.Where(x => x.FarmId == list.FarmId).FirstOrDefault();
                    list.FarmOrderGroups.AddRange(count.FarmOrderGroups);
                }
                else
                    listResult.Add(list);
            }
            return listResult;
        }
        public async Task<List<FarmOrderDetail>> GetFarmOrderByFarm(int farmId)
        {
            var farmOrders = await _farmOrderService.Get(x => x.FarmId == farmId && x.Status == (int)FarmOrderEnum.Đangbàngiaochobênvậnchuyển).ProjectTo<FarmOrderDetail>(_mapper).ToListAsync();
            foreach (var item in farmOrders)
            {
                var data = _farmOrderService.Get(x => x.Id == item.Id).ProjectTo<FarmOrderDataMapToHarvestCampaignModel>(_mapper).FirstOrDefault();
                item.FarmName = data.Farm.Name;
                item.Phone = data.Farm.Farmer.PhoneNumber;
                item.FarmAddress = data.Farm.Address;
                if (data.DriverId != null)
                    item.DriverName = await _jWTService.GetNameOfUser(data.DriverId);
                if (item.Status == "3")
                    item.Status = "Đang bàn giao cho bên vận chuyển";
            }
            return farmOrders;
        }

        //public async Task<DynamicModelsResponse<FarmOrderGroupFarm>> GetGroupFarmOrderForDriver(string driverId, bool completed, int page, int size)
        //{
        //    var listGroup = new List<FarmOrderGroupFarm>();
        //    var listFarm = new List<FarmCollectionModel>();
        //    var farmOrderGroups = await _farmOrderService.Get(x => x.DriverId == driverId && x.CollectionCode != null
        //    && (x.Status == (int)FarmOrderEnum.Đangbàngiaochobênvậnchuyển || x.Status == (int)FarmOrderEnum.Đãbàngiaochobênvậnchuyển || x.Status == (int)FarmOrderEnum.Đãhủy)).ProjectTo<FarmOrderCollectionGroup>(_mapper).OrderBy(x => x.Status).ToListAsync();
        //    if (farmOrderGroups.Count == 0)
        //        return new DynamicModelsResponse<FarmOrderGroupFarm> { Data = new List<FarmOrderGroupFarm>(), Metadata = new PagingMetadata { Page = page, Size = size, Total = 0 } };


        //    foreach (var farmOrder in farmOrderGroups)
        //    {
        //        double weights = 0;
        //        var farm = _farmService.Get(x => x.Id == farmOrder.FarmId).ProjectTo<FarmCollectionModel>(_mapper).FirstOrDefault();
        //        farm.Phone = _jWTService.GetUserId(farm.FarmerId).Result.Phone;
        //        if (listFarm.Count == 0)
        //            listFarm.Add(farm);
        //        else if (listFarm.Count > 0 && listFarm.Any(x => x.Id == farm.Id))
        //            listFarm.Remove(farm);
        //        else
        //            listFarm.Add(farm);

        //        foreach (var productHarvestOrder in farmOrder.ProductHarvestOrders)
        //            weights += productHarvestOrder.Quantity * productHarvestOrder.HarvestCampaign.ValueChangeOfUnit;

        //        switch (listGroup.Count)
        //        {
        //            case 0:
        //                listGroup.Add(new FarmOrderGroupFarm { CollectionCode = farmOrder.CollectionCode, TotalWeight = weights });
        //                break;
        //            case > 0 when listGroup.Any(x => x.CollectionCode == farmOrder.CollectionCode):
        //                {
        //                    var group = listGroup.Where(x => x.CollectionCode == farmOrder.CollectionCode).FirstOrDefault();
        //                    group.TotalWeight += weights;
        //                    listGroup.Remove(new FarmOrderGroupFarm { CollectionCode = farmOrder.CollectionCode });
        //                }
        //                break;
        //            default:
        //                listGroup.Add(new FarmOrderGroupFarm { CollectionCode = farmOrder.CollectionCode, TotalWeight = weights });
        //                break;
        //        }
        //    }

        //    foreach (var list in listGroup)
        //    {
        //        if (!completed)
        //        {
        //            if (!listFarm.All(x => x.FarmOrders.Where(z => z.CollectionCode == list.CollectionCode).All(y => y.Status == "4" || y.Status == "7")))
        //            {
        //                foreach (var item in listFarm)
        //                {
        //                    item.FarmOrders = item.FarmOrders.Where(x => x.CollectionCode == list.CollectionCode).ToList();
        //                    foreach (var farmOrder in item.FarmOrders)
        //                    {
        //                        farmOrder.Status = farmOrder.Status switch
        //                        {
        //                            "3" => "Đang bàn giao cho bên vận chuyển",
        //                            "4" => "Đã bàn giao cho bên vận chuyển",
        //                            "7" => "Đã hủy",
        //                            _ => ""
        //                        };
        //                    }
        //                }
        //            }
        //            else
        //                listFarm = new List<FarmCollectionModel> { };
        //        }
        //        else
        //        {
        //            if (listFarm.All(x => x.FarmOrders.Where(z => z.CollectionCode == list.CollectionCode).All(y => y.Status == "4" || y.Status == "7")))
        //            {
        //                listFarm = listFarm.Where(x => x.FarmOrders.Count > 0 && x.FarmOrders.Any(y => y.CollectionCode == list.CollectionCode)).ToList();
        //                foreach (var item in listFarm)
        //                {
        //                    item.FarmOrders = item.FarmOrders.Where(x => x.CollectionCode == list.CollectionCode).ToList();
        //                    foreach (var farmOrder in item.FarmOrders)
        //                    {
        //                        farmOrder.Status = farmOrder.Status switch
        //                        {
        //                            "4" => "Đã bàn giao cho bên vận chuyển",
        //                            "7" => "Đã hủy",
        //                            _ => ""
        //                        };
        //                    }
        //                }
        //            }
        //            else
        //                listFarm = new List<FarmCollectionModel> { };
        //        }

        //        list.Farms = listFarm.Where(x => x.FarmOrders.Count > 0 && !x.FarmOrders.All(y => y.Status == "")).ToList();
        //    }

        //    var listPaging = listGroup.Where(x => x.Farms.Count > 0).ToList().PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
        //    var result = new DynamicModelsResponse<FarmOrderGroupFarm>
        //    {
        //        Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
        //        Data = listPaging.Item2
        //    };

        //    return result;
        //}

        public bool GetGroupFarmOrderForDriverBool(string collectionCode)
        {
            var farmOrderGroups = _farmOrderService.Get(x => x.CollectionCode == collectionCode
            && (x.Status == (int)FarmOrderEnum.Đangbàngiaochobênvậnchuyển || x.Status == (int)FarmOrderEnum.Đãbàngiaochobênvậnchuyển || x.Status == (int)FarmOrderEnum.Đãhủy)).ProjectTo<FarmOrderCollectionGroup>(_mapper).ToList();
            if (farmOrderGroups.All(x => x.Status == "4" || x.Status == "7"))
                return true;
            return false;
        }
        public async Task<DynamicModelsResponse<FarmOrderFeedbackViewModel>> GetFeedbackOfFarm(int farmId, int page, int size)
        {
            var farmOrders = await _farmOrderService.Get(x => x.FarmId == farmId && x.Status == (int)FarmOrderEnum.Đãhoànthành && x.FeedBackCreateAt != null).ProjectTo<FarmOrderFeedbackViewModel>(_mapper).OrderByDescending(x => x.FeedBackCreateAt).ToListAsync();
            foreach (var farmOrder in farmOrders)
            {
                var order = Get(x => x.Id == farmOrder.OrderId).ProjectTo<OrderMapCustomerDataModel>(_mapper).FirstOrDefault();
                farmOrder.CustomerName = order.Customer.Name;
                farmOrder.Image = order.Customer.Image;
            }

            var listPaging = farmOrders.PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);

            var result = new DynamicModelsResponse<FarmOrderFeedbackViewModel>
            {
                Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
                Data = listPaging.Item2
            };
            return result;
        }

        public async Task<DashBoardOfAdmin> DashBoardOfAdmin()
        {
            var countUser = _jWTService.CountUser();
            var campaigns = _campaignService.Get(x => x.Status == (int)CampaignEnum.Đangdiễnra).Count();
            var products = _productSystemService.Get(x => x.Active).Count();
            var warehouses = _wareHouseService.Get(x => x.Active).Count();
            var orders = await Get().CountAsync();

            var dashboard = new DashBoardOfAdmin
            {
                Customers = countUser.Customer,
                Campaigns = campaigns,
                Farmers = countUser.Farmer,
                Orders = orders,
                Products = products,
                WarehouseManagers = countUser.WarehouseManager,
                Warehouses = warehouses
            };

            return dashboard;
        }

        public async Task<List<CampaignStatisticalOfAdmin>> StatisticalOfAdmin()
        {
            var campaigns = await _campaignService.Get(x => x.Status == (int)CampaignEnum.Đãkếtthúc).ProjectTo<CampaignMapFarmOrder>(_mapper).ToListAsync();
            var resultCampaigns = new List<CampaignStatisticalOfAdmin>();
            foreach (var campaign in campaigns)
            {
                var farms = _farmService.Get(x => x.Active && x.ProductHarvests.Any(y => y.Active && y.ProductHarvestInCampaigns.Count > 0 && y.ProductHarvestInCampaigns.Any(z => z.Status != (int)HarvestCampaignEnum.Đãbịtừchối && z.CampaignId == campaign.Id))).Count();

                double total = 0;
                foreach (var order in campaign.Orders.Where(x => x.Status == (int)OrderEnum.ĐãHoànthành))
                    total += order.Total;
                resultCampaigns.Add(new CampaignStatisticalOfAdmin
                {
                    Id = campaign.Id,
                    Name = campaign.Name,
                    Image1 = campaign.Image1,
                    Orders = campaign.Orders.Where(x => x.Status == (int)OrderEnum.ĐãHoànthành).Count(),
                    Farms = farms,
                    TotalRevenues = total
                });
            }
            return resultCampaigns.Where(x => x.Orders > 0).ToList();
        }

        public async Task<DynamicModelsResponse<InfomationOfUserModel>> GetInfomationOfUsers(string farmerId, int page, int size)
        {
            var farmOrders = await _farmOrderService.Get(x => x.Status == (int)FarmOrderEnum.Đãhoànthành && x.Farm.FarmerId == farmerId).ProjectTo<FarmOrderMapOrderDataModel>(_mapper).ToListAsync();

            var customerIds = farmOrders.Select(x => x.Order.CustomerId).Distinct().ToList();
            var customers = new List<InfomationOfUserModel>();
            foreach (var customerId in customerIds)
            {
                var countFarmOrders = farmOrders.Where(x => x.Order.CustomerId == customerId).Count();
                var info = await _jWTService.GetUserId(customerId);
                customers.Add(new InfomationOfUserModel
                {
                    Id = info.Id,
                    Name = info.Name,
                    Image = info.Image,
                    Phone = info.Phone,
                    Email = info.Email,
                    Address = info.Address,
                    Gender = info.Gender,
                    DateOfBirth = info.DateOfBirth,
                    CountFarmOrders = countFarmOrders
                });
            }
            var listPaging = customers.PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);

            var result = new DynamicModelsResponse<InfomationOfUserModel>
            {
                Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
                Data = listPaging.Item2
            };
            return result;
        }

        public async Task<StatisticalOfFarmer> StatisticalOfFarmer(string farmerId)
        {
            var farmOrders = await _farmOrderService.Get(x => x.Status == (int)FarmOrderEnum.Đãhoànthành && x.Farm.FarmerId == farmerId).ProjectTo<FarmOrderMapOrderDataModel>(_mapper).ToListAsync();

            var customerIds = new List<CustomerOrder>();
            double totalRevenuse = 0;
            foreach (var farmOrder in farmOrders)
            {
                totalRevenuse += farmOrder.Total;

                if (customerIds.Count == 0)
                    customerIds.Add(new CustomerOrder { Id = farmOrder.Order.CustomerId });
                else if (customerIds.Count > 0 && customerIds.Any(x => x.Id == farmOrder.Order.CustomerId))
                    customerIds.Remove(new CustomerOrder { Id = farmOrder.Order.CustomerId });
                else
                    customerIds.Add(new CustomerOrder { Id = farmOrder.Order.CustomerId });
            }

            var statstical = new StatisticalOfFarmer
            {
                Customers = customerIds.Count,
                FarmOrders = farmOrders.Count,
                TotalRevenues = totalRevenuse
            };
            return statstical;
        }
    }
}
