
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IHarvestCampaignRepository :IBaseRepository<HarvestCampaign>
    {
    }
    public partial class HarvestCampaignRepository :BaseRepository<HarvestCampaign>, IHarvestCampaignRepository
    {
         public HarvestCampaignRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

