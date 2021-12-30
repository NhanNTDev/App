namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface ICampaignAreaService:IBaseService<CampaignArea>
    {
    }
    public partial class CampaignAreaService:BaseService<CampaignArea>,ICampaignAreaService
    {
        public CampaignAreaService(ICampaignAreaRepository repository):base(repository){}
    }
}
