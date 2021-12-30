using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using DiCho.DataService.Models;
using DiCho.DataService.Services;
using System.Linq;
using DiCho.DataService.ViewModels;
using System.Threading.Tasks;
using DiCho.DataService.Commons;

namespace DiCho.API.Controllers
{
    [ApiController]
    [ApiVersion("1")]
    [Route("api/v{version:apiVersion}/product-categories")]
    public partial class ProductCategoriesController : ControllerBase
    {
        private readonly IProductCategoryService _productCategoryService;
        public ProductCategoriesController(IProductCategoryService productCategoryService){
            _productCategoryService=productCategoryService;
        }
        /// <summary>
        /// get category of product
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpGet]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Gets([FromQuery] ProductCategoryModel model)
        {
            return Ok(await _productCategoryService.Gets(model));
        }
        //[HttpGet("{id}")]
        //[MapToApiVersion("1")]
        //[ProducesResponseType(StatusCodes.Status200OK)]
        //[ProducesResponseType(StatusCodes.Status404NotFound)]
        //public IActionResult GetById(int id)
        //{
        //    return Ok(_productCategoryService.Get(id));
        //}
        //[HttpPost]
        //[MapToApiVersion("1")]
        //[ProducesResponseType(StatusCodes.Status201Created)]
        //[ProducesResponseType(StatusCodes.Status400BadRequest)]
        //public IActionResult Create(ProductCategory entity)
        //{
        //    _productCategoryService.Create(entity);
        //    return  CreatedAtAction(nameof(GetById), new { id = entity}, entity);
        //}
        //[HttpPut("{id}")]
        //[MapToApiVersion("1")]
        //[ProducesResponseType(StatusCodes.Status400BadRequest)]
        //public IActionResult Update(int id,ProductCategory entity)
        //{
        //    _productCategoryService.Update(entity);
        //    return Ok();
        //}
        //[HttpDelete("{id}")]
        //[MapToApiVersion("1")]
        //public IActionResult Delete(int id,ProductCategory entity)
        //{
        //    _productCategoryService.Delete(entity);
        //    return Ok();
        //}
        //[MapToApiVersion("1")]
        //[HttpGet("count")]
        //public IActionResult Count()
        //{
        //    return Ok(_productCategoryService.Count());
        //}
    }
}
