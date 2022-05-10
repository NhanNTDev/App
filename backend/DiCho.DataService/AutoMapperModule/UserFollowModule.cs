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
    public static class UserFollowModule
    {
        public static void ConfigUserFollowModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<UserFollow, UserFollowModel>();
            mc.CreateMap<UserFollowModel, UserFollow>();
            
            mc.CreateMap<UserFollow, UserFollowCreateModel>();
            mc.CreateMap<UserFollowCreateModel, UserFollow>();

        }
    }
}
