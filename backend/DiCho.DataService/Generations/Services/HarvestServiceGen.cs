namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IHarvestService:IBaseService<Harvest>
    {
    }
    public partial class HarvestService:BaseService<Harvest>,IHarvestService
    {
        public HarvestService(IHarvestRepository repository):base(repository){}
    }
}
