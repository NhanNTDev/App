using DiCho.DataService.Services;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace DiCho.API.Controllers
{
    [Route("api/v{version:apiVersion}/webhooks")]
    [ApiVersion("1")]
    [ApiController]
    public class WebhooksController : ControllerBase
    {
        private readonly IZaloService _zaloService;

        public WebhooksController(IZaloService zaloService)
        {
            _zaloService = zaloService;
        }

        /// <summary>
        /// send message from zalo oa
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        [MapToApiVersion("1")]
        public async Task<IActionResult> SendMessage()
        {
            await _zaloService.SendMessage();
            return Ok("Ok");
        }

        /// <summary>
        /// get info zalo user
        /// </summary>
        /// <returns></returns>
        [HttpPost("login/zalo")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> GetInfo(string code)
        {
            return Ok(await _zaloService.GetInfo(code));
        }

    }
}
