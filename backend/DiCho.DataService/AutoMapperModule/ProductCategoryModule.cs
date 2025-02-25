﻿using AutoMapper;
using DiCho.DataService.Models;
using DiCho.DataService.ViewModels;

namespace DiCho.DataService.AutoMapperModule
{
    public static class ProductCategoryModule
    {
        public static void ConfigProductCategoryModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<ProductCategory, ProductCategoryModel>();
            mc.CreateMap<ProductCategoryModel, ProductCategory>();

            mc.CreateMap<ProductCategory, ProductCategoryCreateModel>();
            mc.CreateMap<ProductCategoryCreateModel, ProductCategory>()
                .ForMember(des => des.Active, opt => opt.MapFrom(src => true));

            mc.CreateMap<ProductCategory, ProductCategoryUpdateModel>();
            mc.CreateMap<ProductCategoryUpdateModel, ProductCategory>();

            mc.CreateMap<ProductCategory, ProductCategoryMappingModel>();
            mc.CreateMap<ProductCategoryMappingModel, ProductCategory>();

        }
    }
}
