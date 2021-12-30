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
    public static class HarvestCampaignModule
    {
        public static void ConfigHarvestCampaignModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<HarvestCampaign, HarvestCampaignModel>();
            mc.CreateMap<HarvestCampaignModel, HarvestCampaign>();

        }
    }
}
