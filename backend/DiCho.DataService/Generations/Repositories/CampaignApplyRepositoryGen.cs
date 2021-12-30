
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface ICampaignApplyRepository :IBaseRepository<CampaignApply>
    {
    }
    public partial class CampaignApplyRepository :BaseRepository<CampaignApply>, ICampaignApplyRepository
    {
         public CampaignApplyRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

