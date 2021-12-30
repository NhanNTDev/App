
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IAspNetUserRepository :IBaseRepository<AspNetUsers>
    {
    }
    public partial class AspNetUserRepository :BaseRepository<AspNetUsers>, IAspNetUserRepository
    {
         public AspNetUserRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

