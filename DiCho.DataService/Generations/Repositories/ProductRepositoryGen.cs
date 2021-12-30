
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IProductRepository :IBaseRepository<Product>
    {
    }
    public partial class ProductRepository :BaseRepository<Product>, IProductRepository
    {
         public ProductRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

