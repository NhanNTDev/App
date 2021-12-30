namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IAspNetUserClaimService:IBaseService<AspNetUserClaims>
    {
    }
    public partial class AspNetUserClaimService:BaseService<AspNetUserClaims>,IAspNetUserClaimService
    {
        public AspNetUserClaimService(IAspNetUserClaimRepository repository):base(repository){}
    }
}
