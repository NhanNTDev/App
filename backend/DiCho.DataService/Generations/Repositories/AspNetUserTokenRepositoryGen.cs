
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IAspNetUserTokenRepository :IBaseRepository<AspNetUserTokens>
    {
    }
    public partial class AspNetUserTokenRepository :BaseRepository<AspNetUserTokens>, IAspNetUserTokenRepository
    {
         public AspNetUserTokenRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

