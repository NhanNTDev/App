
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IFarmAreaRepository :IBaseRepository<FarmArea>
    {
    }
    public partial class FarmAreaRepository :BaseRepository<FarmArea>, IFarmAreaRepository
    {
         public FarmAreaRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

