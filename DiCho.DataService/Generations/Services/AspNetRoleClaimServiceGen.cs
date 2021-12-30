namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IAspNetRoleClaimService:IBaseService<AspNetRoleClaims>
    {
    }
    public partial class AspNetRoleClaimService:BaseService<AspNetRoleClaims>,IAspNetRoleClaimService
    {
        public AspNetRoleClaimService(IAspNetRoleClaimRepository repository):base(repository){}
    }
}
