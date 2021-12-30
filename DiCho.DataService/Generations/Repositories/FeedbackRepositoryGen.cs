
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IFeedbackRepository :IBaseRepository<Feedback>
    {
    }
    public partial class FeedbackRepository :BaseRepository<Feedback>, IFeedbackRepository
    {
         public FeedbackRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

