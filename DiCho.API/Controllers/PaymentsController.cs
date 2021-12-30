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
//    [Route("api/v{version:apiVersion}/payments")]
//    public partial class PaymentsController : ControllerBase
//    {
//        private readonly IPaymentService _paymentService;
//        public PaymentsController(IPaymentService paymentService){
//            _paymentService=paymentService;
//        }
//        [HttpGet]
//        [MapToApiVersion("1")]
//        public IActionResult Gets()
//        {
//            return Ok(_paymentService.Get().ToList());
//        }
//        [HttpGet("{id}")]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status200OK)]
//        [ProducesResponseType(StatusCodes.Status404NotFound)]
//        public IActionResult GetById(int id)
//        {
//            return Ok(_paymentService.Get(id));
//        }
//        [HttpPost]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status201Created)]
//        [ProducesResponseType(StatusCodes.Status400BadRequest)]
//        public IActionResult Create(Payment entity)
//        {
//            _paymentService.Create(entity);
//            return  CreatedAtAction(nameof(GetById), new { id = entity}, entity);
//        }
//        [HttpPut("{id}")]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status400BadRequest)]
//        public IActionResult Update(int id,Payment entity)
//        {
//            _paymentService.Update(entity);
//            return Ok();
//        }
//        [HttpDelete("{id}")]
//        [MapToApiVersion("1")]
//        public IActionResult Delete(int id,Payment entity)
//        {
//            _paymentService.Delete(entity);
//            return Ok();
//        }
//        [MapToApiVersion("1")]
//        [HttpGet("count")]
//        public IActionResult Count()
//        {
//            return Ok(_paymentService.Count());
//        }
//    }
//}
