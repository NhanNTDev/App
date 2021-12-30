
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IClusteringOrderRepository :IBaseRepository<ClusteringOrder>
    {
    }
    public partial class ClusteringOrderRepository :BaseRepository<ClusteringOrder>, IClusteringOrderRepository
    {
         public ClusteringOrderRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

