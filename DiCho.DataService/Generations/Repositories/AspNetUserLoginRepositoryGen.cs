
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IAspNetUserLoginRepository :IBaseRepository<AspNetUserLogins>
    {
    }
    public partial class AspNetUserLoginRepository :BaseRepository<AspNetUserLogins>, IAspNetUserLoginRepository
    {
         public AspNetUserLoginRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

