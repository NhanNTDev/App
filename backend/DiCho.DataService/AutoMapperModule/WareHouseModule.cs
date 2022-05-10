using AutoMapper;
using DiCho.DataService.Models;
using DiCho.DataService.ViewModels;

namespace DiCho.DataService.AutoMapperModule
{
    public static class WareHouseModule
    {
        public static void ConfigWareHouseModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<WareHouse, WareHouseModel>();
            mc.CreateMap<WareHouseModel, WareHouse>();

            mc.CreateMap<WareHouse, WareHouseDataMapModel>();
            mc.CreateMap<WareHouseDataMapModel, WareHouse>();

            mc.CreateMap<WareHouse, WareHouseUpdateModel>();
            mc.CreateMap<WareHouseUpdateModel, WareHouse>();

            mc.CreateMap<WareHouse, WareHouseCreateModel>();
            mc.CreateMap<WareHouseCreateModel, WareHouse>()
                .ForMember(des => des.Active, opt => opt.MapFrom(src => true));

        }
    }
}
