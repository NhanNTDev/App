using DiCho.DataService.Services;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace DiCho.API.Controllers
{
    [ApiController]
    [ApiVersion("1")]
    [Route("api/v{version:apiVersion}/payments")]
    public partial class PaymentsController : ControllerBase
    {
        private readonly IPaymentService _paymentService;
        public PaymentsController(IPaymentService paymentService)
        {
            _paymentService = paymentService;
        }

        /// <summary>
        /// get payments
        /// </summary>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Gets()
        {
            return Ok(await _paymentService.Gets());
        }

        /// <summary>
        /// get a payment by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        //[Authorize()]
        [HttpGet("{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> GetById(int id)
        {
            return Ok(await _paymentService.GetById(id));
        }

    }
}
