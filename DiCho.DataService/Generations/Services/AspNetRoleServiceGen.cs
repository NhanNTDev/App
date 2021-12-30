namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IAspNetRoleService:IBaseService<AspNetRoles>
    {
    }
    public partial class AspNetRoleService:BaseService<AspNetRoles>,IAspNetRoleService
    {
        public AspNetRoleService(IAspNetRoleRepository repository):base(repository){}
    }
}
