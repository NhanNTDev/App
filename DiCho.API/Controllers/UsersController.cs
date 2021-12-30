using DiCho.Core.Custom;
using DiCho.DataService.Services;
using DiCho.DataService.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;

namespace DiCho.API.Controllers
{
    [ApiController]
    [Route("api/v{version:apiVersion}/[controller]")]

    public class UsersController : ControllerBase
    {
        private readonly IJWTService _jwtService;
        public UsersController(IJWTService jwtService)
        {
            _jwtService = jwtService;
        }
        [HttpPost]
        [MapToApiVersion("1")]
        [ProducesResponseType(typeof(string), (int)HttpStatusCode.OK)]
        [ProducesResponseType(typeof(ErrorResponse), (int)HttpStatusCode.InternalServerError)]
        public async Task<IActionResult> Create([FromBody] AspNetUsersModel model)
        {
            return Ok(await _jwtService.CreateUserAsync(model));
        }
        [HttpPost]
        [AllowAnonymous]
        [MapToApiVersion("1")]
        [Route("login")]
        [ProducesResponseType(typeof(TokenModel), (int)HttpStatusCode.OK)]
        [ProducesResponseType(typeof(ErrorResponse), (int)HttpStatusCode.InternalServerError)]
        public async Task<IActionResult> Login([FromBody] AspNetUserLoginModel model)
        {
            return Ok(await _jwtService.Login(model));
        }
        [HttpPut("{id}")]
        [MapToApiVersion("1")]
        [Authorize]
        [ProducesResponseType(typeof(string), (int)HttpStatusCode.OK)]
        [ProducesResponseType(typeof(ErrorResponse), (int)HttpStatusCode.Unauthorized)]
        [ProducesResponseType(typeof(ErrorResponse), (int)HttpStatusCode.InternalServerError)]
        public async Task<IActionResult> UpdateUserAsync([FromBody] AspNetUsersUpdateModel model, string id)
        {
            return Ok(await _jwtService.UpdateUserAsync(model, id));
        }
    }
}
