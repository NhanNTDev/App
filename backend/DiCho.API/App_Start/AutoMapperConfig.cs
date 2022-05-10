using AutoMapper;
using DiCho.DataService.AutoMapperModule;
using Microsoft.Extensions.DependencyInjection;

namespace DiCho.API.App_Start
{
    public static class AutoMapperConfig
    {
        public static void ConfigureAutoMapper(this IServiceCollection services)
        {
            var mappingConfig = new MapperConfiguration(mc =>
            {
                mc.ConfigAspNetRolesModule();
                mc.ConfigAspNetUsersModule();
                mc.ConfigFarmModule();
                mc.ConfigProductCategoryModule();
                mc.ConfigCampaignModule();
                mc.ConfigProductHarvestInCampaignModule();
                mc.ConfigProductHarvestModule();
                mc.ConfigOrderModule();
                mc.ConfigFarmOrderModule();
                mc.ConfigHarvestOrderModule();
                mc.ConfigProductSystemModule();
                mc.ConfigPaymentModule();
                mc.ConfigAddressModule();
                mc.ConfigCampaignDeliveryZoneModule();
                mc.ConfigPaymentTypeModule();
                mc.ConfigWareHouseModule();
                mc.ConfigWareHouseZoneModule();
                mc.ConfigShipmentModule();
                mc.ConfigProductSalesCampaignModule();
                mc.ConfigUserFollowModule();
                mc.ConfigPostModule();
            });
            IMapper mapper = mappingConfig.CreateMapper();
            services.AddSingleton(mapper);
        }
    }
}
