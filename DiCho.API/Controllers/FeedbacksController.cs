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
//    [Route("api/v{version:apiVersion}/feedbacks")]
//    public partial class FeedbacksController : ControllerBase
//    {
//        private readonly IFeedbackService _feedbackService;
//        public FeedbacksController(IFeedbackService feedbackService){
//            _feedbackService=feedbackService;
//        }
//        [HttpGet]
//        [MapToApiVersion("1")]
//        public IActionResult Gets()
//        {
//            return Ok(_feedbackService.Get().ToList());
//        }
//        [HttpGet("{id}")]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status200OK)]
//        [ProducesResponseType(StatusCodes.Status404NotFound)]
//        public IActionResult GetById(int id)
//        {
//            return Ok(_feedbackService.Get(id));
//        }
//        [HttpPost]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status201Created)]
//        [ProducesResponseType(StatusCodes.Status400BadRequest)]
//        public IActionResult Create(Feedback entity)
//        {
//            _feedbackService.Create(entity);
//            return  CreatedAtAction(nameof(GetById), new { id = entity}, entity);
//        }
//        [HttpPut("{id}")]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status400BadRequest)]
//        public IActionResult Update(int id,Feedback entity)
//        {
//            _feedbackService.Update(entity);
//            return Ok();
//        }
//        [HttpDelete("{id}")]
//        [MapToApiVersion("1")]
//        public IActionResult Delete(int id,Feedback entity)
//        {
//            _feedbackService.Delete(entity);
//            return Ok();
//        }
//        [MapToApiVersion("1")]
//        [HttpGet("count")]
//        public IActionResult Count()
//        {
//            return Ok(_feedbackService.Count());
//        }
//    }
//}
