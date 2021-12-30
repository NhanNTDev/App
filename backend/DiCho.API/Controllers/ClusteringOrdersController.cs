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
//    [Route("api/v{version:apiVersion}/clustering-orders")]
//    public partial class ClusteringOrdersController : ControllerBase
//    {
//        private readonly IClusteringOrderService _clusteringOrderService;
//        public ClusteringOrdersController(IClusteringOrderService clusteringOrderService){
//            _clusteringOrderService=clusteringOrderService;
//        }
//        [HttpGet]
//        [MapToApiVersion("1")]
//        public IActionResult Gets()
//        {
//            return Ok(_clusteringOrderService.Get().ToList());
//        }
//        [HttpGet("{id}")]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status200OK)]
//        [ProducesResponseType(StatusCodes.Status404NotFound)]
//        public IActionResult GetById(int id)
//        {
//            return Ok(_clusteringOrderService.Get(id));
//        }
//        [HttpPost]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status201Created)]
//        [ProducesResponseType(StatusCodes.Status400BadRequest)]
//        public IActionResult Create(ClusteringOrder entity)
//        {
//            _clusteringOrderService.Create(entity);
//            return  CreatedAtAction(nameof(GetById), new { id = entity}, entity);
//        }
//        [HttpPut("{id}")]
//        [MapToApiVersion("1")]
//        [ProducesResponseType(StatusCodes.Status400BadRequest)]
//        public IActionResult Update(int id,ClusteringOrder entity)
//        {
//            _clusteringOrderService.Update(entity);
//            return Ok();
//        }
//        [HttpDelete("{id}")]
//        [MapToApiVersion("1")]
//        public IActionResult Delete(int id,ClusteringOrder entity)
//        {
//            _clusteringOrderService.Delete(entity);
//            return Ok();
//        }
//        [MapToApiVersion("1")]
//        [HttpGet("count")]
//        public IActionResult Count()
//        {
//            return Ok(_clusteringOrderService.Count());
//        }
//    }
//}
