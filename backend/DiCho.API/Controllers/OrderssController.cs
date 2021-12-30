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
//    [Route("api/v{version:apiVersion}/orderss")]
//    public partial class OrderssController : ControllerBase
//    {
//        private readonly IOrderService _ordersService;
//        public OrderssController(IOrderService ordersService){
//            _ordersService=ordersService;
//        }
//        [HttpGet]
//        [MapToApiVersion("1")]
//        public IActionResult Gets()
//        {
//            return Ok(_ordersService.Get().ToList());
//        }
//        [HttpGet("{id}")]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status200OK)]
//        [ProducesResponseType(StatusCodes.Status404NotFound)]
//        public IActionResult GetById(int id)
//        {
//            return Ok(_ordersService.Get(id));
//        }
//        [HttpPost]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status201Created)]
//        [ProducesResponseType(StatusCodes.Status400BadRequest)]
//        public IActionResult Create(Order entity)
//        {
//            _ordersService.Create(entity);
//            return  CreatedAtAction(nameof(GetById), new { id = entity}, entity);
//        }
//        [HttpPut("{id}")]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status400BadRequest)]
//        public IActionResult Update(int id,Order entity)
//        {
//            _ordersService.Update(entity);
//            return Ok();
//        }
//        [HttpDelete("{id}")]
//        [MapToApiVersion("1")]
//        public IActionResult Delete(int id,Order entity)
//        {
//            _ordersService.Delete(entity);
//            return Ok();
//        }
//        [MapToApiVersion("1")]
//        [HttpGet("count")]
//        public IActionResult Count()
//        {
//            return Ok(_ordersService.Count());
//        }
//    }
//}
