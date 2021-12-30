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
    public static class FarmModule
    {
        public static void ConfigFarmModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<Farm, FarmModel>();
            mc.CreateMap<FarmModel, Farm>();

            mc.CreateMap<Farm, FarmModelMappingCampaignApply>();
            mc.CreateMap<FarmModelMappingCampaignApply, Farm>();

        }
    }
}
