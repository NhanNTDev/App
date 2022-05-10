
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IUserFollowRepository :IBaseRepository<UserFollow>
    {
    }
    public partial class UserFollowRepository :BaseRepository<UserFollow>, IUserFollowRepository
    {
         public UserFollowRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

