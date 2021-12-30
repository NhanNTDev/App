
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IAspNetRoleClaimRepository :IBaseRepository<AspNetRoleClaims>
    {
    }
    public partial class AspNetRoleClaimRepository :BaseRepository<AspNetRoleClaims>, IAspNetRoleClaimRepository
    {
         public AspNetRoleClaimRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

