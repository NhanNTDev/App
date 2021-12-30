using AutoMapper;
using DiCho.DataService.Repositories;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.Services
{
    public partial interface IProductService
    {
        Task<int> GetCountProductbyCategoryId(int categoryId);
    }
    public partial class ProductService
    {
        private readonly IConfigurationProvider _mapper;
        public ProductService(IProductRepository repository, IMapper mapper = null) : base(repository)
        {
            _mapper = mapper.ConfigurationProvider;
        }
        public async Task<int> GetCountProductbyCategoryId(int categoryId)
        {
            var countProduct = await Get(x => x.ProductCategoryId == categoryId).CountAsync();
            return countProduct;
        }
    }
}
