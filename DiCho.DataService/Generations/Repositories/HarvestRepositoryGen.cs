
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IHarvestRepository :IBaseRepository<Harvest>
    {
    }
    public partial class HarvestRepository :BaseRepository<Harvest>, IHarvestRepository
    {
         public HarvestRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

