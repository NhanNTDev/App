using AutoMapper;
using DiCho.DataService.Models;
using DiCho.DataService.ViewModels;

namespace DiCho.DataService.AutoMapperModule
{
    public static class AddressModule
    {
        public static void ConfigAddressModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<Address, AddressModel>();
            mc.CreateMap<AddressModel, Address>();

            mc.CreateMap<Address, AddressCreateModel>();
            mc.CreateMap<AddressCreateModel, Address>();

            mc.CreateMap<Address, AddressUpdateModel>();
            mc.CreateMap<AddressUpdateModel, Address>();

        }
    }
}
