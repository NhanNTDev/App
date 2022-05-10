using DiCho.DataService.Commons;
using DiCho.DataService.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DiCho.API.Controllers
{
    [Route("api/v{version:apiVersion}/user-follows")]
    [ApiVersion("1")]
    [ApiController]
    public class UserFollowsController : ControllerBase
    {
        private readonly IUserFollowService _userFollowService;
        public UserFollowsController(IUserFollowService userFollowService)
        {
            _userFollowService = userFollowService;
        }

        /// <summary>
        /// get suggest users follow
        /// </summary>
        /// <param name="customerId"></param>
        /// <param name="page"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet]
        [MapToApiVersion("1")]
        public async Task<IActionResult> SuggestListUserFollow(string customerId, int page = CommonConstants.DefaultPage, int size = CommonConstants.DefaultPaging)
        {
            return Ok(await _userFollowService.SuggestListUserFollow(customerId, page, size));
        }

        /// <summary>
        /// create follow user
        /// </summary>
        /// <param name="customerId"></param>
        /// <param name="followingId"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpPost]
        [MapToApiVersion("1")]
        public async Task<IActionResult> UserFollowCustomer(string customerId, string followingId)
        {
            await _userFollowService.UserFollowCustomer(customerId, followingId);
            return Ok("Theo dõi thành công");
        }

        /// <summary>
        /// cancel follow user
        /// </summary>
        /// <param name="customerId"></param>
        /// <param name="followingId"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpDelete]
        [MapToApiVersion("1")]
        public async Task<IActionResult> CancelFollow(string customerId, string followingId)
        {
            await _userFollowService.CancelFollow(customerId, followingId);
            return Ok("Bỏ theo dõi thành công");
        }

        /// <summary>
        /// get followers of customer
        /// </summary>
        /// <param name="customerId"></param>
        /// <param name="page"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("follower/{customerId}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> GetUserFollowCustomer(string customerId, int page = CommonConstants.DefaultPage, int size = CommonConstants.DefaultPaging)
        {
            return Ok(await _userFollowService.GetUserFollowCustomer(customerId, page, size));
        }

        /// <summary>
        /// count followers of customer
        /// </summary>
        /// <param name="customerId"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("follower/count")]
        [MapToApiVersion("1")]
        public IActionResult CountUserFollowCustomer(string customerId)
        {
            return Ok(_userFollowService.CountUserFollowCustomer(customerId));
        }

        /// <summary>
        /// get following users of customer
        /// </summary>
        /// <param name="customerId"></param>
        /// <param name="page"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("following/{customerId}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> GetUserCustomerFollow(string customerId, int page = CommonConstants.DefaultPage, int size = CommonConstants.DefaultPaging)
        {
            return Ok(await _userFollowService.GetUserCustomerFollow(customerId, page, size));
        }

        /// <summary>
        /// count following users of customer
        /// </summary>
        /// <param name="customerId"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("following/count")]
        [MapToApiVersion("1")]
        public IActionResult CountUserCustomerFollow(string customerId)
        {
            return Ok(_userFollowService.CountUserCustomerFollow(customerId));
        }

    }
}
