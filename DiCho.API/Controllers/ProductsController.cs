using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using DiCho.DataService.Models;
using DiCho.DataService.Services;
using System.Linq;
using System.Threading.Tasks;

namespace DiCho.API.Controllers
{
    [ApiController]
    [ApiVersion("1")]
    [Route("api/v{version:apiVersion}/products")]
    public partial class ProductsController : ControllerBase
    {
        private readonly IProductService _productService;
        public ProductsController(IProductService productService)
        {
            _productService = productService;
        }
        //[HttpGet]
        //[MapToApiVersion("1")]
        //public IActionResult Gets()
        //{
        //    return Ok(_productService.Get().ToList());
        //}
        //[HttpGet("{id}")]
        //[MapToApiVersion("1")]
        //[ProducesResponseType(StatusCodes.Status200OK)]
        //[ProducesResponseType(StatusCodes.Status404NotFound)]
        //public IActionResult GetById(int id)
        //{
        //    return Ok(_productService.Get(id));
        //}
        //[HttpPost]
        //[MapToApiVersion("1")]
        //[ProducesResponseType(StatusCodes.Status201Created)]
        //[ProducesResponseType(StatusCodes.Status400BadRequest)]
        //public IActionResult Create(Product entity)
        //{
        //    _productService.Create(entity);
        //    return CreatedAtAction(nameof(GetById), new { id = entity }, entity);
        //}
        //[HttpPut("{id}")]
        //[MapToApiVersion("1")]
        //[ProducesResponseType(StatusCodes.Status400BadRequest)]
        //public IActionResult Update(int id, Product entity)
        //{
        //    _productService.Update(entity);
        //    return Ok();
        //}
        //[HttpDelete("{id}")]
        //[MapToApiVersion("1")]
        //public IActionResult Delete(int id, Product entity)
        //{
        //    _productService.Delete(entity);
        //    return Ok();
        //}
        /// <summary>
        /// count product by categoryId
        /// </summary>
        /// <param name="categoryId"></param>
        /// <returns></returns>
        [MapToApiVersion("1")]
        [HttpGet("count{categoryId}")]
        public async Task<IActionResult> Count(int categoryId)
        {
            return Ok(await _productService.GetCountProductbyCategoryId(categoryId));
        }
    }
}
