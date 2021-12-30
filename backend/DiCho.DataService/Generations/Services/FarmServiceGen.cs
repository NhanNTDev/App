namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IFarmService:IBaseService<Farm>
    {
    }
    public partial class FarmService:BaseService<Farm>,IFarmService
    {
        public FarmService(IFarmRepository repository):base(repository){}
    }
}
