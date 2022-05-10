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
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;

namespace DiCho.DataService.Services
{
    public partial interface IShipmentService
    {
        Task<List<ShipmentForWareHouseManagerModel>> GetShipmentForWarehouseManager(int warehouseId, bool assigned);
        Task<ShipmentDetailForWareHouseManagerModel> GetShipmentId(int id);
        Task UpdateShipmentForDriver(List<ShipmentUpdateModel> model);
        Task UpdateStatusComplete(int id);
        Task<DynamicModelsResponse<ShipmentForDriverModel>> GetShipMentForDriver(string driverId, string status, int page, int size);
        Task CreateShipment(List<double> weights, List<int> orderIds, List<string> addresses, int warehouseFromId);
        Task CreateShipmentWithBinPacked(TotalBinModel binPacking, List<string> addresses, int warehouseFromId);
        Task DeleteRemaining(int warehouseId);
        //TaskOfDriverModel TasksOfDriver(string driverId);
        //user
        Task<List<UserDriverModel>> GetAllDriverInWareHouse(int warehouseId, int type);
        Task<List<UserDriverModel>> GetDriverInWareHouse(int WareHouseId, int type);
        Task<List<CustomerOrder>> GetDriverReadyInWareHouse(int warehouseId, int type);
        // order
        Task<DynamicModelsResponse<OrderOfCustomerModel>> GetOrderOfCustomer(string customerId, int page, int size);
    }

    public partial class ShipmentService
    {
        private readonly IConfigurationProvider _mapper;
        private readonly IOrderService _orderService;
        private readonly IWareHouseService _wareHouseService;
        private readonly IJWTService _jWTService;
        private readonly IFarmOrderService _farmOrderService;
        private readonly ICampaignService _campaignService;
        private readonly IPaymentTypeService _paymentTypeService;
        private readonly IShipmentDestinationService _shipmentDestinationService;
        private readonly IFirebaseService _firebaseService;
        private readonly UserManager<AspNetUsers> _userManager;

        public ShipmentService(IShipmentRepository repository, UserManager<AspNetUsers> userManager, IOrderService orderService, IWareHouseService wareHouseService, IJWTService jWTService, IFirebaseService firebaseService,
            IShipmentDestinationService shipmentDestinationService, IPaymentTypeService paymentTypeService, ICampaignService campaignService, IFarmOrderService farmOrderService, IUnitOfWork unitOfWork, IMapper mapper = null) : base(unitOfWork, repository)
        {
            _mapper = mapper.ConfigurationProvider;
            _orderService = orderService;
            _wareHouseService = wareHouseService;
            _jWTService = jWTService;
            _farmOrderService = farmOrderService;
            _userManager = userManager;
            _campaignService = campaignService;
            _paymentTypeService = paymentTypeService;
            _firebaseService = firebaseService;
            _shipmentDestinationService = shipmentDestinationService;
        }

        public async Task<List<ShipmentForWareHouseManagerModel>> GetShipmentForWarehouseManager(int warehouseId, bool assigned)
        {
            var wareHouse = _wareHouseService.Get(x => x.Id == warehouseId).FirstOrDefault();
            if (wareHouse == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Quản lý không tồn tại!");
            var shipments = new List<ShipmentForWareHouseManagerModel>();
            if (!assigned)
                shipments = await Get(x => x.Status == (int)ShipmentEnum.Đangvậnchuyển && x.DriverId == null && x.From == wareHouse.Address).ProjectTo<ShipmentForWareHouseManagerModel>(_mapper).ToListAsync();
            else
                shipments = await Get(x => x.Status == (int)ShipmentEnum.Đangvậnchuyển && x.DriverId != null && x.From == wareHouse.Address).ProjectTo<ShipmentForWareHouseManagerModel>(_mapper).ToListAsync();
            foreach (var shipment in shipments)
            {
                shipment.ShipmentDestinationCount = shipment.ShipmentDestinations.Count;
                shipment.FromWarehouse = wareHouse.Name;
                if (shipment.DriverId != null)
                    shipment.DriverName = await _jWTService.GetNameOfUser(shipment.DriverId);

                foreach (var shipmentDestination in shipment.ShipmentDestinations)
                {
                    var warehouse = _wareHouseService.Get(x => x.Address == shipmentDestination.Address).ProjectTo<WareHouseDataMapModel>(_mapper).FirstOrDefault();
                    var orders = new List<OrderModelForDriver>();
                    foreach (var warehouseZone in warehouse.WareHouseZones)
                        orders.AddRange(_orderService.Get(x => x.ShipmentId == shipment.Id && x.DeliveryZoneId == warehouseZone.ZoneId).ProjectTo<OrderModelForDriver>(_mapper).ToList());
                    shipmentDestination.Orders = orders;
                }

                shipment.DateTimeParse = shipment.CreateAt.ToString("HH:mm dd/MM/yyyy");
                shipment.Status = shipment.Status switch
                {
                    "0" => "Đang vận chuyển",
                    "1" => "Đã hoàn thành",
                    _ => ""
                };
            }

            return shipments;
        }

        public async Task<ShipmentDetailForWareHouseManagerModel> GetShipmentId(int id)
        {
            var shipment = await Get(x => x.Id == id).ProjectTo<ShipmentDetailForWareHouseManagerModel>(_mapper).FirstOrDefaultAsync();
            if (shipment == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy");
            var orders = await _orderService.Get(x => x.ShipmentId == shipment.Id).ProjectTo<OrderForManagerModel>(_mapper).ToListAsync();
            shipment.Orders = orders;
            if (shipment.DriverId != null)
                shipment.DriverName = await _jWTService.GetNameOfUser(shipment.DriverId);

            shipment.ShipmentDestinationCount = shipment.ShipmentDestinations.Count;
            shipment.FromWarehouse = _wareHouseService.Get(x => x.Address == shipment.From).FirstOrDefault().Name;
            shipment.Status = shipment.Status switch
            {
                "0" => "Đang vận chuyển",
                "1" => "Đã hoàn thành",
                _ => ""
            };

            foreach (var order in shipment.Orders)
            {
                order.Status = order.Status switch
                {
                    "0" => "Chờ xác nhận",
                    "1" => "Đang chuẩn bị hàng",
                    "2" => "Chờ bên giao hàng",
                    "3" => $"Đã đến {shipment.From}",
                    "4" => "Đang vận chuyển",
                    "5" => $"Đã đến Kho",
                    "6" => "Đang giao hàng",
                    "7" => "Đã hoàn thành",
                    "8" => "Đã hủy",
                    _ => ""
                };
                foreach (var farmOrder in order.FarmOrders)
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
                }
            }

            return shipment;
        }

        public async Task UpdateShipmentForDriver(List<ShipmentUpdateModel> model)
        {
            foreach (var shipment in model)
            {
                var entity = await GetAsyn(shipment.Id);
                if (entity == null)
                    throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");
                var orders = _orderService.Get(x => x.ShipmentId == shipment.Id).ToList();
                foreach (var order in orders)
                {
                    var entityOrder = _orderService.Get(x => x.Id == order.Id).FirstOrDefault();
                    var orderData = _orderService.Get(x => x.Id == order.Id).ProjectTo<OrderForDriverModel>(_mapper).FirstOrDefault();
                    foreach (var farmOrder in orderData.FarmOrders)
                    {
                        var entityFarmOrder = _farmOrderService.Get(x => x.Id == farmOrder.Id).FirstOrDefault();
                        entityFarmOrder.Status = (int)FarmOrderEnum.Đangvậnchuyển;
                        await _farmOrderService.UpdateAsyn(entityFarmOrder);
                    }
                    entityOrder.Status = (int)OrderEnum.Đangvậnchuyển;
                    await _orderService.UpdateAsyn(entityOrder);
                }

                entity.DriverId = shipment.DriverId;
                await UpdateAsyn(entity);

                var warehouseFrom = _wareHouseService.Get(x => x.Address == entity.From).FirstOrDefault().Name;
                string topic = $"{shipment.DriverId}";
                string title = "Chuyến hàng mới cần vận chuyển";
                string body = $"Chuyến hàng mới từ {warehouseFrom} đang cần vận chuyển.";
                await _firebaseService.SendNotification(title, body, shipment.Id.ToString(), topic);
                await _firebaseService.AddNotiToRedis(new NotificationModel { UserId = shipment.DriverId, Title = title, Body = body });
            }
        }

        public async Task UpdateStatusComplete(int id)
        {
            var entity = await GetAsyn(id);
            if (entity == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, $"Không tìm thấy!");
            entity.Status = (int)ShipmentEnum.Đãhoànthành;
            var orders = _orderService.Get(x => x.ShipmentId == entity.Id).ToList();
            foreach (var order in orders)
            {
                order.Status = (int)OrderEnum.ĐãđếnWareHouse2;
                var farmOrders = _farmOrderService.Get(x => x.OrderId == order.Id && x.Status == (int)FarmOrderEnum.Đangvậnchuyển).ToList();
                await _orderService.UpdateAsyn(order);
            }
            await UpdateAsyn(entity);
        }

        public async Task<DynamicModelsResponse<ShipmentForDriverModel>> GetShipMentForDriver(string driverId, string status, int page, int size)
        {
            status = status switch
            {
                "Đang vận chuyển" => "0",
                "Đã hoàn thành" => "1",
                "0" => "0",
                "1" => "1",
                _ => ""
            };

            var shipments = await Get(x => x.DriverId == driverId && x.Status == Int32.Parse(status)).ProjectTo<ShipmentForDriverModel>(_mapper).ToListAsync();

            foreach (var shipment in shipments)
            {
                shipment.WarehouseFrom = _wareHouseService.Get(x => x.Address == shipment.From).FirstOrDefault().Name;
                shipment.Status = shipment.Status switch
                {
                    "0" => "Đang vận chuyển",
                    "1" => "Đã hoàn thành",
                    _ => ""
                };
                foreach (var shipmentDestination in shipment.ShipmentDestinations)
                {
                    var warehouse = _wareHouseService.Get(x => x.Address == shipmentDestination.Address).ProjectTo<WareHouseDataMapModel>(_mapper).FirstOrDefault();
                    shipmentDestination.WarehouseTo = warehouse.Name;
                    var orders = new List<OrderModelForDriver>();
                    foreach (var warehouseZone in warehouse.WareHouseZones)
                        orders.AddRange(_orderService.Get(x => x.ShipmentId == shipment.Id && x.DeliveryZoneId == warehouseZone.ZoneId).ProjectTo<OrderModelForDriver>(_mapper).ToList());
                    shipmentDestination.Orders = orders;
                }
            }

            var listPaging = shipments.PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
            var result = new DynamicModelsResponse<ShipmentForDriverModel>
            {
                Metadata = new PagingMetadata { Page = page, Size = size, Total = listPaging.Item1 },
                Data = listPaging.Item2
            };
            return result;
        }

        public async Task CreateShipment(List<double> weights, List<int> orderIds, List<string> addresses, int warehouseFromId)
        {
            var binPacking = _orderService.BinPackingMip(weights.ToArray(), orderIds.ToArray());

            var date = DateTime.Now.ToString("ddMMyyyy");

            var random = new Random();
            var code = random.Next(1000, 9999);

            var warehouse = _wareHouseService.Get(x => x.Id == warehouseFromId).FirstOrDefault();
            if (warehouse == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, "Không tìm thấy kho điểm đi!");
            foreach (var bin in binPacking.BinResult)
            {
                code += 1;
                var model = new ShipmentCreateModel
                {
                    Code = "DCNS-" + date + code,
                    From = warehouse.Address,
                    TotalWeight = bin.BinDetail.TotalWeight,
                    WarehouseId = warehouse.Id
                };
                var entity = _mapper.CreateMapper().Map<Shipment>(model);
                await CreateAsyn(entity);

                foreach (var item in bin.BinDetail.Items)
                {
                    var order = _orderService.Get(x => x.Id == item).FirstOrDefault();
                    order.ShipmentId = entity.Id;
                    await _orderService.UpdateAsyn(order);
                }

                foreach (var address in addresses)
                {
                    var shipmentDestination = new ShipmentDestinationCreateModel { ShipmentId = entity.Id, Address = address };
                    var shipmentDestinationEntity = _mapper.CreateMapper().Map<ShipmentDestination>(shipmentDestination);
                    await _shipmentDestinationService.CreateAsyn(shipmentDestinationEntity);
                }
            }
        }

        public async Task CreateShipmentWithBinPacked(TotalBinModel binPacking, List<string> addresses, int warehouseFromId)
        {
            var date = DateTime.Now.ToString("ddMMyyyy");

            var random = new Random();
            var code = random.Next(1000, 9999);

            var from = _wareHouseService.Get(x => x.WareHouseZones.Any(y => y.Id == warehouseFromId)).FirstOrDefault();
            if (from == null)
                throw new ErrorResponse((int)HttpStatusCode.NotFound, "Không tìm thấy kho điểm đi!");
            foreach (var bin in binPacking.BinResult)
            {
                code += 1;
                var model = new ShipmentCreateModel
                {
                    Code = "DCNS-" + date + code,
                    From = from.Address,
                    TotalWeight = bin.BinDetail.TotalWeight
                };
                var entity = _mapper.CreateMapper().Map<Shipment>(model);
                await CreateAsyn(entity);

                foreach (var item in bin.BinDetail.Items)
                {
                    var order = _orderService.Get(x => x.Id == item).FirstOrDefault();
                    order.ShipmentId = entity.Id;
                    await _orderService.UpdateAsyn(order);
                }
                var orderIds = bin.BinDetail.Items.Select(x => x);
                foreach (var address in addresses)
                {
                    var shipmentDestination = new ShipmentDestinationCreateModel { ShipmentId = entity.Id, Address = address };
                    var shipmentDestinationEntity = _mapper.CreateMapper().Map<ShipmentDestination>(shipmentDestination);
                    await _shipmentDestinationService.CreateAsyn(shipmentDestinationEntity);
                }
            }
        }

        public async Task DeleteRemaining(int warehouseId)
        {
            var warehouse = _wareHouseService.Get(x => x.Id == warehouseId).FirstOrDefault();
            var shipments = Get(x => x.From == warehouse.Address && x.Status == (int)ShipmentEnum.Đangvậnchuyển && x.DriverId == null).ProjectTo<ShipmentDetailForWareHouseManagerModel>(_mapper).ToList();

            foreach (var shipment in shipments)
            {
                var orders = _orderService.Get(x => x.ShipmentId == shipment.Id).ToList();
                foreach (var order in orders)
                {
                    order.ShipmentId = null;
                    await _orderService.UpdateAsyn(order);
                }
                var shipmentData = Get(x => x.Id == shipment.Id).ProjectTo<ShipmentForDriverModel>(_mapper).FirstOrDefault();
                foreach (var shipmentDestination in shipmentData.ShipmentDestinations)
                {
                    var entityShipmentDestination = _shipmentDestinationService.Get(x => x.Id == shipmentDestination.Id).FirstOrDefault();
                    await _shipmentDestinationService.DeleteAsyn(entityShipmentDestination);
                }
                var entityShipment = Get(x => x.Id == shipment.Id).FirstOrDefault();
                await DeleteAsyn(entityShipment);

            }
        }

        //public TaskOfDriverModel TasksOfDriver(string driverId)
        //{
        //    int taskOfCollections = _orderService.GetGroupFarmOrderForDriver(driverId, false, 1, 1).Result.Metadata.Total;
        //    int taskOfDeliveries = _orderService.DeliveryToCustomerForDriver(driverId, false, 1, 1).Result.Metadata.Total;
        //    int taskOfShipments = GetShipMentForDriver(driverId, "0", 1, 1).Result.Metadata.Total;
        //    var tasks = new TaskOfDriverModel { TaskOfCollections = taskOfCollections, TaskOfDeliveries = taskOfDeliveries, TaskOfShipments = taskOfShipments };
        //    return tasks;
        //}

        // orders

        public async Task<DynamicModelsResponse<OrderOfCustomerModel>> GetOrderOfCustomer(string customerId, int page, int size)
        {
            var orders = await _orderService.Get(x => x.CustomerId == customerId && !x.Payments.Any(x => x.Status == (int)PaymentEnum.Chưathanhtoán && x.PaymentTypeId != 1)).ProjectTo<OrderOfCustomerModel>(_mapper).OrderByDescending(x => x.CreateAt).ToListAsync();

            foreach (var order in orders)
            {
                var campaign = _campaignService.Get(x => x.Id == order.CampaignId).FirstOrDefault();
                order.CampaignName = campaign.Name;
                order.Status = order.Status switch
                {
                    "0" => "Chờ xác nhận",
                    "1" => "Đang chuẩn bị hàng",
                    "2" => "Chờ bên giao hàng",
                    "3" => $"Đã đến {_wareHouseService.Get(x => x.WareHouseZones.Any(y => y.ZoneId == campaign.CampaignZoneId)).FirstOrDefault().Name}",
                    "4" => "Đang vận chuyển",
                    "5" => $"Đã đến kho",
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

                order.DateTimeParse = order.CreateAt.ToString("HH:mm dd/MM/yyyy");
                foreach (var payment in order.Payments)
                {
                    payment.Status = payment.Status switch
                    {
                        "0" => "Chưa thanh toán",
                        "1" => "Đã thanh toán",
                        "2" => "Đã huỷ",
                        _ => ""
                    };
                    payment.TypeName = _paymentTypeService.Get(x => x.Id == payment.PaymentTypeId).FirstOrDefault().Name;
                }
            }

            var resultPaging = orders.PagingList(page, size, CommonConstants.LimitPaging, CommonConstants.DefaultPaging);
            var result = new DynamicModelsResponse<OrderOfCustomerModel>
            {
                Metadata = new PagingMetadata { Page = page, Size = size, Total = resultPaging.Item1 },
                Data = resultPaging.Item2
            };
            return result;
        }

        // get user

        public async Task<List<UserDriverModel>> GetAllDriverInWareHouse(int warehouseId, int type)
        {
            var users = await _userManager.Users.Where(x => x.WareHouseId == warehouseId && x.Type == type).ProjectTo<UserDriverModel>(_mapper).ToListAsync();
            foreach (var user in users)
            {
                if (user.Active)
                    user.Status = "Đang hoạt động";
                else
                    user.Status = "Đã bị khóa";
            }
            return users;
        }

        public async Task<List<UserDriverModel>> GetDriverInWareHouse(int warehouseId, int type)
        {
            var users = new List<UserDriverModel>();
            if (type == 1)
            {
                users = await _userManager.Users.Where(x => x.Active && x.WareHouseId == warehouseId && x.Type == 1).ProjectTo<UserDriverModel>(_mapper).ToListAsync();
                foreach (var user in users)
                {
                    var farmOrder = _farmOrderService.Get(x => x.Status == (int)FarmOrderEnum.Đangbàngiaochobênvậnchuyển && x.DriverId == user.Id).FirstOrDefault();
                    if (farmOrder == null)
                        user.Status = "Sẵn sàng";
                    else
                        user.Status = "Đang hoạt động";
                }
                return users;
            }
            else if (type == 2)
            {
                users = await _userManager.Users.Where(x => x.Active && x.WareHouseId == warehouseId && x.Type == 2).ProjectTo<UserDriverModel>(_mapper).ToListAsync();
                foreach (var user in users)
                {
                    var shipment = Get(x => x.Status == (int)ShipmentEnum.Đangvậnchuyển && x.DriverId == user.Id).FirstOrDefault();
                    if (shipment == null)
                        user.Status = "Sẵn sàng";
                    else
                        user.Status = "Đang giao hàng";
                }
            }
            return users;
        }

        public async Task<List<CustomerOrder>> GetDriverReadyInWareHouse(int warehouseId, int type)
        {
            var usersData = new List<CustomerOrder>();
            var users = new List<CustomerOrder>();
            if (type == 1)
            {
                users = await _userManager.Users.Where(x => x.Active && x.WareHouseId == warehouseId && x.Type == 1).ProjectTo<CustomerOrder>(_mapper).ToListAsync();
                foreach (var user in users)
                {
                    var farmOrder = _farmOrderService.Get(x => x.Status == (int)FarmOrderEnum.Đangbàngiaochobênvậnchuyển && x.DriverId == user.Id).FirstOrDefault();
                    var order = _orderService.Get(x => x.Status == (int)OrderEnum.Đanggiaohàng && x.DriverId == user.Id).FirstOrDefault();

                    if (farmOrder == null && order == null)
                        usersData.Add(new CustomerOrder { Id = user.Id, Name = user.Name });
                }
            }
            else if (type == 2)
            {
                users = await _userManager.Users.Where(x => x.Active && x.WareHouseId == warehouseId && x.Type == 2).ProjectTo<CustomerOrder>(_mapper).ToListAsync();
                foreach (var user in users)
                {
                    var shipment = Get(x => x.Status == (int)ShipmentEnum.Đangvậnchuyển && x.DriverId == user.Id).FirstOrDefault();
                    if (shipment == null)
                        usersData.Add(new CustomerOrder { Id = user.Id, Name = user.Name });
                }
            }
            return usersData;
        }
    }
}
