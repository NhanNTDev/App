
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IAspNetRoleRepository :IBaseRepository<AspNetRoles>
    {
    }
    public partial class AspNetRoleRepository :BaseRepository<AspNetRoles>, IAspNetRoleRepository
    {
         public AspNetRoleRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

