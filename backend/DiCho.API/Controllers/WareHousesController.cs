using DiCho.DataService.Services;
using DiCho.DataService.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace DiCho.API.Controllers
{
    [ApiController]
    [Route("api/v{version:apiVersion}/ware-houses")]
    public partial class WareHousesController : ControllerBase
    {
        private readonly IWareHouseService _wareHouseService;
        private readonly IShipmentService _shipmentService;
        private readonly IVehicleRoutingService _vehicleRoutingService;
        public WareHousesController(IWareHouseService wareHouseService, IShipmentService shipmentService, IVehicleRoutingService vehicleRoutingService)
        {
            _wareHouseService = wareHouseService;
            _shipmentService = shipmentService;
            _vehicleRoutingService = vehicleRoutingService;
        }

        /// <summary>
        /// get warehouses
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet]
        [MapToApiVersion("1")]
        public async Task<IActionResult> GetAllWarehouse([FromQuery] WareHouseModel model)
        {
            return Ok(await _wareHouseService.GetAllWarehouse(model));
        }

        /// <summary>
        /// get warehouse by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> GetWarehouse(int id)
        {
            return Ok(await _wareHouseService.GetWarehouse(id));
        }

        /// <summary>
        /// get warehouse by id
        /// </summary>
        /// <param name="warehouseManagerId"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("manager/{warehouseManagerId}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> GetWarehouseByWarehouseManager(string warehouseManagerId)
        {
            return Ok(await _wareHouseService.GetWarehouseByWarehouseManager(warehouseManagerId));
        }

        /// <summary>
        /// create a warehouse
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpPost()]
        [MapToApiVersion("1")]
        public async Task<IActionResult> CreateWarehouse(WareHouseCreateModel model)
        {
            await _wareHouseService.CreateWarehouse(model);
            return Ok("Create successfully!");
        }

        /// <summary>
        /// update a warehouse
        /// </summary>
        /// <param name="id"></param>
        /// <param name="model"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpPut("{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> UpdateWarehouse(int id, WareHouseUpdateModel model)
        {
            await _wareHouseService.UpdateWarehouse(id, model);
            return Ok("Update successfully!");
        }

        /// <summary>
        /// delete a warehouse
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpDelete("{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> DeleteWarehouse(int id)
        {
            await _wareHouseService.DeleteWarehouse(id);
            return Ok("Delete successfully!");
        }

        /// <summary>
        /// Dashboard of warehouse manager
        /// </summary>
        /// <param name="warehouseId"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("dashboard/{warehouseId}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> DashBoardOfWarehouse(int warehouseId)
        {
            return Ok(await _vehicleRoutingService.DashBoardOfWarehouse(warehouseId));
        }

    }
}
