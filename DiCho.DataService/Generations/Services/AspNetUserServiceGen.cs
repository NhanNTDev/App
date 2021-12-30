namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IAspNetUserService:IBaseService<AspNetUsers>
    {
    }
    public partial class AspNetUserService:BaseService<AspNetUsers>,IAspNetUserService
    {
        public AspNetUserService(IAspNetUserRepository repository):base(repository){}
    }
}
