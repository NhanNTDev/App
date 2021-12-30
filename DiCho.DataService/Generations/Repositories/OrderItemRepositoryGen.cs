
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IOrderItemRepository :IBaseRepository<OrderItem>
    {
    }
    public partial class OrderItemRepository :BaseRepository<OrderItem>, IOrderItemRepository
    {
         public OrderItemRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

