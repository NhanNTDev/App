namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IHarvestCampaignService:IBaseService<HarvestCampaign>
    {
    }
    public partial class HarvestCampaignService:BaseService<HarvestCampaign>,IHarvestCampaignService
    {
        public HarvestCampaignService(IHarvestCampaignRepository repository):base(repository){}
    }
}
