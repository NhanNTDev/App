
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IAspNetUserClaimRepository :IBaseRepository<AspNetUserClaims>
    {
    }
    public partial class AspNetUserClaimRepository :BaseRepository<AspNetUserClaims>, IAspNetUserClaimRepository
    {
         public AspNetUserClaimRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

