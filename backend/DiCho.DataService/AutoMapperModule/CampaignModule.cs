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
    public static class CampaignModule
    {
        public static void ConfigCampaignModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<Campaign, CampaignModel>();
            mc.CreateMap<CampaignModel, Campaign>();

        }
    }
}
