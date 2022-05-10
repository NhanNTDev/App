using DiCho.DataService.Commons;
using DiCho.DataService.Services;
using DiCho.DataService.ViewModels;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DiCho.API.Controllers
{
    [ApiController]
    [ApiVersion("1")]
    [Route("api/v{version:apiVersion}/posts")]
    public class PostsController : ControllerBase
    {
        private readonly IPostService _postService;
        public PostsController(IPostService postService)
        {
            _postService = postService;
        }

        ///// <summary>
        ///// get user post
        ///// </summary>
        ///// <param name="customerId"></param>
        ///// <returns></returns>
        //[HttpGet("customer")]
        //[MapToApiVersion("1")]
        //public async Task<IActionResult> GetUserOfPost(string customerId)
        //{
        //    return Ok(await _postService.GetUserOfPost(customerId));
        //}

        /// <summary>
        /// get post of user follow and published
        /// </summary>
        /// <param name="customerId"></param>
        /// <param name="model"></param>
        /// <param name="page"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Get(string customerId, [FromQuery] PostModel model, int page = CommonConstants.DefaultPage, int size = CommonConstants.DefaultPaging)
        {
            return Ok(await _postService.GetPost(customerId, model, page, size));
        }

    }
}
