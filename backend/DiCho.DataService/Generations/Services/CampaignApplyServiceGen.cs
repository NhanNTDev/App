namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface ICampaignApplyService:IBaseService<CampaignApply>
    {
    }
    public partial class CampaignApplyService:BaseService<CampaignApply>,ICampaignApplyService
    {
        public CampaignApplyService(ICampaignApplyRepository repository):base(repository){}
    }
}
