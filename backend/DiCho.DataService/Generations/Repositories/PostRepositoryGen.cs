
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IPostRepository :IBaseRepository<Post>
    {
    }
    public partial class PostRepository :BaseRepository<Post>, IPostRepository
    {
         public PostRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

