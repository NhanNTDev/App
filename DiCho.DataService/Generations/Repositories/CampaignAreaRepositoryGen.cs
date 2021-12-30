
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface ICampaignAreaRepository :IBaseRepository<CampaignArea>
    {
    }
    public partial class CampaignAreaRepository :BaseRepository<CampaignArea>, ICampaignAreaRepository
    {
         public CampaignAreaRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

