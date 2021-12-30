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
    public static class ProductModule
    {
        public static void ConfigProductModule(this IMapperConfigurationExpression mc)
        {
            mc.CreateMap<Product, ProductModel>();
            mc.CreateMap<ProductModel, Product>();

            mc.CreateMap<Product, ProductModelMappingHarvest>();
            mc.CreateMap<ProductModelMappingHarvest, Product>();

        }
    }
}
