﻿using AutoMapper;
using DiCho.DataService.Models;
using DiCho.DataService.ViewModels;

namespace DiCho.DataService.AutoMapperModule
{
    public static class WareHouseZoneModule
    {
        public static void ConfigWareHouseZoneModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<WareHouseZone, WareHouseZoneModel>();
            mc.CreateMap<WareHouseZoneModel, WareHouseZone>();

            mc.CreateMap<WareHouseZone, WareHouseZoneDataMapModel>();
            mc.CreateMap<WareHouseZoneDataMapModel, WareHouseZone>();

            mc.CreateMap<WareHouseZone, WareHouseZoneCreateModel>();
            mc.CreateMap<WareHouseZoneCreateModel, WareHouseZone>();

        }
    }
}
