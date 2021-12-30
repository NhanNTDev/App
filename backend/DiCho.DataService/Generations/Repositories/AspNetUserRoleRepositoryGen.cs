
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IAspNetUserRoleRepository :IBaseRepository<AspNetUserRoles>
    {
    }
    public partial class AspNetUserRoleRepository :BaseRepository<AspNetUserRoles>, IAspNetUserRoleRepository
    {
         public AspNetUserRoleRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

