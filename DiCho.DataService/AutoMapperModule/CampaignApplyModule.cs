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
    public static class CampaignApplyModule
    {
        public static void ConfigCampaignApplyModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<CampaignApply, CampaignApplyModel>();
            mc.CreateMap<CampaignApplyModel, CampaignApply>();

            mc.CreateMap<CampaignApply, CampaignApplyModelMappingHarvestCampaign>();
            mc.CreateMap<CampaignApplyModelMappingHarvestCampaign, CampaignApply>();

        }
    }
}
