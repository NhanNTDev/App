using DiCho.DataService.Services;
using DiCho.DataService.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace DiCho.API.Controllers
{
    [ApiController]
    [ApiVersion("1")]
    [Route("api/v{version:apiVersion}/addresss")]
    public partial class AddresssController : ControllerBase
    {
        private readonly IAddressService _addressService;
        public AddresssController(IAddressService addressService)
        {
            _addressService = addressService;
        }

        /// <summary>
        /// get address of customer
        /// </summary>
        /// <param name="customerId"></param>
        /// <returns></returns>
        //[Authorize(Roles = "customer")]
        [HttpGet]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Get(string customerId)
        {
            return Ok(await _addressService.Gets(customerId));
        }

        /// <summary>
        /// create a address of farmer
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        //[Authorize(Roles = "customer")]
        [HttpPost]
        [MapToApiVersion("1")]

        public async Task<IActionResult> Create(AddressCreateModel entity)
        {
            await _addressService.Create(entity);
            return Ok("Create successfully!");
        }

        /// <summary>
        /// update a Address
        /// </summary>
        /// <param name="id"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        //[Authorize(Roles = "customer")]
        [HttpPut("{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Update(int id, AddressUpdateModel entity)
        {
            await _addressService.Update(id, entity);
            return Ok("Update successfully!");
        }

        /// <summary>
        /// delete a address
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        //[Authorize(Roles = "customer")]
        [HttpDelete("{id}")]
        [MapToApiVersion("1")]
        public async Task<IActionResult> Delete(int id)
        {
            await _addressService.Delete(id);
            return Ok("Delete successfully!");
        }
    }
}
