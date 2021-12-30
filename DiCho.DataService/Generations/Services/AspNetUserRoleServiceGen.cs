namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IAspNetUserRoleService:IBaseService<AspNetUserRoles>
    {
    }
    public partial class AspNetUserRoleService:BaseService<AspNetUserRoles>,IAspNetUserRoleService
    {
        public AspNetUserRoleService(IAspNetUserRoleRepository repository):base(repository){}
    }
}
