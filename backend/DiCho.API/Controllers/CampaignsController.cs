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
    [Route("api/v{version:apiVersion}/campaigns")]
    public partial class CampaignsController : ControllerBase
    {
        private readonly ICampaignService _campaignService;
        public CampaignsController(ICampaignService campaignService)
        {
            _campaignService = campaignService;
        }
        /// <summary>
        /// get campaign
        /// </summary>
        /// <param name="model"></param>
        /// <param name="page"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        [HttpGet]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Gets([FromQuery] CampaignModel model, int page = CommonConstants.DefaultPage, int size = CommonConstants.DefaultPaging)
        {
            return Ok(await _campaignService.Gets(model, page, size));
        }
        /// <summary>
        /// get campaign by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> GetById(int id)
        {
            return Ok(await _campaignService.GetById(id));
        }
        //[HttpPost]
        //[MapToApiVersion("1")]
        //[ProducesResponseType(StatusCodes.Status201Created)]
        //[ProducesResponseType(StatusCodes.Status400BadRequest)]
        //public IActionResult Create(Campaign entity)
        //{
        //    _campaignService.Create(entity);
        //    return CreatedAtAction(nameof(GetById), new { id = entity }, entity);
        //}
        //[HttpPut("{id}")]
        //[MapToApiVersion("1")]
        //[ProducesResponseType(StatusCodes.Status400BadRequest)]
        //public IActionResult Update(int id, Campaign entity)
        //{
        //    _campaignService.Update(entity);
        //    return Ok();
        //}
        //[HttpDelete("{id}")]
        //[MapToApiVersion("1")]
        //public IActionResult Delete(int id, Campaign entity)
        //{
        //    _campaignService.Delete(entity);
        //    return Ok();
        //}
        //[MapToApiVersion("1")]
        //[HttpGet("count")]
        //public IActionResult Count()
        //{
        //    return Ok(_campaignService.Count());
        //}
    }
}
