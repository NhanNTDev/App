namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IFarmAreaService:IBaseService<FarmArea>
    {
    }
    public partial class FarmAreaService:BaseService<FarmArea>,IFarmAreaService
    {
        public FarmAreaService(IFarmAreaRepository repository):base(repository){}
    }
}
