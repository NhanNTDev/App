using AutoMapper;
using DiCho.DataService.AutoMapperModule;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

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
                mc.ConfigCampaignApplyModule();
                mc.ConfigHarvestCampaignModule();
                mc.ConfigHarvestModule();
                mc.ConfigProductModule();
            });
            IMapper mapper = mappingConfig.CreateMapper();
            services.AddSingleton(mapper);
        }
    }
}
