using AutoMapper.QueryableExtensions;
using DiCho.Core.Custom;
using DiCho.Core.Utilities;
using DiCho.DataService.Commons;
using DiCho.DataService.Enums;
using DiCho.DataService.Models;
using DiCho.DataService.Response;
using DiCho.DataService.ViewModels;
using Google.OrTools.ConstraintSolver;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;

namespace DiCho.DataService.Services
{
    public partial interface IVehicleRoutingService
    {
        Task CreateShipmentForRoutingProblem1(int warehouseId);
        Task<VehicleRoutingViewModel1> VehicleRouting1(int vehicleNumber);
        Task<List<CollectionOfFarmOrderModel>> GetFarmsCollection(int warehouseId, bool assigned);
        Task<List<FarmCollectionDetailModel>> CollectionOfFarmOrderDetail(int warehouseId, string collectionCode);
        Task<List<OrderGroupCustomerDeliveryViewModel>> GetOrderToDelivery(int warehouseId, bool assigned);
        Task<List<OrderGroupCustomerViewModel>> DeliveryOfOrderDetail(int warehouseId, string deliveryCode);
        Task<DashBoardOfWarehouse> DashBoardOfWarehouse(int warehouseId);
        Task<DynamicModelsResponse<FarmOrderGroupFarm>> GetGroupFarmOrderForDriver(string driverId, bool completed, int page, int size);
        Task<DynamicModelsResponse<OrderGroupDeliveryForDriverViewModel>> DeliveryToCustomerForDriver(string driverId, bool complete, int page, int size);
        TaskOfDriverModel TasksOfDriver(string driverId);
    }

    public partial class VehicleRoutingService : IVehicleRoutingService
    {
        private readonly Microsoft.Extensions.Configuration.IConfiguration _configuration;
        private readonly AutoMapper.IConfigurationProvider _mapper;
        private readonly IOrderService _orderService;
        private readonly IFarmOrderService _farmOrderService;
        private readonly IFarmService _farmService;
        private readonly IJWTService _jWTService1;
        private readonly IWareHouseService _wareHouseService;
        private readonly IShipmentService _shipmentService;
        private readonly IShipmentDestinationService _shipmentDestinationService;
        private readonly UserManager<AspNetUsers> _userManager;

        private readonly double binCapacity = 100;

        public VehicleRoutingService(IOrderService orderService, IJWTService jWTService, IShipmentDestinationService shipmentDestinationService, Microsoft.Extensions.Configuration.IConfiguration configuration,
            UserManager<AspNetUsers> userManager, IFarmService farmService, IFarmOrderService farmOrderService, IWareHouseService wareHouseService, IShipmentService shipmentService, AutoMapper.IMapper mapper = null)
        {
            _mapper = mapper.ConfigurationProvider;
            _orderService = orderService;
            _configuration = configuration;
            _wareHouseService = wareHouseService;
            _shipmentService = shipmentService;
            _shipmentDestinationService = shipmentDestinationService;
            _farmOrderService = farmOrderService;
            _farmService = farmService;
            _jWTService1 = jWTService;
            _userManager = userManager;
        }

        public async Task CreateShipmentForRoutingProblem1(int warehouseId)
        {
            var orderGroups = await _orderService.GetOrderGroup(warehouseId);

            var warehouseFrom = _wareHouseService.Get(x => x.Id == warehouseId).FirstOrDefault();

            if (orderGroups.Count > 0)
            {
                var weights = orderGroups.Sum(x => x.TotalWeight);
                var vehicleNumberEstimate = Math.Ceiling(weights / binCapacity);

                var addresses = new Dictionary<string, double>
                {
                    { warehouseFrom.Address, 0 }
                };
                foreach (var orderGroup in orderGroups)
                    addresses.Add(orderGroup.WarehouseAddress, orderGroup.TotalWeight);

                var routingFirst = await VehicleRouting(addresses, (int)vehicleNumberEstimate);
                routingFirst.RouteOfVihicles = routingFirst.RouteOfVihicles.Where(x => x.TotalWeightOfVihicle > 0).OrderBy(x => x.Routes.Point.Count).ToList();

                var warehouseDataRouting = new List<WarehouseDataRouting>();
                int vehicleNumberActual = 0;
                int vehicleNumber = (int)vehicleNumberEstimate;
                if (routingFirst.TotalWeight <= binCapacity)
                {
                    var dataWeights = new List<double>();
                    var dataOrderIds = new List<int>();
                    var dataAddresses = orderGroups.Select(x => x.WarehouseAddress).ToList();
                    foreach (var orderGroup in orderGroups)
                    {
                        foreach (var orderGroupZone in orderGroup.OrderGroupZones)
                        {
                            dataWeights.AddRange(orderGroupZone.Orders.Select(x => x.Weight));
                            dataOrderIds.AddRange(orderGroupZone.Orders.Select(x => x.Id));
                        }
                    }
                    await _shipmentService.CreateShipment(dataWeights, dataOrderIds, dataAddresses, warehouseId);
                }
                else if (routingFirst.TotalWeight > binCapacity)
                {
                    foreach (var routeOfVihicle in routingFirst.RouteOfVihicles)
                    {
                        if (routeOfVihicle.TotalWeightOfVihicle <= binCapacity)
                        {
                            vehicleNumberActual += 1;
                            var addressesWarehouse = routeOfVihicle.Routes.Point.Keys.ToList();
                            addressesWarehouse.Remove(warehouseFrom.Address);
                            warehouseDataRouting.Add(new WarehouseDataRouting { WarehouseAddresses = addressesWarehouse });
                        }
                        else if (routeOfVihicle.TotalWeightOfVihicle > binCapacity/* && routeOfVihicle.Routes.Point.Count == 2*/)
                        {
                            var dataAddresses = routeOfVihicle.Routes.Point.Keys.ToList();
                            dataAddresses.Remove(warehouseFrom.Address);

                            var dataWeights = new List<double>();
                            var dataOrderIds = new List<int>();
                            foreach (var orderGroup in orderGroups)
                            {
                                foreach (var orderGroupZone in orderGroup.OrderGroupZones)
                                {
                                    if (dataAddresses.Any(x => x == orderGroup.WarehouseAddress))
                                    {
                                        dataWeights.AddRange(orderGroupZone.Orders.Select(x => x.Weight));
                                        dataOrderIds.AddRange(orderGroupZone.Orders.Select(x => x.Id));
                                    }
                                }
                            }
                            var binPackingNext = _orderService.BinPackingMip(dataWeights.ToArray(), dataOrderIds.ToArray());
                            vehicleNumberActual += (int)Math.Ceiling(binPackingNext.TotalBin);
                            warehouseDataRouting.Add(new WarehouseDataRouting { WarehouseAddresses = dataAddresses });
                        }
                    }
                }

                if (vehicleNumberActual > vehicleNumberEstimate && vehicleNumberActual != 0)
                {
                    var dataWeights = new List<double>();
                    var dataOrderIds = new List<int>();
                    foreach (var orderGroup in orderGroups)
                    {
                        foreach (var orderGroupZone in orderGroup.OrderGroupZones)
                        {
                            dataWeights.AddRange(orderGroupZone.Orders.Select(x => x.Weight));
                            dataOrderIds.AddRange(orderGroupZone.Orders.Select(x => x.Id));
                        }
                    }
                    var binPacking = _orderService.BinPackingMip(dataWeights.ToArray(), dataOrderIds.ToArray());

                    var date = DateTime.Now.ToString("ddMMyyyy");

                    var random = new Random();
                    var code = random.Next(1000, 9999);
                    foreach (var bin in binPacking.BinResult)
                    {
                        var addressesWarehouse = new Dictionary<string, double>
                    {
                        { warehouseFrom.Address, 0 }
                    };
                        var orderIds = bin.BinDetail.Items;
                        foreach (var orderId in orderIds)
                        {
                            var add = orderGroups.Where(x => x.OrderGroupZones.Any(y => y.Orders.Any(z => z.Id == orderId))).FirstOrDefault().WarehouseAddress;
                            if (addressesWarehouse.Keys.ToList().All(x => x != add))
                                addressesWarehouse.Add(add, 0);
                        }

                        var routing = await VehicleRouting(addressesWarehouse, 1);
                        foreach (var routeOfVihicle in routing.RouteOfVihicles)
                        {
                            var dataAddress = routeOfVihicle.Routes.Point.Keys.ToList();
                            dataAddress.Remove(warehouseFrom.Address);

                            code += 1;
                            var model = new ShipmentCreateModel
                            {
                                Code = "DCNS-" + date + code,
                                From = warehouseFrom.Address,
                                TotalWeight = bin.BinDetail.TotalWeight,
                                WarehouseId = warehouseFrom.Id
                            };
                            var entity = _mapper.CreateMapper().Map<Shipment>(model);
                            await _shipmentService.CreateAsyn(entity);

                            foreach (var item in bin.BinDetail.Items)
                            {
                                var order = _orderService.Get(x => x.Id == item).FirstOrDefault();
                                order.ShipmentId = entity.Id;
                                await _orderService.UpdateAsyn(order);
                            }
                            foreach (var address in dataAddress)
                            {
                                var shipmentDestination = new ShipmentDestinationCreateModel { ShipmentId = entity.Id, Address = address };
                                var shipmentDestinationEntity = _mapper.CreateMapper().Map<ShipmentDestination>(shipmentDestination);
                                await _shipmentDestinationService.CreateAsyn(shipmentDestinationEntity);
                            }
                        }
                    }
                }
                else if (vehicleNumberActual <= vehicleNumberEstimate && vehicleNumberActual != 0)
                {
                    foreach (var warehouseAddress in warehouseDataRouting)
                    {
                        var dataOrderGroups = orderGroups.Where(x => warehouseAddress.WarehouseAddresses.Any(y => y == x.WarehouseAddress));

                        var dataWeights = new List<double>();
                        var dataOrderIds = new List<int>();
                        var dataAddresses = warehouseAddress.WarehouseAddresses;
                        foreach (var dataOrderGroup in dataOrderGroups)
                        {
                            foreach (var orderGroupZone in dataOrderGroup.OrderGroupZones)
                            {
                                dataWeights.AddRange(orderGroupZone.Orders.Select(x => x.Weight));
                                dataOrderIds.AddRange(orderGroupZone.Orders.Select(x => x.Id));
                            }
                        }
                        if (dataWeights.Sum() > binCapacity)
                        {
                            var binPacking = _orderService.BinPackingMip(dataWeights.ToArray(), dataOrderIds.ToArray());

                            var date = DateTime.Now.ToString("ddMMyyyy");

                            var random = new Random();
                            var code = random.Next(1000, 9999);
                            foreach (var bin in binPacking.BinResult)
                            {
                                var addressesWarehouse = new Dictionary<string, double>
                            {
                                { warehouseFrom.Address, 0 }
                            };
                                var orderIds = bin.BinDetail.Items;
                                foreach (var orderId in orderIds)
                                {
                                    var add = orderGroups.Where(x => x.OrderGroupZones.Any(y => y.Orders.Any(z => z.Id == orderId))).FirstOrDefault().WarehouseAddress;
                                    if (addressesWarehouse.Keys.ToList().All(x => x != add))
                                        addressesWarehouse.Add(add, 0);
                                }

                                var routing = await VehicleRouting(addressesWarehouse, 1);
                                foreach (var routeOfVihicle in routing.RouteOfVihicles)
                                {
                                    var dataAddress = routeOfVihicle.Routes.Point.Keys.ToList();
                                    dataAddress.Remove(warehouseFrom.Address);

                                    code += 1;
                                    var model = new ShipmentCreateModel
                                    {
                                        Code = "DCNS-" + date + code,
                                        From = warehouseFrom.Address,
                                        TotalWeight = bin.BinDetail.TotalWeight,
                                        WarehouseId = warehouseFrom.Id
                                    };
                                    var entity = _mapper.CreateMapper().Map<Shipment>(model);
                                    await _shipmentService.CreateAsyn(entity);

                                    foreach (var item in bin.BinDetail.Items)
                                    {
                                        var order = _orderService.Get(x => x.Id == item).FirstOrDefault();
                                        order.ShipmentId = entity.Id;
                                        await _orderService.UpdateAsyn(order);
                                    }
                                    foreach (var address in dataAddress)
                                    {
                                        var shipmentDestination = new ShipmentDestinationCreateModel { ShipmentId = entity.Id, Address = address };
                                        var shipmentDestinationEntity = _mapper.CreateMapper().Map<ShipmentDestination>(shipmentDestination);
                                        await _shipmentDestinationService.CreateAsyn(shipmentDestinationEntity);
                                    }
                                }
                            }
                        }
                        else
                        {
                            await _shipmentService.CreateShipment(dataWeights, dataOrderIds, dataAddresses, warehouseId);
                        }
                    }
                }
            }

            var orderOverWights = _orderService.Get(x => x.Note == $"Đơn hàng của {warehouseFrom.Name} vượt quá khối lượng của xe." && x.ShipmentId == null && x.Status == (int)OrderEnum.ĐãđếnWareHouse1).ProjectTo<OrderGroupDataModel>(_mapper).ToList();
            if (orderOverWights.Count > 0)
            {
                foreach (var orderOverWight in orderOverWights)
                {
                    double weight = 0;
                    foreach (var farmOrder in orderOverWight.FarmOrders)
                    {
                        foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                            weight += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                    }

                    var date = DateTime.Now.ToString("ddMMyyyy");
                    var random = new Random();
                    var code = random.Next(1000, 9999);

                    var warehouseTo = _wareHouseService.Get(x => x.WareHouseZones.Any(x => x.ZoneId == orderOverWight.DeliveryZoneId)).FirstOrDefault();

                    var model = new ShipmentCreateModel
                    {
                        Code = "DCNS-" + date + code,
                        From = warehouseFrom.Address,
                        TotalWeight = weight,
                        WarehouseId = warehouseFrom.Id,
                    };
                    var entity = _mapper.CreateMapper().Map<Shipment>(model);
                    await _shipmentService.CreateAsyn(entity);

                    var orderEntity = _orderService.Get(x => x.Id == orderOverWight.Id).FirstOrDefault();
                    orderEntity.ShipmentId = entity.Id;
                    entity.ShipmentDestinations = new List<ShipmentDestination> { new ShipmentDestination { Address = warehouseTo.Address, ShipmentId = entity.Id } };
                    await _orderService.UpdateAsyn(orderEntity);
                }
            }

            if (orderOverWights.Count == 0 && orderGroups.Count == 0)
                throw new ErrorResponse((int)HttpStatusCode.BadRequest, $"Không có đơn hàng nào cần được tạo chuyến hàng!");
        }

        public async Task<List<CollectionOfFarmOrderModel>> GetFarmsCollection(int warehouseId, bool assigned)
        {
            var farmGroups = await _orderService.GetGroupFarmOrderForDelivery(warehouseId, assigned);
            if (farmGroups.Count == 0)
                return new List<CollectionOfFarmOrderModel> { };
            var warehouseFrom = _wareHouseService.Get(x => x.Id == warehouseId).FirstOrDefault();
            if (assigned)
            {
                var collections = new List<CollectionOfFarmOrderModel>();
                foreach (var farmGroup in farmGroups)
                {
                    foreach (var farmOrder in farmGroup.FarmOrderGroups)
                    {
                        var farmOrderData = _farmOrderService.Get(x => x.Id == farmOrder.Id).ProjectTo<FarmOrderMapToGroupModel>(_mapper).FirstOrDefault();
                        var farm = _farmService.Get(x => x.Id == farmOrderData.FarmId).ProjectTo<FarmMapDataToViewGroupFarmOrder>(_mapper).FirstOrDefault();
                        farm.FarmOrders = farm.FarmOrders.Where(x => x.CollectionCode == farmOrderData.CollectionCode).ToList();
                        double weights = 0;
                        foreach (var farmOrderWeight in farm.FarmOrders)
                        {
                            var farmOrderWeightData = _farmOrderService.Get(x => x.Id == farmOrderWeight.Id).ProjectTo<FarmOrderDataMapToHarvestCampaignModel>(_mapper).FirstOrDefault();
                            foreach (var harvestOrder in farmOrderWeightData.ProductHarvestOrders)
                                weights += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                        }
                        if (collections.Count == 0)
                            collections.Add(new CollectionOfFarmOrderModel { CollectionCode = farmOrderData.CollectionCode, TotalWeight = weights, Farms = new List<FarmMapDataToViewGroupFarmOrder> { farm }, DriverId = farmOrderData.DriverId, DriverName = _jWTService1.GetNameOfUser(farmOrderData.DriverId).Result });
                        else if (collections.Count > 0 && !collections.Any(x => x.CollectionCode == farmOrderData.CollectionCode))
                            collections.Add(new CollectionOfFarmOrderModel { CollectionCode = farmOrderData.CollectionCode, TotalWeight = weights, Farms = new List<FarmMapDataToViewGroupFarmOrder> { farm }, DriverId = farmOrderData.DriverId, DriverName = _jWTService1.GetNameOfUser(farmOrderData.DriverId).Result });
                        else
                        {
                            var collectionData = collections.Where(x => x.CollectionCode == farmOrderData.CollectionCode).FirstOrDefault();
                            if (collectionData.Farms.Count == 0)
                                collectionData.Farms.Add(farm);
                            else if (collectionData.Farms.Count > 0 && !collectionData.Farms.Any(x => x.Id == farm.Id))
                            {
                                collectionData.Farms.Add(farm);
                                collectionData.TotalWeight += weights;
                            }
                        }
                    }
                }

                var farmOrderOverWights = _farmOrderService.Get(x => x.Note == $"Đơn hàng của {warehouseFrom.Name} vượt quá khối lượng của xe." && x.DriverId != null && (x.Status == (int)FarmOrderEnum.Đangbàngiaochobênvậnchuyển || x.Status == (int)FarmOrderEnum.Đãbàngiaochobênvậnchuyển)).ProjectTo<FarmOrderDetailModel>(_mapper).ToList();
                if (farmOrderOverWights.Count > 0)
                {
                    foreach (var farmOrderOverWight in farmOrderOverWights)
                    {
                        var farmOrderData = _farmOrderService.Get(x => x.Id == farmOrderOverWight.Id).ProjectTo<FarmOrderMapToGroupModel>(_mapper).FirstOrDefault();
                        var farm = _farmService.Get(x => x.Id == farmOrderData.FarmId).ProjectTo<FarmMapDataToViewGroupFarmOrder>(_mapper).FirstOrDefault();
                        farm.FarmOrders = farm.FarmOrders.Where(x => x.CollectionCode == farmOrderData.CollectionCode).ToList();
                        double weights = 0;
                        foreach (var farmOrderWeight in farm.FarmOrders)
                        {
                            var farmOrderWeightData = _farmOrderService.Get(x => x.Id == farmOrderWeight.Id).ProjectTo<FarmOrderDataMapToHarvestCampaignModel>(_mapper).FirstOrDefault();
                            foreach (var harvestOrder in farmOrderWeightData.ProductHarvestOrders)
                                weights += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                        }
                        collections.Add(new CollectionOfFarmOrderModel { Flag = true, CollectionCode = farmOrderData.CollectionCode, TotalWeight = weights, Farms = new List<FarmMapDataToViewGroupFarmOrder> { farm }, DriverId = farmOrderData.DriverId, DriverName = _jWTService1.GetNameOfUser(farmOrderData.DriverId).Result });
                    }
                }

                foreach (var collection in collections)
                {
                    if (collection.Farms.All(x => x.FarmOrders.All(y => y.Status == "4")))
                        collection.Status = "Đã bàn giao cho bên vận chuyển";
                    else
                        collection.Status = "Đang bàn giao cho bên vận chuyển";

                }
                return collections;
            }
            else
            {
                var weights = farmGroups.Sum(x => x.TotalWeight);
                var vehicleNumberEstimate = Math.Ceiling(weights / binCapacity);

                var addresses = new Dictionary<string, double>
                {
                    { warehouseFrom.Address, 0 }
                };
                foreach (var farmGroup in farmGroups)
                    addresses.Add(farmGroup.FarmAddress, farmGroup.TotalWeight);

                var routingFirst = await VehicleRouting(addresses, (int)vehicleNumberEstimate);
                routingFirst.RouteOfVihicles = routingFirst.RouteOfVihicles.Where(x => x.TotalWeightOfVihicle > 0).ToList();

                int vehicleNumberActual = 0;
                var farmDataRoutings = new List<FarmDataRouting>();
                var collections = new List<CollectionOfFarmOrderModel>();
                if (routingFirst.TotalWeight <= binCapacity)
                {
                    var dataReturn = new CollectionOfFarmOrderModel();
                    var dataFarmIds = farmGroups.Select(x => x.FarmId);
                    var dataFarmOrdersIds = new List<int>();

                    foreach (var farmGroup in farmGroups)
                        dataFarmOrdersIds.AddRange(farmGroup.FarmOrderGroups.Select(x => x.Id));
                    var rnd = new Random();
                    var code = rnd.Next(100000, 999999);
                    foreach (var farmOrderId in dataFarmOrdersIds)
                    {
                        var entityFarmOrder = _farmOrderService.Get(x => x.Id == farmOrderId).FirstOrDefault();
                        var collectionCode = DateTime.Now.ToString("ddMMyy") + "-" + code;
                        entityFarmOrder.CollectionCode = collectionCode;
                        await _farmOrderService.UpdateAsyn(entityFarmOrder);
                    }

                    var farms = new List<FarmMapDataToViewGroupFarmOrder>();
                    foreach (var farmId in dataFarmIds)
                    {
                        var farm = _farmService.Get(x => x.Id == farmId).ProjectTo<FarmMapDataToViewGroupFarmOrder>(_mapper).FirstOrDefault();
                        var farmOrder = new List<FarmOrderMapToGroupModel>();
                        foreach (var farmOrderId in dataFarmOrdersIds)
                        {
                            var dataFarmOrder = _farmOrderService.Get(x => x.Id == farmOrderId).ProjectTo<FarmOrderMapToGroupModel>(_mapper).FirstOrDefault();
                            dataReturn.CollectionCode = dataFarmOrder.CollectionCode;
                            if (dataFarmOrder.FarmId == farmId)
                                farmOrder.Add(dataFarmOrder);
                        }
                        farm.FarmOrders = farmOrder;
                        farms.Add(farm);
                    }
                    dataReturn.TotalWeight = weights;
                    dataReturn.Farms = farms;
                    dataReturn.Status = "Đang bàn giao cho bên vận chuyển";
                    collections.Add(dataReturn);
                }
                else if (routingFirst.TotalWeight > binCapacity)
                {
                    foreach (var routeOfVihicle in routingFirst.RouteOfVihicles)
                    {
                        if (routeOfVihicle.TotalWeightOfVihicle <= binCapacity)
                        {
                            var farmRouting = routeOfVihicle.Routes.Point;
                            farmRouting.Remove(warehouseFrom.Address);
                            farmDataRoutings.Add(new FarmDataRouting { FarmRouting = farmRouting });

                            vehicleNumberActual += 1;
                        }
                        else if (routeOfVihicle.TotalWeightOfVihicle > binCapacity)
                        {
                            var farmRouting = routeOfVihicle.Routes.Point;
                            farmRouting.Remove(warehouseFrom.Address);

                            var dataWeights = new List<double>();
                            var dataFarmOrderIds = new List<int>();
                            foreach (var farmGroup in farmGroups)
                            {
                                foreach (var farmOrderGroup in farmGroup.FarmOrderGroups)
                                {
                                    if (farmRouting.Keys.ToList().Any(x => x == farmGroup.FarmAddress))
                                    {
                                        dataWeights.Add(farmOrderGroup.Weight);
                                        dataFarmOrderIds.Add(farmOrderGroup.Id);
                                    }
                                }
                            }
                            farmDataRoutings.Add(new FarmDataRouting { FarmRouting = farmRouting });
                            var binPackingNext = _orderService.BinPackingMip(dataWeights.ToArray(), dataFarmOrderIds.ToArray());

                            vehicleNumberActual += (int)Math.Ceiling(binPackingNext.TotalBin);
                        }
                    }
                }

                if (vehicleNumberActual > vehicleNumberEstimate && vehicleNumberActual != 0)
                {
                    var dataWeights = new List<double>();
                    var dataFarmOrderIds = new List<int>();
                    foreach (var farmGroup in farmGroups)
                    {
                        foreach (var farmOrderGroup in farmGroup.FarmOrderGroups)
                        {
                            dataWeights.Add(farmOrderGroup.Weight);
                            dataFarmOrderIds.Add(farmOrderGroup.Id);
                        }
                    }
                    var binPacking = _orderService.BinPackingMip(dataWeights.ToArray(), dataFarmOrderIds.ToArray());

                    foreach (var bin in binPacking.BinResult)
                    {
                        var dataReturn = new CollectionOfFarmOrderModel();
                        var rnd = new Random();
                        var code = rnd.Next(100000, 999999);
                        var addressesWarehouse = new Dictionary<string, double>
                    {
                        { warehouseFrom.Address, 0 }
                    };
                        var farmOrderIds = bin.BinDetail.Items;

                        foreach (var farmOrderId in farmOrderIds)
                        {
                            var add = farmGroups.Where(x => x.FarmOrderGroups.Any(y => y.Id == farmOrderId)).FirstOrDefault();
                            if (addressesWarehouse.Keys.ToList().All(x => x != add.FarmAddress))
                                addressesWarehouse.Add(add.FarmAddress, (double)add.FarmId);
                        }

                        var routing = await VehicleRouting(addressesWarehouse, 1);
                        foreach (var routeOfVihicle in routing.RouteOfVihicles)
                        {
                            var dataRouting = routeOfVihicle.Routes.Point;
                            dataRouting.Remove(warehouseFrom.Address);

                            var dataFarmIds = dataRouting.Values;
                            var farms = new List<FarmMapDataToViewGroupFarmOrder>();
                            foreach (var farmId in dataFarmIds)
                            {
                                var farm = _farmService.Get(x => x.Id == (int)farmId).ProjectTo<FarmMapDataToViewGroupFarmOrder>(_mapper).FirstOrDefault();
                                var farmOrder = new List<FarmOrderMapToGroupModel>();
                                foreach (var farmOrderId in farmOrderIds)
                                {
                                    var dataFarmOrder = _farmOrderService.Get(x => x.Id == farmOrderId && x.FarmId == farmId).ProjectTo<FarmOrderMapToGroupModel>(_mapper).FirstOrDefault();
                                    if (dataFarmOrder != null)
                                    {
                                        var entityFarmOrder = _farmOrderService.Get(x => x.Id == farmOrderId && x.FarmId == farmId).FirstOrDefault();
                                        var collectionCode = DateTime.Now.ToString("ddMMyy") + "-" + code;
                                        entityFarmOrder.CollectionCode = collectionCode;
                                        await _farmOrderService.UpdateAsyn(entityFarmOrder);
                                        dataFarmOrder.CollectionCode = collectionCode;
                                        farmOrder.Add(dataFarmOrder);
                                    }
                                }
                                farm.FarmOrders = farmOrder;
                                farms.Add(farm);
                            }
                            dataReturn.Farms = farms;
                            dataReturn.CollectionCode = farms.Select(x => x.FarmOrders.Select(y => y.CollectionCode).FirstOrDefault()).FirstOrDefault();
                        }
                        dataReturn.TotalWeight = bin.BinDetail.TotalWeight;
                        dataReturn.Status = "Đang bàn giao cho bên vận chuyển";
                        collections.Add(dataReturn);
                    }
                }
                else if (vehicleNumberActual <= vehicleNumberEstimate && vehicleNumberActual != 0)
                {
                    foreach (var farmDataRouting in farmDataRoutings)
                    {
                        double weightOfRoute = 0;
                        foreach (var weight in farmDataRouting.FarmRouting.Values)
                        {
                            weightOfRoute += weight;
                        }
                        if (weightOfRoute > binCapacity)
                        {
                            var dataFarmOrderGroups = farmGroups.Where(x => farmDataRouting.FarmRouting.Keys.Any(y => y == x.FarmAddress));

                            var dataFarmIds = new List<int?>();
                            var dataFarmOrdersIds = new List<int>();
                            var dataWeights = new List<double>();

                            foreach (var farmGroup in dataFarmOrderGroups)
                            {
                                dataFarmIds.Add(farmGroup.FarmId);
                                dataWeights.AddRange(farmGroup.FarmOrderGroups.Select(x => x.Weight));
                                dataFarmOrdersIds.AddRange(farmGroup.FarmOrderGroups.Select(x => x.Id));
                            }

                            var binPacking = _orderService.BinPackingMip(dataWeights.ToArray(), dataFarmOrdersIds.ToArray());

                            foreach (var bin in binPacking.BinResult)
                            {
                                var dataReturn = new CollectionOfFarmOrderModel();
                                var rnd = new Random();
                                var code = rnd.Next(100000, 999999);
                                var farmOrderIds = bin.BinDetail.Items;
                                var farmIds = new List<int?>();
                                foreach (var farmOrderId in farmOrderIds)
                                {
                                    var farmId = _farmOrderService.Get(x => x.Id == farmOrderId).FirstOrDefault().FarmId;
                                    if (farmIds.Count == 0)
                                        farmIds.Add(farmId);
                                    else if (farmIds.Count > 0 && !farmIds.Any(x => x == farmId))
                                        farmIds.Add(farmId);
                                }

                                var farms = new List<FarmMapDataToViewGroupFarmOrder>();
                                foreach (var farmId in farmIds)
                                {
                                    var farm = _farmService.Get(x => x.Id == farmId).ProjectTo<FarmMapDataToViewGroupFarmOrder>(_mapper).FirstOrDefault();
                                    var farmOrder = new List<FarmOrderMapToGroupModel>();
                                    foreach (var farmOrderId in farmOrderIds)
                                    {
                                        var entityFarmOrder = _farmOrderService.Get(x => x.Id == farmOrderId).FirstOrDefault();

                                        var collectionCode = DateTime.Now.ToString("ddMMyy") + "-" + code;
                                        entityFarmOrder.CollectionCode = collectionCode;
                                        await _farmOrderService.UpdateAsyn(entityFarmOrder);
                                        var dataFarmOrder = _farmOrderService.Get(x => x.Id == farmOrderId).ProjectTo<FarmOrderMapToGroupModel>(_mapper).FirstOrDefault();
                                        if (dataFarmOrder.FarmId == farmId)
                                            farmOrder.Add(dataFarmOrder);
                                    }
                                    farm.FarmOrders = farmOrder;
                                    farms.Add(farm);
                                }
                                dataReturn.TotalWeight = bin.BinDetail.TotalWeight;
                                dataReturn.Farms = farms;
                                dataReturn.CollectionCode = farms.Select(x => x.FarmOrders.Select(y => y.CollectionCode).FirstOrDefault()).FirstOrDefault();
                                dataReturn.Status = "Đang bàn giao cho bên vận chuyển";
                                collections.Add(dataReturn);
                            }
                        }
                        else
                        {
                            var rnd = new Random();
                            var code = rnd.Next(100000, 999999);
                            var dataReturn = new CollectionOfFarmOrderModel();
                            var dataFarmOrderGroups = farmGroups.Where(x => farmDataRouting.FarmRouting.Keys.Any(y => y == x.FarmAddress));

                            var dataFarmIds = new List<int?>();
                            var dataFarmOrdersIds = new List<int>();

                            foreach (var farmGroup in dataFarmOrderGroups)
                            {
                                dataFarmIds.Add(farmGroup.FarmId);
                                dataFarmOrdersIds.AddRange(farmGroup.FarmOrderGroups.Select(x => x.Id));
                            }

                            var farms = new List<FarmMapDataToViewGroupFarmOrder>();
                            foreach (var farmId in dataFarmIds)
                            {
                                var farm = _farmService.Get(x => x.Id == farmId).ProjectTo<FarmMapDataToViewGroupFarmOrder>(_mapper).FirstOrDefault();
                                var farmOrder = new List<FarmOrderMapToGroupModel>();
                                foreach (var farmOrderId in dataFarmOrdersIds)
                                {
                                    var entityFarmOrder = _farmOrderService.Get(x => x.Id == farmOrderId).FirstOrDefault();
                                    var collectionCode = DateTime.Now.ToString("ddMMyy") + "-" + code;
                                    entityFarmOrder.CollectionCode = collectionCode;
                                    await _farmOrderService.UpdateAsyn(entityFarmOrder);
                                    var dataFarmOrder = _farmOrderService.Get(x => x.Id == farmOrderId).ProjectTo<FarmOrderMapToGroupModel>(_mapper).FirstOrDefault();
                                    if (dataFarmOrder.FarmId == farmId)
                                        farmOrder.Add(dataFarmOrder);
                                }
                                farm.FarmOrders = farmOrder;
                                farms.Add(farm);
                            }
                            dataReturn.TotalWeight = weightOfRoute;
                            dataReturn.Farms = farms;
                            dataReturn.CollectionCode = farms.Select(x => x.FarmOrders.Select(y => y.CollectionCode).FirstOrDefault()).FirstOrDefault();
                            dataReturn.Status = "Đang bàn giao cho bên vận chuyển";
                            collections.Add(dataReturn);
                        }
                    }
                }

                var farmOrderOverWights = _farmOrderService.Get(x => x.Note == $"Đơn hàng của {warehouseFrom.Name} vượt quá khối lượng của xe." && x.DriverId == null && x.Status == (int)FarmOrderEnum.Đangbàngiaochobênvậnchuyển).ProjectTo<FarmOrderDetailModel>(_mapper).ToList();
                if (farmOrderOverWights.Count > 0)
                {
                    foreach (var farmOrderOverWight in farmOrderOverWights)
                    {
                        var farmOrderData = _farmOrderService.Get(x => x.Id == farmOrderOverWight.Id).ProjectTo<FarmOrderMapToGroupModel>(_mapper).FirstOrDefault();
                        var farm = _farmService.Get(x => x.Id == farmOrderData.FarmId).ProjectTo<FarmMapDataToViewGroupFarmOrder>(_mapper).FirstOrDefault();
                        farm.FarmOrders = farm.FarmOrders.Where(x => x.CollectionCode == farmOrderData.CollectionCode).ToList();
                        double weight = 0;
                        foreach (var farmOrderWeight in farm.FarmOrders)
                        {
                            var farmOrderWeightData = _farmOrderService.Get(x => x.Id == farmOrderWeight.Id).ProjectTo<FarmOrderDataMapToHarvestCampaignModel>(_mapper).FirstOrDefault();
                            foreach (var harvestOrder in farmOrderWeightData.ProductHarvestOrders)
                                weight += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                        }
                        collections.Add(new CollectionOfFarmOrderModel { Flag = true, CollectionCode = farmOrderData.CollectionCode, TotalWeight = weight, Farms = new List<FarmMapDataToViewGroupFarmOrder> { farm }, Status = "Đang bàn giao cho bên vận chuyển" });
                    }
                }

                return collections;
            }

        }

        public async Task<List<OrderGroupCustomerDeliveryViewModel>> GetOrderToDelivery(int warehouseId, bool assigned)
        {
            var orderGroups = await _orderService.GetOrderGroupForDelivery(warehouseId, assigned);
            if (orderGroups.Count == 0)
                return new List<OrderGroupCustomerDeliveryViewModel> { };
            var warehouseFrom = _wareHouseService.Get(x => x.Id == warehouseId).FirstOrDefault();
            if (assigned)
            {
                var deliverys = new List<OrderGroupCustomerDeliveryViewModel>();
                foreach (var orderGroup in orderGroups)
                {
                    foreach (var order in orderGroup.Orders)
                    {
                        var orderData = _orderService.Get(x => x.Id == order.Id).ProjectTo<OrderGroupDeliveryViewModel>(_mapper).FirstOrDefault();
                        var orderDataWeight = _orderService.Get(x => x.Id == order.Id).ProjectTo<OrderGroupDataModel>(_mapper).FirstOrDefault();
                        foreach (var farmOrder in orderDataWeight.FarmOrders)
                        {
                            foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                                orderData.WeightOfOrder += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                        }
                        if (deliverys.Count == 0)
                            deliverys.Add(new OrderGroupCustomerDeliveryViewModel { DeliveryCode = orderData.DeliveryCode, Addresses = new List<OrderGroupCustomerViewModel> { new OrderGroupCustomerViewModel { Address = orderData.Address, Weight = orderData.WeightOfOrder, Orders = new List<OrderGroupDeliveryViewModel> { orderData } } }, DriverId = orderData.DriverId, DriverName = _jWTService1.GetNameOfUser(orderData.DriverId).Result, Status = "Đang giao hàng" });
                        else if (deliverys.Count > 0 && !deliverys.Any(x => x.DeliveryCode == orderData.DeliveryCode))
                            deliverys.Add(new OrderGroupCustomerDeliveryViewModel { DeliveryCode = orderData.DeliveryCode, Addresses = new List<OrderGroupCustomerViewModel> { new OrderGroupCustomerViewModel { Address = orderData.Address, Weight = orderData.WeightOfOrder, Orders = new List<OrderGroupDeliveryViewModel> { orderData } } }, DriverId = orderData.DriverId, DriverName = _jWTService1.GetNameOfUser(orderData.DriverId).Result, Status = "Đang giao hàng" });
                        else
                        {
                            var deliverysData = deliverys.Where(x => x.DeliveryCode == orderData.DeliveryCode).FirstOrDefault();
                            if (deliverysData.Addresses.Count > 0 && !deliverysData.Addresses.Any(x => x.Address == orderData.Address))
                                deliverysData.Addresses.Add(new OrderGroupCustomerViewModel { Address = orderData.Address, Weight = orderData.WeightOfOrder, Orders = new List<OrderGroupDeliveryViewModel> { orderData } });
                            else
                            {
                                var dataAddress = deliverysData.Addresses.Where(x => x.Address == orderData.Address).FirstOrDefault();
                                dataAddress.Weight += orderData.WeightOfOrder;
                                dataAddress.Orders.Add(orderData);
                            }
                        }
                    }
                }

                var orderOverWights = _orderService.Get(x => x.Note == $"Đơn hàng của {warehouseFrom.Name} vượt quá khối lượng của xe." && x.DriverId != null && x.Status == (int)OrderEnum.Đanggiaohàng).ProjectTo<OrderGroupDataModel>(_mapper).ToList();
                if (orderOverWights.Count > 0)
                {
                    foreach (var orderOverWight in orderOverWights)
                    {
                        var orderData = _orderService.Get(x => x.Id == orderOverWight.Id).ProjectTo<OrderGroupDeliveryViewModel>(_mapper).FirstOrDefault();
                        foreach (var farmOrder in orderOverWight.FarmOrders)
                        {
                            foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                                orderData.WeightOfOrder += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                        }
                        deliverys.Add(new OrderGroupCustomerDeliveryViewModel { Flag = true, DeliveryCode = orderData.DeliveryCode, Addresses = new List<OrderGroupCustomerViewModel> { new OrderGroupCustomerViewModel{ Address = orderData.Address, Orders = new List<OrderGroupDeliveryViewModel> { orderData }, Weight = orderData.WeightOfOrder } }, DriverId = orderData.DriverId, DriverName = _jWTService1.GetNameOfUser(orderData.DriverId).Result, Status = "Đang giao hàng" });
                    }
                }

                foreach (var delivery in deliverys)
                    delivery.TotalWeight = delivery.Addresses.Sum(x => x.Weight);
                return deliverys;
            }
            else
            {
                var weights = orderGroups.Sum(x => x.TotalWeight);
                var vehicleNumberEstimate = Math.Ceiling(weights / binCapacity);

                var addresses = new Dictionary<string, double>
                {
                    { warehouseFrom.Address, 0 }
                };
                foreach (var orderGroup in orderGroups)
                    addresses.Add(orderGroup.Address, orderGroup.TotalWeight);

                var routingFirst = await VehicleRouting(addresses, (int)vehicleNumberEstimate);
                routingFirst.RouteOfVihicles = routingFirst.RouteOfVihicles.Where(x => x.TotalWeightOfVihicle > 0).ToList();

                var deliveryDataRoutings = new List<DeliveryDataRouting>();
                int vehicleNumberActual = 0;

                var deliverys = new List<OrderGroupCustomerDeliveryViewModel>();

                if (routingFirst.TotalWeight <= binCapacity)
                {
                    var dataReturn = new OrderGroupCustomerDeliveryViewModel();
                    var orderGroupView = new List<OrderGroupCustomerViewModel>();

                    var dataOrdersIds = new List<int>();

                    foreach (var orderGroup in orderGroups)
                        dataOrdersIds.AddRange(orderGroup.Orders.Select(x => x.Id));
                    var rnd = new Random();
                    var code = rnd.Next(100000, 999999);
                    foreach (var orderId in dataOrdersIds)
                    {
                        var entityOrder = _orderService.Get(x => x.Id == orderId).FirstOrDefault();
                        var collectionCode = DateTime.Now.ToString("ddMMyy") + "-" + code;
                        entityOrder.DeliveryCode = collectionCode;
                        await _orderService.UpdateAsyn(entityOrder);
                    }
                    foreach (var routeOfVihicle in routingFirst.RouteOfVihicles)
                    {
                        routeOfVihicle.Routes.Point.Remove(warehouseFrom.Address);
                        foreach (var point in routeOfVihicle.Routes.Point)
                            orderGroupView.Add(new OrderGroupCustomerViewModel { Address = point.Key, Orders = new List<OrderGroupDeliveryViewModel> { } });
                    }
                    foreach (var orderId in dataOrdersIds)
                    {
                        var orderData = _orderService.Get(x => x.Id == orderId).ProjectTo<OrderGroupDataModel>(_mapper).FirstOrDefault();
                        var order = _orderService.Get(x => x.Id == orderId).ProjectTo<OrderGroupDeliveryViewModel>(_mapper).FirstOrDefault();
                        foreach (var farmOrder in orderData.FarmOrders)
                        {
                            foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                                order.WeightOfOrder += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                        }
                        var orderView = orderGroupView.Where(x => x.Address == order.Address).FirstOrDefault();
                        orderView.Orders.Add(order);
                        orderView.Weight += order.WeightOfOrder;
                        dataReturn.DeliveryCode = order.DeliveryCode;
                    }

                    dataReturn.TotalWeight = orderGroupView.Sum(x => x.Weight);
                    dataReturn.Addresses = orderGroupView.Where(x => x.Orders.Count > 0).ToList();
                    dataReturn.Status = "Đã đến kho";
                    deliverys.Add(dataReturn);
                }
                else if (routingFirst.TotalWeight > binCapacity)
                {
                    foreach (var routeOfVihicle in routingFirst.RouteOfVihicles)
                    {
                        if (routeOfVihicle.TotalWeightOfVihicle <= binCapacity)
                        {
                            var deliveryRouting = routeOfVihicle.Routes.Point;
                            deliveryRouting.Remove(warehouseFrom.Address);
                            deliveryDataRoutings.Add(new DeliveryDataRouting { DeliveryRouting = deliveryRouting });

                            vehicleNumberActual += 1;
                        }
                        else if (routeOfVihicle.TotalWeightOfVihicle > binCapacity)
                        {
                            var deliveryRouting = routeOfVihicle.Routes.Point;
                            deliveryRouting.Remove(warehouseFrom.Address);

                            var dataWeights = new List<double>();
                            var dataOrderIds = new List<int>();
                            foreach (var orderGroup in orderGroups)
                            {
                                foreach (var order in orderGroup.Orders)
                                {
                                    if (deliveryRouting.Keys.ToList().Any(x => x == orderGroup.Address))
                                    {
                                        dataWeights.Add(order.Weight);
                                        dataOrderIds.Add(order.Id);
                                    }
                                }
                            }
                            var binPackingNext = _orderService.BinPackingMip(dataWeights.ToArray(), dataOrderIds.ToArray());
                            deliveryDataRoutings.Add(new DeliveryDataRouting { DeliveryRouting = deliveryRouting });

                            vehicleNumberActual += (int)Math.Ceiling(binPackingNext.TotalBin);
                        }
                    }
                }

                if (vehicleNumberActual > vehicleNumberEstimate && vehicleNumberActual != 0)
                {
                    var dataWeights = new List<double>();
                    var dataOrderIds = new List<int>();
                    foreach (var orderGroup in orderGroups)
                    {
                        foreach (var order in orderGroup.Orders)
                        {
                            dataWeights.Add(order.Weight);
                            dataOrderIds.Add(order.Id);
                        }
                    }
                    var binPacking = _orderService.BinPackingMip(dataWeights.ToArray(), dataOrderIds.ToArray());

                    foreach (var bin in binPacking.BinResult)
                    {
                        var dataReturn = new OrderGroupCustomerDeliveryViewModel();

                        var addressesWarehouse = new Dictionary<string, double>
                        {
                            { warehouseFrom.Address, 0 }
                        };
                        var orderIds = bin.BinDetail.Items;
                        var rnd = new Random();
                        var code = rnd.Next(100000, 999999);
                        foreach (var orderId in orderIds)
                        {
                            var add = orderGroups.Where(x => x.Orders.Any(y => y.Id == orderId)).FirstOrDefault();
                            if (addressesWarehouse.Keys.ToList().All(x => x != add.Address))
                                addressesWarehouse.Add(add.Address, (double)add.TotalWeight);
                        }

                        var routings = await VehicleRouting(addresses, 1);
                        var orderGroupView = new List<OrderGroupCustomerViewModel>();

                        foreach (var routeOfVihicle in routings.RouteOfVihicles)
                        {
                            routeOfVihicle.Routes.Point.Remove(warehouseFrom.Address);
                            foreach (var point in routeOfVihicle.Routes.Point)
                            {
                                orderGroupView.Add(new OrderGroupCustomerViewModel { Address = point.Key, Orders = new List<OrderGroupDeliveryViewModel> { } });
                            }
                        }

                        foreach (var orderId in orderIds)
                        {
                            var entityOrder = _orderService.Get(x => x.Id == orderId).FirstOrDefault();
                            var collectionCode = DateTime.Now.ToString("ddMMyy") + "-" + code;
                            entityOrder.DeliveryCode = collectionCode;
                            await _orderService.UpdateAsyn(entityOrder);
                            var orderData = _orderService.Get(x => x.Id == orderId).ProjectTo<OrderGroupDataModel>(_mapper).FirstOrDefault();
                            var order = _orderService.Get(x => x.Id == orderId).ProjectTo<OrderGroupDeliveryViewModel>(_mapper).FirstOrDefault();
                            foreach (var farmOrder in orderData.FarmOrders)
                            {
                                foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                                    order.WeightOfOrder += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                            }
                            var orderView = orderGroupView.Where(x => x.Address == order.Address).FirstOrDefault();
                            orderView.Orders.Add(order);
                            orderView.Weight += order.WeightOfOrder;
                            dataReturn.DeliveryCode = order.DeliveryCode;
                        }
                        var orders = orderGroupView.Where(x => x.Orders.Count > 0).ToList();
                        dataReturn.Addresses = orders;
                        dataReturn.TotalWeight = bin.BinDetail.TotalWeight;
                        dataReturn.Status = "Đã đến kho";
                        deliverys.Add(dataReturn);
                    }
                }
                else if (vehicleNumberActual <= vehicleNumberEstimate && vehicleNumberActual != 0)
                {
                    foreach (var deliveryDataRouting in deliveryDataRoutings)
                    {
                        double weightOfRoute = 0;
                        foreach (var weight in deliveryDataRouting.DeliveryRouting.Values)
                        {
                            weightOfRoute += weight;
                        }
                        var dataOrderGroups = orderGroups.Where(x => deliveryDataRouting.DeliveryRouting.Keys.Any(y => y == x.Address));

                        var dataAddress = new List<string>();
                        var dataOrdersIds = new List<int>();
                        var dataWeights = new List<double>();

                        foreach (var orderGroup in dataOrderGroups)
                        {
                            dataAddress.Add(orderGroup.Address);
                            dataWeights.AddRange(orderGroup.Orders.Select(x => x.Weight));
                            dataOrdersIds.AddRange(orderGroup.Orders.Select(x => x.Id));
                        }
                        if (weightOfRoute > binCapacity)
                        {
                            var binPacking = _orderService.BinPackingMip(dataWeights.ToArray(), dataOrdersIds.ToArray());

                            foreach (var bin in binPacking.BinResult)
                            {
                                var orderGroupView = new List<OrderGroupCustomerViewModel>();
                                var dataReturn = new OrderGroupCustomerDeliveryViewModel();
                                var rnd = new Random();
                                var code = rnd.Next(100000, 999999);
                                var OrderIds = bin.BinDetail.Items;

                                foreach (var deliveryRouting in deliveryDataRouting.DeliveryRouting)
                                {
                                    orderGroupView.Add(new OrderGroupCustomerViewModel { Address = deliveryRouting.Key, Orders = new List<OrderGroupDeliveryViewModel> { } });
                                }

                                foreach (var orderId in OrderIds)
                                {
                                    var entityOrder = _orderService.Get(x => x.Id == orderId).FirstOrDefault();
                                    var collectionCode = DateTime.Now.ToString("ddMMyy") + "-" + code;
                                    entityOrder.DeliveryCode = collectionCode;
                                    await _orderService.UpdateAsyn(entityOrder);
                                    var orderData = _orderService.Get(x => x.Id == orderId).ProjectTo<OrderGroupDataModel>(_mapper).FirstOrDefault();
                                    var order = _orderService.Get(x => x.Id == orderId).ProjectTo<OrderGroupDeliveryViewModel>(_mapper).FirstOrDefault();
                                    foreach (var farmOrder in orderData.FarmOrders)
                                    {
                                        foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                                            order.WeightOfOrder += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                                    }
                                    var orderView = orderGroupView.Where(x => x.Address == order.Address).FirstOrDefault();
                                    orderView.Orders.Add(order);
                                    orderView.Weight += order.WeightOfOrder;
                                    dataReturn.DeliveryCode = order.DeliveryCode;
                                }

                                dataReturn.Addresses = orderGroupView.Where(x => x.Orders.Count > 0).ToList();
                                dataReturn.TotalWeight = bin.BinDetail.TotalWeight;
                                dataReturn.Status = "Đã đến kho";
                                deliverys.Add(dataReturn);
                            }
                        }
                        else
                        {
                            var dataReturn = new OrderGroupCustomerDeliveryViewModel();

                            var rnd = new Random();
                            var code = rnd.Next(100000, 999999);
                            var orderGroupView = new List<OrderGroupCustomerViewModel>();

                            foreach (var routeOfVihicle in routingFirst.RouteOfVihicles)
                            {
                                routeOfVihicle.Routes.Point.Remove(warehouseFrom.Address);
                                foreach (var point in routeOfVihicle.Routes.Point)
                                {
                                    orderGroupView.Add(new OrderGroupCustomerViewModel { Address = point.Key, Orders = new List<OrderGroupDeliveryViewModel> { } });
                                }
                            }
                            foreach (var orderId in dataOrdersIds)
                            {
                                var entityOrder = _orderService.Get(x => x.Id == orderId).FirstOrDefault();
                                var collectionCode = DateTime.Now.ToString("ddMMyy") + "-" + code;
                                entityOrder.DeliveryCode = collectionCode;
                                await _orderService.UpdateAsyn(entityOrder);
                                var orderData = _orderService.Get(x => x.Id == orderId).ProjectTo<OrderGroupDataModel>(_mapper).FirstOrDefault();
                                var order = _orderService.Get(x => x.Id == orderId).ProjectTo<OrderGroupDeliveryViewModel>(_mapper).FirstOrDefault();
                                foreach (var farmOrder in orderData.FarmOrders)
                                {
                                    foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                                        order.WeightOfOrder += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                                }
                                var orderView = orderGroupView.Where(x => x.Address == order.Address).FirstOrDefault();
                                orderView.Orders.Add(order);
                                orderView.Weight += order.WeightOfOrder;
                                dataReturn.DeliveryCode = order.DeliveryCode;
                                if (dataReturn.DriverId == null)
                                    dataReturn.DriverId = order.DriverId;
                            }

                            dataReturn.Addresses = orderGroupView.Where(x => x.Orders.Count > 0).ToList();
                            dataReturn.TotalWeight = weightOfRoute;
                            dataReturn.Status = "Đã đến kho";
                            deliverys.Add(dataReturn);
                        }
                    }
                }

                var orderOverWights = _orderService.Get(x => x.Note == $"Đơn hàng của {warehouseFrom.Name} vượt quá khối lượng của xe." && x.DriverId == null && x.Status == (int)OrderEnum.ĐãđếnWareHouse2).ProjectTo<OrderGroupDataModel>(_mapper).ToList();
                if (orderOverWights.Count > 0)
                {
                    foreach (var orderOverWight in orderOverWights)
                    {
                        var orderData = _orderService.Get(x => x.Id == orderOverWight.Id).ProjectTo<OrderGroupDeliveryViewModel>(_mapper).FirstOrDefault();
                        foreach (var farmOrder in orderOverWight.FarmOrders)
                        {
                            foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                                orderData.WeightOfOrder += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                        }
                        deliverys.Add(new OrderGroupCustomerDeliveryViewModel { Flag = true, DeliveryCode = orderData.DeliveryCode, Addresses = new List<OrderGroupCustomerViewModel> { new OrderGroupCustomerViewModel { Address = orderData.Address, Orders = new List<OrderGroupDeliveryViewModel> { orderData }, Weight = orderData.WeightOfOrder } },TotalWeight = orderData.WeightOfOrder, Status = "Đã đến kho" });
                    }
                }

                return deliverys;
            }
        }

        public async Task<List<OrderGroupCustomerViewModel>> DeliveryOfOrderDetail(int warehouseId, string deliveryCode)
        {
            var orders = _orderService.Get(x => x.DeliveryCode == deliveryCode).ProjectTo<OrderGroupDeliveryViewModel>(_mapper).ToList();
            var warehouse = _wareHouseService.Get(x => x.Id == warehouseId).FirstOrDefault();

            var addresses = new Dictionary<string, double>();
            addresses.Add(warehouse.Address, 0);
            var orderAddressed = orders.Select(x => x.Address).ToList();
            foreach (var orderAddress in orderAddressed)
            {
                if (!addresses.Keys.Any(x => x == orderAddress))
                    addresses.Add(orderAddress, 0);
            }
            var routing = await VehicleRouting(addresses, 1);

            var orderGroupViews = new List<OrderGroupCustomerViewModel>();
            foreach (var routeOfVihicle in routing.RouteOfVihicles)
            {
                foreach (var item in routeOfVihicle.Routes.Point)
                {
                    if (item.Key != warehouse.Address)
                        orderGroupViews.Add(new OrderGroupCustomerViewModel { Address = item.Key, Orders = new List<OrderGroupDeliveryViewModel> { } });
                }
            }

            foreach (var orderGroup in orderGroupViews)
            {
                foreach (var order in orders)
                {
                    double weight = 0;
                    var dataOrder = _orderService.Get(x => x.Id == order.Id).ProjectTo<OrderGroupDataModel>(_mapper).FirstOrDefault();
                    foreach (var farmOrder in dataOrder.FarmOrders)
                    {
                        foreach (var harvestOrder in farmOrder.ProductHarvestOrders)
                            weight += harvestOrder.Quantity * harvestOrder.HarvestCampaign.ValueChangeOfUnit;
                    }
                    order.WeightOfOrder = weight;
                    var dataOrderView = orderGroupViews.Where(x => x.Address == order.Address).FirstOrDefault();
                    dataOrderView.Orders.Add(order);
                }
                orderGroup.Weight = orderGroup.Orders.Sum(x => x.WeightOfOrder);
            }
            return orderGroupViews;

        }

        public async Task<List<FarmCollectionDetailModel>> CollectionOfFarmOrderDetail(int warehouseId, string collectionCode)
        {
            var farmOrders = _farmOrderService.Get(x => x.CollectionCode == collectionCode).ProjectTo<FarmOrderMapToGroupModel>(_mapper).ToList();
            var warehouse = _wareHouseService.Get(x => x.Id == warehouseId).FirstOrDefault();
            var farms = new List<FarmMapDataToViewGroupFarmOrder>();
            var addresses = new Dictionary<string, double>();
            addresses.Add(warehouse.Address, 0);
            foreach (var farmOrder in farmOrders)
            {
                var farm = _farmService.Get(x => x.Id == farmOrder.FarmId).ProjectTo<FarmMapDataToViewGroupFarmOrder>(_mapper).FirstOrDefault();
                if (farms.Count == 0)
                {
                    farms.Add(farm);
                    addresses.Add(farm.Address, farm.Id);
                }
                else if (farms.Count > 0 && farms.Any(x => x.Id == farm.Id))
                    farms.Remove(farm);
                else
                {
                    farms.Add(farm);
                    addresses.Add(farm.Address, farm.Id);
                }
            }

            var routing = await VehicleRouting(addresses, 1);

            var dataFarms = new List<FarmCollectionDetailModel>();
            foreach (var routeOfVihicle in routing.RouteOfVihicles)
            {
                foreach (var item in routeOfVihicle.Routes.Point)
                {
                    if (item.Value != 0)
                        dataFarms.Add(_farmService.Get(x => x.Id == item.Value).ProjectTo<FarmCollectionDetailModel>(_mapper).FirstOrDefault());
                }
            }

            return dataFarms;
        }

        public async Task<DashBoardOfWarehouse> DashBoardOfWarehouse(int warehouseId)
        {
            var warehouse = _wareHouseService.Get(x => x.Id == warehouseId).ProjectTo<WareHouseDataMapModel>(_mapper).FirstOrDefault();
            var dataFarmOrdersCollection = new List<FarmOrder>();
            foreach (var zone in warehouse.WareHouseZones)
                dataFarmOrdersCollection.AddRange(_farmOrderService.Get(x => x.Status == (int)FarmOrderEnum.Đangbàngiaochobênvậnchuyển && x.Farm.FarmZoneId == zone.ZoneId).ToList());
            var shipmentsTransport = _shipmentService.Get(x => x.Status == (int)ShipmentEnum.Đangvậnchuyển && x.From == warehouse.Address).Count();
            
            var ordersDeliveryData = new List<Order>();
            foreach (var zone in warehouse.WareHouseZones)
                ordersDeliveryData.AddRange(_orderService.Get(x => (x.Status == (int)OrderEnum.ĐãđếnWareHouse2 || x.Status == (int)OrderEnum.Đanggiaohàng) && x.DeliveryZoneId == zone.ZoneId).ToList());
            var drivers = await _userManager.Users.Where(x => x.WareHouseId == warehouseId && x.AspNetUserRoles.Any(y => y.Role.Name == "driver")).CountAsync();
            var dashBoardOfWarehouse = new DashBoardOfWarehouse
            {
                FarmOrdersCollect = dataFarmOrdersCollection.Count,
                ShipmentsTransport = shipmentsTransport,
                OrdersDelivery = ordersDeliveryData.Count,
                Drivers = drivers
            };
            return dashBoardOfWarehouse;
        }

        public async Task<DynamicModelsResponse<FarmOrderGroupFarm>> GetGroupFarmOrderForDriver(string driverId, bool completed, int page, int size)
        {
            var listGroup = new List<FarmOrderGroupFarm>();
            var listFarm = new List<FarmCollectionModel>();
            var farmOrderGroups = await _farmOrderService.Get(x => x.DriverId == driverId && x.CollectionCode != null
            && (x.Status == (int)FarmOrderEnum.Đangbàngiaochobênvậnchuyển || x.Status == (int)FarmOrderEnum.Đãbàngiaochobênvậnchuyển || x.Status == (int)FarmOrderEnum.Đãhủy)).ProjectTo<FarmOrderCollectionGroup>(_mapper).OrderBy(x => x.Status).ToListAsync();
            if (farmOrderGroups.Count == 0)
                return new DynamicModelsResponse<FarmOrderGroupFarm> { Data = new List<FarmOrderGroupFarm>(), Metadata = new PagingMetadata { Page = page, Size = size, Total = 0 } };

            foreach (var farmOrder in farmOrderGroups)
            {
                double weights = 0;
                var farm = _farmService.Get(x => x.Id == farmOrder.FarmId).ProjectTo<FarmCollectionModel>(_mapper).FirstOrDefault();
                farm.Phone = _jWTService1.GetUserId(farm.FarmerId).Result.Phone;
                if (listFarm.Count == 0)
                    listFarm.Add(farm);
                else if (listFarm.Count > 0 && listFarm.Any(x => x.Id == farm.Id))
                    listFarm.Remove(farm);
                else
                    listFarm.Add(farm);

                foreach (var productHarvestOrder in farmOrder.ProductHarvestOrders)
                    weights += productHarvestOrder.Quantity * productHarvestOrder.HarvestCampaign.ValueChangeOfUnit;

                switch (listGroup.Count)
                {
                    case 0:
                        listGroup.Add(new FarmOrderGroupFarm { CollectionCode = farmOrder.CollectionCode, TotalWeight = weights });
                        break;
                    case > 0 when listGroup.Any(x => x.CollectionCode == farmOrder.CollectionCode):
                        {
                            var group = listGroup.Where(x => x.CollectionCode == farmOrder.CollectionCode).FirstOrDefault();
                            group.TotalWeight += weights;
                            listGroup.Remove(new FarmOrderGroupFarm { CollectionCode = farmOrder.CollectionCode });
                        }
                        break;
                    default:
                        listGroup.Add(new FarmOrderGroupFarm { CollectionCode = farmOrder.CollectionCode, TotalWeight = weights });
                        break;
                }
            }
            if (listFarm.Count > 1)
            {
                var driverWarehouse = _userManager.Users.Where(x => x.Id == driverId).FirstOrDefault();
                var warehouse = _wareHouseService.Get(x => x.Id == driverWarehouse.WareHouseId).FirstOrDefault();

                var dataRouting = new Dictionary<string, double>
                {
                    { warehouse.Address, 0 }
                };
                foreach (var farm in listFarm)
                    dataRouting.Add(farm.Address, farm.Id);
                var routing = await VehicleRouting(dataRouting, 1);
                var listFarmRoutings = new List<FarmCollectionModel>();
                foreach (var routeOfVihicle in routing.RouteOfVihicles)
                {
                    routeOfVihicle.Routes.Point.Remove(warehouse.Address);
                    foreach (var point in routeOfVihicle.Routes.Point)
                    {
                        var farm = _farmService.Get(x => x.Address == point.Key).ProjectTo<FarmCollectionModel>(_mapper).FirstOrDefault();
                        farm.Phone = _jWTService1.GetUserId(farm.FarmerId).Result.Phone;
                        listFarmRoutings.Add(farm);
                    }
                }

                foreach (var list in listGroup)
                {
                    if (!completed)
                    {
                        if (!listFarmRoutings.All(x => x.FarmOrders.Where(z => z.CollectionCode == list.CollectionCode).All(y => y.Status == "4" || y.Status == "7")))
                        {
                            foreach (var item in listFarmRoutings)
                            {
                                item.FarmOrders = item.FarmOrders.Where(x => x.CollectionCode == list.CollectionCode).ToList();
                                foreach (var farmOrder in item.FarmOrders)
                                {
                                    farmOrder.Status = farmOrder.Status switch
                                    {
                                        "3" => "Đang bàn giao cho bên vận chuyển",
                                        "4" => "Đã bàn giao cho bên vận chuyển",
                                        "7" => "Đã hủy",
                                        _ => ""
                                    };
                                }
                            }
                        }
                        else
                            listFarmRoutings = new List<FarmCollectionModel> { };
                    }
                    else
                    {
                        if (listFarmRoutings.All(x => x.FarmOrders.Where(z => z.CollectionCode == list.CollectionCode).All(y => y.Status == "4" || y.Status == "7")))
                        {
                            listFarmRoutings = listFarmRoutings.Where(x => x.FarmOrders.Count > 0 && x.FarmOrders.Any(y => y.CollectionCode == list.CollectionCode)).ToList();
                            foreach (var item in listFarmRoutings)
                            {
                                item.FarmOrders = item.FarmOrders.Where(x => x.CollectionCode == list.CollectionCode).ToList();
                                foreach (var farmOrder in item.FarmOrders)
                                {
                                    farmOrder.Status = farmOrder.Status switch
                                    {
                                        "4" => "Đã bàn giao cho bên vận chuyển",
                                        "7" => "Đã hủy",
                                        _ => ""
                                    };
                                }
                            }
                        }
                        else
                            listFarmRoutings = new List<FarmCollectionModel> { };
                    }

                    list.Farms = listFarmRoutings.Where(x => x.FarmOrders.Count > 0 && !x.FarmOrders.All(y => y.Status == "")).ToList();
                }
            }
            else
            {
                foreach (var list in listGroup)
                {
                    if (!completed)
                    {
                        if (!listFarm.All(x => x.FarmOrders.Where(z => z.CollectionCode == list.CollectionCode).All(y => y.Status == "4" || y.Status == "7")))
                        {
                            foreach (var item in listFarm)
                            {
                                item.FarmOrders = item.FarmOrders.Where(x => x.CollectionCode == list.CollectionCode).ToList();
                                foreach (var farmOrder in item.FarmOrders)
                                {
                                    farmOrder.Status = farmOrder.Status switch
                                    {
                                        "3" => "Đang bàn giao cho bên vận chuyển",
                                        "4" => "Đã bàn giao cho bên vận chuyển",
                                        "7" => "Đã hủy",
                                        _ => ""
                                    };
                                }
                            }
                        }
                        else
                            listFarm = new List<FarmCollectionModel> { };
                    }
                    else
                    {
                        if (listFarm.All(x => x.FarmOrders.Where(z => z.CollectionCode == list.CollectionCode).All(y => y.Status == "4" || y.Status == "7")))
                        {
                            listFarm = listFarm.Where(x => x.FarmOrders.Count > 0 && x.FarmOrders.Any(y => y.CollectionCode == list.CollectionCode)).ToList();
                            foreach (var item in listFarm)
                            {
                                item.FarmOrders = item.FarmOrders.Where(x => x.CollectionCode == list.CollectionCode).ToList();
                                foreach (var farmOrder in item.FarmOrders)
                                {
                                    farmOrder.Status = farmOrder.Status switch
                                    {
                                        "4" => "Đã bàn giao cho bên vận chuyển",
                                        "7" => "Đã hủy",
                                        _ => ""
                                    };
                                }
                            }
                        }
                        else
                            listFarm = new List<FarmCollectionModel> { };
                    }

                    list.Farms = listFarm.Where(x => x.FarmOrders.Count > 0 && !x.FarmOrders.All(y => y.Status == "")).ToList();
                }
            }

            var listPaging = listGroup.Where(x => x.Farms.Count > 0).ToList().PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
            var result = new DynamicModelsResponse<FarmOrderGroupFarm>
            {
                Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
                Data = listPaging.Item2
            };

            return result;
        }

        public async Task<DynamicModelsResponse<OrderGroupDeliveryForDriverViewModel>> DeliveryToCustomerForDriver(string driverId, bool completed, int page, int size)
        {
            var orderForDriver = await _orderService.Get(x => x.DriverId == driverId && x.DeliveryCode != null
            && (x.Status == (int)OrderEnum.Đanggiaohàng || x.Status == (int)OrderEnum.ĐãHoànthành || x.Status == (int)OrderEnum.ĐãHủy)).ProjectTo<OrderForDriverModel>(_mapper).OrderBy(x => x.Status).ToListAsync();

            var addressList = new List<OrderGroupForDriverViewModel>();
            var orderGroupDeliverys = new List<OrderGroupDeliveryForDriverViewModel>();
            foreach (var order in orderForDriver)
            {
                if (orderGroupDeliverys.Count == 0 || orderGroupDeliverys.Any(x => x.DeliveryCode == order.DeliveryCode))
                {
                    double weights = 0;
                    var dataOrder = _orderService.Get(x => x.Id == order.Id).ProjectTo<OrderDataMapHarvestCampaignModel>(_mapper).FirstOrDefault();
                    foreach (var farmOrder in dataOrder.FarmOrders)
                    {
                        foreach (var productHarvestOder in farmOrder.ProductHarvestOrders)
                            weights += productHarvestOder.Quantity * productHarvestOder.HarvestCampaign.ValueChangeOfUnit;
                    }
                    order.Status = order.Status switch
                    {
                        "6" => "Đang giao hàng",
                        "7" => "Đã hoàn thành",
                        "8" => "Đã hủy",
                        _ => ""
                    };
                    order.WeightOfOrder = weights;

                    if (addressList.Count == 0)
                        addressList.Add(new OrderGroupForDriverViewModel { Address = dataOrder.Address, Orders = new List<OrderForDriverModel> { order } });
                    else if (addressList.Count > 0 && addressList.Any(x => x.Address == dataOrder.Address))
                    {
                        var address = addressList.Where(x => x.Address == dataOrder.Address).FirstOrDefault();
                        address.Orders.Add(order);
                        addressList.Remove(new OrderGroupForDriverViewModel { Address = dataOrder.Address, Orders = new List<OrderForDriverModel> { order } });
                    }
                    else
                        addressList.Add(new OrderGroupForDriverViewModel { Address = dataOrder.Address, Orders = new List<OrderForDriverModel> { order } });

                    if (orderGroupDeliverys.Count == 0)
                        orderGroupDeliverys.Add(new OrderGroupDeliveryForDriverViewModel { DeliveryCode = dataOrder.DeliveryCode, Addresses = new List<OrderGroupForDriverViewModel> { } });
                    else if (orderGroupDeliverys.Count > 0 && orderGroupDeliverys.Any(x => x.DeliveryCode == dataOrder.DeliveryCode))
                        orderGroupDeliverys.Remove(new OrderGroupDeliveryForDriverViewModel { DeliveryCode = dataOrder.DeliveryCode, Addresses = new List<OrderGroupForDriverViewModel> { } });
                    else
                        orderGroupDeliverys.Add(new OrderGroupDeliveryForDriverViewModel { DeliveryCode = dataOrder.DeliveryCode, Addresses = new List<OrderGroupForDriverViewModel> { } });
                }
            }
            if (addressList.Count > 1)
            {
                var driverWarehouse = _userManager.Users.Where(x => x.Id == driverId).FirstOrDefault();
                var warehouse = _wareHouseService.Get(x => x.Id == driverWarehouse.WareHouseId).FirstOrDefault();

                var dataRouting = new Dictionary<string, List<OrderForDriverModel>>
                {
                    { warehouse.Address, new List<OrderForDriverModel>{ } }
                };
                foreach (var address in addressList)
                    dataRouting.Add(address.Address, address.Orders);
                var routing = await VehicleRoutingObject(dataRouting, 1);
                var addressListRoutings = new List<OrderGroupForDriverViewModel>();
                foreach (var routeOfVihicle in routing.RouteOfVihicles)
                {
                    routeOfVihicle.Routes.Point.Remove(warehouse.Address);
                    foreach (var point in routeOfVihicle.Routes.Point)
                    {
                        addressListRoutings.Add(new OrderGroupForDriverViewModel { Address = point.Key, Orders = point.Value });
                    }
                }

                foreach (var orderGroupDelivery in orderGroupDeliverys)
                {
                    if (!completed)
                    {
                        if (!addressListRoutings.All(x => x.Orders.All(y => y.Status == "Đã hoàn thành" || y.Status == "Đã hủy")))
                        {
                            foreach (var address in addressListRoutings)
                            {
                                if (address.Orders.Any(x => x.DeliveryCode == orderGroupDelivery.DeliveryCode))
                                {
                                    address.Weight = address.Orders.Sum(x => x.WeightOfOrder);
                                    orderGroupDelivery.Addresses.Add(address);
                                }
                            }
                            orderGroupDelivery.TotalWeight = orderGroupDelivery.Addresses.Sum(x => x.Weight);
                        }
                        else
                        {
                            orderGroupDelivery.Addresses = new List<OrderGroupForDriverViewModel> { };
                        }
                    }
                    else
                    {
                        if (addressListRoutings.All(x => x.Orders.All(y => y.Status == "Đã hoàn thành" || y.Status == "Đã hủy")))
                        {
                            addressListRoutings = addressListRoutings.Where(x => x.Orders.Count > 0 && x.Orders.Any(y => y.DeliveryCode == orderGroupDelivery.DeliveryCode)).ToList();
                            foreach (var address in addressListRoutings)
                            {
                                address.Weight = address.Orders.Sum(x => x.WeightOfOrder);
                                if (address.Orders.Any(x => x.DeliveryCode == orderGroupDelivery.DeliveryCode))
                                    orderGroupDelivery.Addresses.Add(address);
                            }
                            orderGroupDelivery.TotalWeight = orderGroupDelivery.Addresses.Sum(x => x.Weight);
                        }
                        else
                        {
                            orderGroupDelivery.Addresses = new List<OrderGroupForDriverViewModel> { };
                        }
                    }
                }
            }
            else
            {
                foreach (var orderGroupDelivery in orderGroupDeliverys)
                {
                    if (!completed)
                    {
                        if (!addressList.All(x => x.Orders.All(y => y.Status == "Đã hoàn thành" || y.Status == "Đã hủy")))
                        {
                            foreach (var address in addressList)
                            {
                                if (address.Orders.Any(x => x.DeliveryCode == orderGroupDelivery.DeliveryCode))
                                {
                                    address.Weight = address.Orders.Sum(x => x.WeightOfOrder);
                                    orderGroupDelivery.Addresses.Add(address);
                                }
                            }
                            orderGroupDelivery.TotalWeight = orderGroupDelivery.Addresses.Sum(x => x.Weight);
                        }
                        else
                        {
                            orderGroupDelivery.Addresses = new List<OrderGroupForDriverViewModel> { };
                        }
                    }
                    else
                    {
                        if (addressList.All(x => x.Orders.All(y => y.Status == "Đã hoàn thành" || y.Status == "Đã hủy")))
                        {
                            addressList = addressList.Where(x => x.Orders.Count > 0 && x.Orders.Any(y => y.DeliveryCode == orderGroupDelivery.DeliveryCode)).ToList();
                            foreach (var address in addressList)
                            {
                                address.Weight = address.Orders.Sum(x => x.WeightOfOrder);
                                if (address.Orders.Any(x => x.DeliveryCode == orderGroupDelivery.DeliveryCode))
                                    orderGroupDelivery.Addresses.Add(address);
                            }
                            orderGroupDelivery.TotalWeight = orderGroupDelivery.Addresses.Sum(x => x.Weight);
                        }
                        else
                        {
                            orderGroupDelivery.Addresses = new List<OrderGroupForDriverViewModel> { };
                        }
                    }
                }
            }


            var listPaging = orderGroupDeliverys.Where(x => x.Addresses.Count > 0).ToList().PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
            var result = new DynamicModelsResponse<OrderGroupDeliveryForDriverViewModel>
            {
                Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
                Data = listPaging.Item2
            };
            return result;
        }

        public TaskOfDriverModel TasksOfDriver(string driverId)
        {
            int taskOfCollections = GetGroupFarmOrderForDriver(driverId, false, 1, 1).Result.Metadata.Total;
            int taskOfDeliveries = DeliveryToCustomerForDriver(driverId, false, 1, 1).Result.Metadata.Total;
            int taskOfShipments = _shipmentService.GetShipMentForDriver(driverId, "0", 1, 1).Result.Metadata.Total;
            var tasks = new TaskOfDriverModel { TaskOfCollections = taskOfCollections, TaskOfDeliveries = taskOfDeliveries, TaskOfShipments = taskOfShipments };
            return tasks;
        }

        private static VehicleRoutingViewModel PrintSolution(in VehicleRoutingModel data, in RoutingModel routing, in RoutingIndexManager manager,
                              in Assignment solution, Dictionary<string, double> addresses)
        {
            var vehicleRouting = new VehicleRoutingViewModel();
            var routeOfVihicles = new List<RouteOfVihicle>();
            // Inspect solution.
            long maxRouteDistance = 0;
            int totalDistance = 0;
            var dataAddress = addresses.Keys.ToArray();
            var dataWeight = addresses.Values.ToArray();
            for (int i = 0; i < data.VehicleNumber; ++i)
            {
                var routes = new Routes();
                long routeDistance = 0;
                var index = routing.Start(i);
                var points = new Dictionary<string, double>();
                while (routing.IsEnd(index) == false)
                {
                    if (points.Count == 0)
                        points.Add(dataAddress[0], 0);
                    else
                        points.Add(dataAddress[index], dataWeight[index]);
                    var previousIndex = index;
                    index = solution.Value(routing.NextVar(index));
                    routeDistance += routing.GetArcCostForVehicle(previousIndex, index, 0);
                }
                maxRouteDistance = Math.Max(routeDistance, maxRouteDistance);

                totalDistance += (int)routeDistance;
                routes.Point = points;
                routes.Distance = routeDistance.ToString() + "m";
                routeOfVihicles.Add(new RouteOfVihicle { Vihicle = i, Routes = routes, TotalWeightOfVihicle = points.Sum(x => x.Value) });
            }
            vehicleRouting.TotalDistance = totalDistance + "m";
            vehicleRouting.RouteOfVihicles = routeOfVihicles;
            vehicleRouting.TotalWeight = routeOfVihicles.Sum(x => x.TotalWeightOfVihicle);

            return vehicleRouting;
        }

        public async Task<VehicleRoutingViewModel> VehicleRouting(Dictionary<string, double> addresses, int vehicleNumber)
        {
            var distanceMatrix = await Create_distance_matrix(addresses.Keys.ToArray());
            VehicleRoutingModel data = new() { VehicleNumber = vehicleNumber, Depot = 0, DistanceMatrix = distanceMatrix };

            RoutingIndexManager manager =
                new(data.DistanceMatrix.GetLength(0), data.VehicleNumber, data.Depot);

            RoutingModel routing = new(manager);

            int transitCallbackIndex = routing.RegisterTransitCallback((long fromIndex, long toIndex) =>
            {
                var fromNode = manager.IndexToNode(fromIndex);
                var toNode = manager.IndexToNode(toIndex);
                return data.DistanceMatrix[fromNode, toNode];
            });

            routing.SetArcCostEvaluatorOfAllVehicles(transitCallbackIndex);

            routing.AddDimension(transitCallbackIndex, 0, 300000,
                                 true, // start cumul to zero
                                 "Distance");
            RoutingDimension distanceDimension = routing.GetMutableDimension("Distance");
            distanceDimension.SetGlobalSpanCostCoefficient(100);

            RoutingSearchParameters searchParameters =
                operations_research_constraint_solver.DefaultRoutingSearchParameters();
            searchParameters.FirstSolutionStrategy = FirstSolutionStrategy.Types.Value.PathCheapestArc;

            Assignment solution = routing.SolveWithParameters(searchParameters);

            var printSolution = PrintSolution(data, routing, manager, solution, addresses);
            return printSolution;
        }

        static long[,] CreateRectangularArray(List<long[]> arrays)
        {
            int minorLength = arrays[0].Length;
            long[,] ret = new long[arrays.Count, minorLength];
            for (int i = 0; i < arrays.Count; i++)
            {
                var array = arrays[i];
                for (int j = 0; j < minorLength; j++)
                {
                    ret[i, j] = array[j];
                }
            }
            return ret;
        }

        public async Task<long[,]> Create_distance_matrix(string[] addresses)
        {
            DistanceMatrixModel response;
            string origin_addresses;
            var API_key = _configuration["Geocoding:ApiKey"];

            var num_addresses = addresses.Length;

            var dest_addresses = addresses;
            var distance_matrix = new List<long[]>();
            foreach (var i in Enumerable.Range(0, num_addresses))
            {
                origin_addresses = addresses[i];
                response = await Send_request(origin_addresses, dest_addresses, API_key);
                distance_matrix.Add(build_distance_matrix(response));
            }

            long[,] array = CreateRectangularArray(distance_matrix);

            return array;
        }

        public string build_address_str(string[] addresses)
        {
            var address_str = "";
            foreach (var i in Enumerable.Range(0, addresses.Length - 1))
            {
                address_str += addresses[i] + "|";
            }
            address_str += addresses[^1];
            return address_str;
        }

        public async Task<DistanceMatrixModel> Send_request(string origin_addresses, string[] dest_addresses, string API_key)
        {
            var origin_address_str = /*build_address_str*/(origin_addresses);
            var dest_address_str = build_address_str(dest_addresses);
            using var client = new HttpClient();
            client.BaseAddress = new Uri("https://maps.googleapis.com/");
            using HttpResponseMessage response = await client.GetAsync($"maps/api/distancematrix/json?units=imperial" + "&origins=" + origin_address_str + "&destinations=" + dest_address_str + "&key=" + API_key);
            var responseContent = response.Content.ReadAsStringAsync().Result;
            response.EnsureSuccessStatusCode();
            var distanceMatrix = JsonConvert.DeserializeObject<DistanceMatrixModel>(responseContent);
            return distanceMatrix;
        }

        public static long[] build_distance_matrix(DistanceMatrixModel distanceMatrix)
        {
            var distance_matrix = new List<long>();
            foreach (var row in distanceMatrix.Rows)
            {
                var row_list = row.Elements.Select(x => Convert.ToInt64(x.Distance.Value)).ToArray();
                distance_matrix.AddRange(row_list);
            }
            return distance_matrix.ToArray();
        }





        //
        private static VehicleRoutingViewModel1 PrintSolution1(in VehicleRoutingModel data, in RoutingModel routing, in RoutingIndexManager manager,
                              in Assignment solution)
        {
            var vehicleRouting = new VehicleRoutingViewModel1();
            var routeOfVihicles = new List<RouteOfVihicle1>();
            var address = new VehicleRoutingAddressModel();
            // Inspect solution.
            long maxRouteDistance = 0;
            int totalDistance = 0;
            var dataAddress = address.Address;
            for (int i = 0; i < data.VehicleNumber; ++i)
            {
                var routes = new Routes1();
                long routeDistance = 0;
                var index = routing.Start(i);
                var points = new List<string>();
                while (routing.IsEnd(index) == false)
                {
                    if (points.Count == 0)
                        points.Add(dataAddress[0]);
                    else
                        points.Add(dataAddress[index]);
                    var previousIndex = index;
                    index = solution.Value(routing.NextVar(index));
                    routeDistance += routing.GetArcCostForVehicle(previousIndex, index, 0);
                }
                maxRouteDistance = Math.Max(routeDistance, maxRouteDistance);

                totalDistance += (int)routeDistance;
                routes.Point = points;
                routes.Distance = routeDistance.ToString() + "m";
                routeOfVihicles.Add(new RouteOfVihicle1 { Vihicle = i, Routes = routes });
            }
            vehicleRouting.TotalDistance = totalDistance + "m";
            vehicleRouting.RouteOfVihicles = routeOfVihicles;

            return vehicleRouting;
        }

        public async Task<VehicleRoutingViewModel1> VehicleRouting1(int vehicleNumber)
        {
            var address = new VehicleRoutingAddressModel();

            var distanceMatrix = await Create_distance_matrix(address.Address);
            VehicleRoutingModel data = new() { VehicleNumber = vehicleNumber, Depot = 0, DistanceMatrix = distanceMatrix };

            RoutingIndexManager manager =
                new(data.DistanceMatrix.GetLength(0), data.VehicleNumber, data.Depot);

            RoutingModel routing = new(manager);

            int transitCallbackIndex = routing.RegisterTransitCallback((long fromIndex, long toIndex) =>
            {
                var fromNode = manager.IndexToNode(fromIndex);
                var toNode = manager.IndexToNode(toIndex);
                return data.DistanceMatrix[fromNode, toNode];
            });

            routing.SetArcCostEvaluatorOfAllVehicles(transitCallbackIndex);

            routing.AddDimension(transitCallbackIndex, 0, 300000,
                                 true, // start cumul to zero
                                 "Distance");
            RoutingDimension distanceDimension = routing.GetMutableDimension("Distance");
            distanceDimension.SetGlobalSpanCostCoefficient(100);

            RoutingSearchParameters searchParameters =
                operations_research_constraint_solver.DefaultRoutingSearchParameters();
            searchParameters.FirstSolutionStrategy = FirstSolutionStrategy.Types.Value.PathCheapestArc;

            Assignment solution = routing.SolveWithParameters(searchParameters);

            var printSolution = PrintSolution1(data, routing, manager, solution);
            return printSolution;
        }

        public async Task<VehicleRoutingViewModelObject> VehicleRoutingObject(Dictionary<string, List<OrderForDriverModel>> addresses, int vehicleNumber)
        {
            var distanceMatrix = await Create_distance_matrix(addresses.Keys.ToArray());
            VehicleRoutingModel data = new() { VehicleNumber = vehicleNumber, Depot = 0, DistanceMatrix = distanceMatrix };

            RoutingIndexManager manager =
                new(data.DistanceMatrix.GetLength(0), data.VehicleNumber, data.Depot);

            RoutingModel routing = new(manager);

            int transitCallbackIndex = routing.RegisterTransitCallback((long fromIndex, long toIndex) =>
            {
                var fromNode = manager.IndexToNode(fromIndex);
                var toNode = manager.IndexToNode(toIndex);
                return data.DistanceMatrix[fromNode, toNode];
            });

            routing.SetArcCostEvaluatorOfAllVehicles(transitCallbackIndex);

            routing.AddDimension(transitCallbackIndex, 0, 300000,
                                 true, // start cumul to zero
                                 "Distance");
            RoutingDimension distanceDimension = routing.GetMutableDimension("Distance");
            distanceDimension.SetGlobalSpanCostCoefficient(100);

            RoutingSearchParameters searchParameters =
                operations_research_constraint_solver.DefaultRoutingSearchParameters();
            searchParameters.FirstSolutionStrategy = FirstSolutionStrategy.Types.Value.PathCheapestArc;

            Assignment solution = routing.SolveWithParameters(searchParameters);

            var printSolution = PrintSolutionObject(data, routing, manager, solution, addresses);
            return printSolution;
        }

        private static VehicleRoutingViewModelObject PrintSolutionObject(in VehicleRoutingModel data, in RoutingModel routing, in RoutingIndexManager manager,
                              in Assignment solution, Dictionary<string, List<OrderForDriverModel>> addresses)
        {
            var vehicleRouting = new VehicleRoutingViewModelObject();
            var routeOfVihicles = new List<RouteOfVihicleObject>();
            // Inspect solution.
            long maxRouteDistance = 0;
            int totalDistance = 0;
            var dataAddress = addresses.Keys.ToArray();
            var dataWeight = addresses.Values.ToArray();
            for (int i = 0; i < data.VehicleNumber; ++i)
            {
                var routes = new RoutesObject();
                long routeDistance = 0;
                var index = routing.Start(i);
                var points = new Dictionary<string, List<OrderForDriverModel>>();
                while (routing.IsEnd(index) == false)
                {
                    if (points.Count == 0)
                        points.Add(dataAddress[0], dataWeight[0]);
                    else
                        points.Add(dataAddress[index], dataWeight[index]);
                    var previousIndex = index;
                    index = solution.Value(routing.NextVar(index));
                    routeDistance += routing.GetArcCostForVehicle(previousIndex, index, 0);
                }
                maxRouteDistance = Math.Max(routeDistance, maxRouteDistance);

                totalDistance += (int)routeDistance;
                routes.Point = points;
                routes.Distance = routeDistance.ToString() + "m";
                routeOfVihicles.Add(new RouteOfVihicleObject { Vihicle = i, Routes = routes });
            }
            vehicleRouting.TotalDistance = totalDistance + "m";
            vehicleRouting.RouteOfVihicles = routeOfVihicles;
            vehicleRouting.TotalWeight = routeOfVihicles.Sum(x => x.TotalWeightOfVihicle);

            return vehicleRouting;
        }
    }
}
