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
    [Route("api/v{version:apiVersion}/farms")]
    public partial class FarmsController : ControllerBase
    {
        private readonly IFarmService _farmService;
        public FarmsController(IFarmService farmService){
            _farmService=farmService;
        }
        /// <summary>
        /// get farm
        /// </summary>
        /// <param name="model"></param>
        /// <param name="page"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        [HttpGet]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Gets([FromQuery] FarmModel model, int page = CommonConstants.DefaultPage, int size = CommonConstants.DefaultPaging)
        {
            return Ok(await _farmService.Gets(model, page, size));
        }
        /// <summary>
        /// get farm by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("{id}")]
        [MapToApiVersion("1")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            return Ok(await _farmService.GetById(id));
        }
        //[HttpPost]
        //[MapToApiVersion("1")]
        //[ProducesResponseType(StatusCodes.Status201Created)]
        //[ProducesResponseType(StatusCodes.Status400BadRequest)]
        //public IActionResult Create(Farm entity)
        //{
        //    _farmService.Create(entity);
        //    return  CreatedAtAction(nameof(GetById), new { id = entity}, entity);
        //}
        //[HttpPut("{id}")]
        //[MapToApiVersion("1")]
        //[ProducesResponseType(StatusCodes.Status400BadRequest)]
        //public IActionResult Update(int id,Farm entity)
        //{
        //    _farmService.Update(entity);
        //    return Ok();
        //}
        //[HttpDelete("{id}")]
        //[MapToApiVersion("1")]
        //public IActionResult Delete(int id,Farm entity)
        //{
        //    _farmService.Delete(entity);
        //    return Ok();
        //}
        //[MapToApiVersion("1")]
        //[HttpGet("count")]
        //public IActionResult Count()
        //{
        //    return Ok(_farmService.Count());
        //}
    }
}
