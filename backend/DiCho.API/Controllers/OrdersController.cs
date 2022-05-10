using DiCho.DataService.Commons;
using DiCho.DataService.Services;
using DiCho.DataService.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace DiCho.API.Controllers
{
    [ApiController]
    [ApiVersion("1")]
    [Route("api/v{version:apiVersion}/orders")]
    public partial class OrdersController : ControllerBase
    {
        private readonly IOrderService _orderService;
        private readonly IShipmentService _shipmentService;
        private readonly IVehicleRoutingService _vehicleRoutingService;
        public OrdersController(IOrderService orderService, IShipmentService shipmentService, IVehicleRoutingService vehicleRoutingService)
        {
            _orderService = orderService;
            _shipmentService = shipmentService;
            _vehicleRoutingService = vehicleRoutingService;
        }

        /// <summary>
        /// get orders
        /// </summary>
        /// <param name="model"></param>
        /// <param name="page"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet]
        [MapToApiVersion("1")]
        public async Task<IActionResult> GetAllOrder([FromQuery] OrderModel model, int page = CommonConstants.DefaultPage, int size = CommonConstants.DefaultPaging)
        {
            return Ok(await _orderService.GetAllOrder(model, page, size));
        }

        /// <summary>
        /// get orders
        /// </summary>
        /// <param name="customerId"></param>
        /// <param name="page"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("customer/{customerId}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> GetOrderOfCustomer(string customerId, int page = CommonConstants.DefaultPage, int size = CommonConstants.DefaultPaging)
        {
            return Ok(await _shipmentService.GetOrderOfCustomer(customerId, page, size));
        }

        /// <summary>
        /// get a order by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> GetById(int id)
        {
            return Ok(await _orderService.GetById(id));
        }

        /// <summary>
        /// get ship cost
        /// </summary>
        /// <param name="productCost"></param>
        /// <param name="address"></param>
        /// <param name="campaignId"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("ship-cost")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> ShipCostOfOrder(double productCost, string address, int campaignId)
        {
            return Ok(await _orderService.ShipCostOfOrder(productCost, address, campaignId));
        }

        /// <summary>
        /// create a order
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpPost]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Create(OrderCreateModelInput entity)
        {
            var result = await _orderService.Create(entity);
            return Ok(result);
        }

        /// <summary>
        /// feed back a order
        /// </summary>
        /// <param name="id"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpPut("feedback/{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Feedback(int id, FeedbackOrderModel entity)
        {
            await _orderService.Feedback(id, entity);
            return Ok("Update successfully!");
        }

        /// <summary>
        /// change status for order
        /// </summary>
        /// <param name="id"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpPut("{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Update(int id, OrderUpdateModel entity)
        {
            await _orderService.UpdateOrderStatus(id, entity);
            return Ok("Update successfully!");
        }

        /// <summary>
        /// reject/cancel a order
        /// </summary>
        /// <param name="id"></param>
        /// <param name="note"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpDelete("{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> RejectOrder(int id, string note)
        {
            await _orderService.RejectOrder(id, note);
            return Ok("Reject successfully!");
        }

        /// <summary>
        /// update driver for order
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpPut("warehouse/update-driver")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> UpdateDriverForOrderByWarehouse(List<UpdateDriverForOrderByWarehouse> model)
        {
            await _orderService.AssignTaskOrderForDriver(model);
            return Ok("Update successfully!");
        }

        /// <summary>
        /// get orders in warehouse
        /// </summary>
        /// <param name="warehouseId"></param>
        /// <param name="assigned"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("warehouse/{warehouseId}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> GetOrderToDelivery(int warehouseId, bool assigned)
        {
            return Ok(await _vehicleRoutingService.GetOrderToDelivery(warehouseId, assigned));
        }

        /// <summary>
        /// get detail of delivery by code
        /// </summary>
        /// <param name="warehouseId"></param>
        /// <param name="deliveryCode"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("warehouse/{warehouseId}/detail")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> DeliveryOfOrderDetail(int warehouseId, string deliveryCode)
        {
            return Ok(await _vehicleRoutingService.DeliveryOfOrderDetail(warehouseId, deliveryCode));
        }

        /// <summary>
        /// get order for driver
        /// </summary>
        /// <param name="driverId"></param>
        /// <param name="completed"></param>
        /// <param name="page"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("driver/{driverId}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> DeliveryToCustomerForDriver(string driverId, bool completed, int page = CommonConstants.DefaultPage, int size = CommonConstants.DefaultPaging)
        {
            return Ok(await _vehicleRoutingService.DeliveryToCustomerForDriver(driverId, completed, page, size));
        }

        /// <summary>
        /// check bool of delivery driver
        /// </summary>
        /// <param name="deliveryCode"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("driver/bool")]
        [MapToApiVersion("1")]
        public ActionResult DeliveryToCustomerForDriverBool(string deliveryCode)
        {
            return Ok( _orderService.DeliveryToCustomerForDriverBool(deliveryCode));
        }
    }
}
