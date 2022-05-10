using AutoMapper;
using DiCho.DataService.Models;
using DiCho.DataService.ViewModels;

namespace DiCho.DataService.AutoMapperModule
{
    public static class HarvestOrderModule
    {
        public static void ConfigHarvestOrderModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<ProductHarvestOrder, ProductHarvestOrderModel>();
            mc.CreateMap<ProductHarvestOrderModel, ProductHarvestOrder>();

            mc.CreateMap<ProductHarvestOrder, ProductHarvestOrderCreateModel>();
            mc.CreateMap<ProductHarvestOrderCreateModel, ProductHarvestOrder>();

            mc.CreateMap<ProductHarvestOrder, ProductHarvestOrderMappingFarmOrderModel>();
            mc.CreateMap<ProductHarvestOrderMappingFarmOrderModel, ProductHarvestOrder>();

            mc.CreateMap<ProductHarvestOrder, ProductHarvestOrderOfDetailModel>();
            mc.CreateMap<ProductHarvestOrderOfDetailModel, ProductHarvestOrder>();

            mc.CreateMap<ProductHarvestOrder, ProductHarvestOrderDetailModel>();
            mc.CreateMap<ProductHarvestOrderDetailModel, ProductHarvestOrder>();

            mc.CreateMap<ProductHarvestOrder, ProductHarvestOrderMapGroupOrderDataModel>();
            mc.CreateMap<ProductHarvestOrderMapGroupOrderDataModel, ProductHarvestOrder>();

            mc.CreateMap<ProductHarvestOrder, ProductHarvestOrderGroup>();
            mc.CreateMap<ProductHarvestOrderGroup, ProductHarvestOrder>();

            mc.CreateMap<ProductHarvestOrder, ProductHarvestOrderOfFarmCollectionModel>();
            mc.CreateMap<ProductHarvestOrderOfFarmCollectionModel, ProductHarvestOrder>();

            mc.CreateMap<ProductHarvestOrder, ProductHarvestOrderDataMapModel>();
            mc.CreateMap<ProductHarvestOrderDataMapModel, ProductHarvestOrder>();

            mc.CreateMap<ProductHarvestOrder, ProductHarvestOrderGroupFarmOrderModel>();
            mc.CreateMap<ProductHarvestOrderGroupFarmOrderModel, ProductHarvestOrder>();

        }
    }
}
