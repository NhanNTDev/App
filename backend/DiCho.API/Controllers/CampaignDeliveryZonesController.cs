//using AutoMapper;
//using Microsoft.AspNetCore.Http;
//using Microsoft.AspNetCore.Mvc;
//using DiCho.DataService.Models;
//using DiCho.DataService.Services;
//using System.Linq;
//namespace DiCho.API.Controllers
//{
//    [ApiController]
//    [ApiVersion("1")]
//    [Route("api/v{version:apiVersion}/campaign-delivery-zones")]
//    public partial class CampaignDeliveryZonesController : ControllerBase
//    {
//        private readonly ICampaignDeliveryZoneService _campaignDeliveryZoneService;
//        public CampaignDeliveryZonesController(ICampaignDeliveryZoneService campaignDeliveryZoneService){
//            _campaignDeliveryZoneService=campaignDeliveryZoneService;
//        }
//        [HttpGet]
//        [MapToApiVersion("1")]
//        public IActionResult Gets()
//        {
//            return Ok(_campaignDeliveryZoneService.Get().ToList());
//        }
//        [HttpGet("{id}")]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status200OK)]
//        [ProducesResponseType(StatusCodes.Status404NotFound)]
//        public IActionResult GetById(int id)
//        {
//            return Ok(_campaignDeliveryZoneService.Get(id));
//        }
//        [HttpPost]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status201Created)]
//        [ProducesResponseType(StatusCodes.Status400BadRequest)]
//        public IActionResult Create(CampaignDeliveryZone entity)
//        {
//            _campaignDeliveryZoneService.Create(entity);
//            return  CreatedAtAction(nameof(GetById), new { id = entity}, entity);
//        }
//        [HttpPut("{id}")]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status400BadRequest)]
//        public IActionResult Update(int id,CampaignDeliveryZone entity)
//        {
//            _campaignDeliveryZoneService.Update(entity);
//            return Ok();
//        }
//        [HttpDelete("{id}")]
//        [MapToApiVersion("1")]
//        public IActionResult Delete(int id,CampaignDeliveryZone entity)
//        {
//            _campaignDeliveryZoneService.Delete(entity);
//            return Ok();
//        }
//        [MapToApiVersion("1")]
//        [HttpGet("count")]
//        public IActionResult Count()
//        {
//            return Ok(_campaignDeliveryZoneService.Count());
//        }
//    }
//}
