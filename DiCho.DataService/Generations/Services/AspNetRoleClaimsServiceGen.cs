namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IAspNetRoleClaimsService:IBaseService<AspNetRoleClaims>
    {
    }
    public partial class AspNetRoleClaimsService:BaseService<AspNetRoleClaims>,IAspNetRoleClaimsService
    {
        public AspNetRoleClaimsService(IAspNetRoleClaimsRepository repository):base(repository){}
    }
}
