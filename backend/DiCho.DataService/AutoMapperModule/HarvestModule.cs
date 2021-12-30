using AutoMapper;
using DiCho.DataService.Models;
using DiCho.DataService.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.AutoMapperModule
{
    public static class HarvestModule
    {
        public static void ConfigHarvestModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<Harvest, HarvestModel>();
            mc.CreateMap<HarvestModel, Harvest>();
            
            mc.CreateMap<Harvest, HarvestModelMappingHarvestCampaign>();
            mc.CreateMap<HarvestModelMappingHarvestCampaign, Harvest>();

        }
    }
}
