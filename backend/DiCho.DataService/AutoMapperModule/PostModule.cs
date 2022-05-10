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
    public static class PostModule
    {
        public static void ConfigPostModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<Post, PostModel>();
            mc.CreateMap<PostModel, Post>();

            mc.CreateMap<Post, PostCreateModel>();
            mc.CreateMap<PostCreateModel, Post>()
                .ForMember(des => des.CreateAt, opt => opt.MapFrom(src => DateTime.Now));

        }
    }
}
