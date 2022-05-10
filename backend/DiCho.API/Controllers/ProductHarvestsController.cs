using DiCho.DataService.Commons;
using DiCho.DataService.Services;
using DiCho.DataService.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace DiCho.API.Controllers
{
    [ApiController]
    [ApiVersion("1")]
    [Route("api/v{version:apiVersion}/product-harvests")]
    public partial class ProductHarvestsController : ControllerBase
    {
        private readonly IProductHarvestService _productHarvestService;
        public ProductHarvestsController(IProductHarvestService productHarvestService)
        {
            _productHarvestService = productHarvestService;
        }

        /// <summary>
        /// get list of product harvest
        /// </summary>
        /// <param name="model"></param>
        /// <param name="farmerId"></param>
        /// <param name="page"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Gets(string farmerId, [FromQuery] ProductHarvestModel model, int page = CommonConstants.DefaultPage, int size = CommonConstants.DefaultPaging)
        {
            return Ok(await _productHarvestService.Gets(model, farmerId, page, size));
        }

        /// <summary>
        /// get a product harvest by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> GetById(int id)
        {
            return Ok(await _productHarvestService.GetById(id));
        }

        /// <summary>
        /// get a product harvest detail by Id, campaignId
        /// </summary>
        /// <param name="harvestId"></param>
        /// <param name="campaignId"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("detail/{harvestId}/{campaignId}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> HarvestDetail(int harvestId, int campaignId)
        {
            return Ok(await _productHarvestService.HarvestDetail(harvestId, campaignId));
        }

        /// <summary>
        /// create a new product harvest
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpPost]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Create([FromForm] ProductHarvestCreateInputModel entity)
        {
            await _productHarvestService.Create(entity);
            return Ok("Create successfully!");
        }

        /// <summary>
        /// update a product harvest
        /// </summary>
        /// <param name="id"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpPut("{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Update(int id, [FromForm] ProductHarvestUpdateInputModel entity)
        {
            await _productHarvestService.Update(id, entity);
            return Ok("Update successfully!");
        }

        /// <summary>
        /// delete a product harvest
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpDelete("{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Delete(int id)
        {
            await _productHarvestService.Delete(id);
            return Ok("Delete successfully!");
        }

        /// <summary>
        /// count product harvest by farmerId
        /// </summary>
        /// <param name="farmerId"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("count/{farmerId}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> CountHarvestByFarmerId(string farmerId)
        {
            return Ok(await _productHarvestService.CountHarvestByFarmerId(farmerId));
        }

        /// <summary>
        /// search product harvest by name
        /// </summary>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("search")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> SearchHarvestName(string farmerId, [FromQuery] ProductHarvestSearchNameModel model)
        {
            return Ok(await _productHarvestService.SearchHarvestName(farmerId, model));
        }
    }
}
