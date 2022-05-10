using AutoMapper;
using DiCho.DataService.Models;
using DiCho.DataService.ViewModels;

namespace DiCho.DataService.AutoMapperModule
{
    public static class ProductSalesCampaignModule
    {
        public static void ConfigProductSalesCampaignModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<ProductSalesCampaign, ProductSalesCampaignModel>();
            mc.CreateMap<ProductSalesCampaignModel, ProductSalesCampaign>();

            mc.CreateMap<ProductSalesCampaign, ProductSalesCampaignCreateModel>();
            mc.CreateMap<ProductSalesCampaignCreateModel, ProductSalesCampaign>();

            mc.CreateMap<ProductSalesCampaign, ProductSalesCampaignUpdateModel>();
            mc.CreateMap<ProductSalesCampaignUpdateModel, ProductSalesCampaign>();

            mc.CreateMap<ProductSalesCampaign, ProductSalesCampaignViewModel>();
            mc.CreateMap<ProductSalesCampaignViewModel, ProductSalesCampaign>();

            mc.CreateMap<ProductSalesCampaign, ProductSalesCampaignDetailModel>();
            mc.CreateMap<ProductSalesCampaignDetailModel, ProductSalesCampaign>();

        }
    }
}
