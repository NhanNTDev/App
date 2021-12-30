using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using DiCho.DataService.Models;
using DiCho.DataService.Services;
using System.Linq;
using System.Threading.Tasks;
using DiCho.DataService.ViewModels;
using DiCho.DataService.Commons;

namespace DiCho.API.Controllers
{
    [ApiController]
    [ApiVersion("1")]
    [Route("api/v{version:apiVersion}/campaign-applies")]
    public partial class CampaignAppliesController : ControllerBase
    {
        private readonly ICampaignApplyService _campaignApplyService;
        public CampaignAppliesController(ICampaignApplyService campaignApplyService)
        {
            _campaignApplyService = campaignApplyService;
        }
        /// <summary>
        /// get farm in campaign
        /// </summary>
        /// <param name="model"></param>
        /// <param name="page"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        [HttpGet]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Gets([FromQuery] CampaignApplyModel model, int page = CommonConstants.DefaultPage, int size = CommonConstants.DefaultPaging)
        {
            return Ok(await _campaignApplyService.Gets(model, page, size));
        }
        //[HttpGet("{id}")]
        //[MapToApiVersion("1")]
        //[ProducesResponseType(StatusCodes.Status200OK)]
        //[ProducesResponseType(StatusCodes.Status404NotFound)]
        //public IActionResult GetById(int id)
        //{
        //    return Ok(_campaignApplyService.Get(id));
        //}
        //[HttpPost]
        //[MapToApiVersion("1")]
        //[ProducesResponseType(StatusCodes.Status201Created)]
        //[ProducesResponseType(StatusCodes.Status400BadRequest)]
        //public IActionResult Create(CampaignApply entity)
        //{
        //    _campaignApplyService.Create(entity);
        //    return CreatedAtAction(nameof(GetById), new { id = entity }, entity);
        //}
        //[HttpPut("{id}")]
        //[MapToApiVersion("1")]
        //[ProducesResponseType(StatusCodes.Status400BadRequest)]
        //public IActionResult Update(int id, CampaignApply entity)
        //{
        //    _campaignApplyService.Update(entity);
        //    return Ok();
        //}
        //[HttpDelete("{id}")]
        //[MapToApiVersion("1")]
        //public IActionResult Delete(int id, CampaignApply entity)
        //{
        //    _campaignApplyService.Delete(entity);
        //    return Ok();
        //}
        //[MapToApiVersion("1")]
        //[HttpGet("count")]
        //public IActionResult Count()
        //{
        //    return Ok(_campaignApplyService.Count());
        //}
    }
}
