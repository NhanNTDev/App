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
    public static class ProductCategoryModule
    {
        public static void ConfigProductCategoryModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<ProductCategory, ProductCategoryModel>();
            mc.CreateMap<ProductCategoryModel, ProductCategory>();

        }
    }
}
