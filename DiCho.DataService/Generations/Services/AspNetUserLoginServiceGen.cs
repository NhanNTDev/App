namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IAspNetUserLoginService:IBaseService<AspNetUserLogins>
    {
    }
    public partial class AspNetUserLoginService:BaseService<AspNetUserLogins>,IAspNetUserLoginService
    {
        public AspNetUserLoginService(IAspNetUserLoginRepository repository):base(repository){}
    }
}
