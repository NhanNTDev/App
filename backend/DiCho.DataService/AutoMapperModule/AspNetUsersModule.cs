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
    public static class AspNetUsersModule
    {
        public static void ConfigAspNetUsersModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<AspNetUsers, AspNetUsersModel>();
            mc.CreateMap<AspNetUsersModel, AspNetUsers>();
            
            mc.CreateMap<AspNetUsers, AspNetUsersUpdateModel>();
            mc.CreateMap<AspNetUsersUpdateModel, AspNetUsers>();

        }
    }
}
