namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IAddressService:IBaseService<Address>
    {
    }
    public partial class AddressService:BaseService<Address>,IAddressService
    {
        public AddressService(IAddressRepository repository):base(repository){}
    }
}
