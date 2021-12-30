using AutoMapper;
using AutoMapper.QueryableExtensions;
using DiCho.Core.Utilities;
using DiCho.DataService.Commons;
using DiCho.DataService.Repositories;
using DiCho.DataService.Response;
using DiCho.DataService.ViewModels;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.Services
{
    public partial interface IProductCategoryService
    {
        Task<List<ProductCategoryModel>> Gets(ProductCategoryModel model);
    }
    public partial class ProductCategoryService
    {
        private readonly IConfigurationProvider _mapper;
        private readonly IProductService _productService;
        public ProductCategoryService(IProductCategoryRepository repository,
            IProductService productService,
            IMapper mapper = null) : base(repository)
        {
            _mapper = mapper.ConfigurationProvider;
            _productService = productService;
        }
        public async Task<List<ProductCategoryModel>> Gets(ProductCategoryModel model)
        {
            var result = Get().ProjectTo<ProductCategoryModel>(_mapper)
                .DynamicFilter(model)
                .Select<ProductCategoryModel>(ProductCategoryModel.Fields.ToArray().ToDynamicSelector<ProductCategoryModel>());
            var rs2 = new List<ProductCategoryModel>();
            foreach (var category in result)
            {
                var productInventory = await _productService.Get(x => x.ProductCategoryId == category.Id).CountAsync();
                category.ProductInventory = productInventory;
                rs2.Add(category);
            }
            return rs2;
        }
    }
}
