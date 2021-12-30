namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IAspNetUserTokenService:IBaseService<AspNetUserTokens>
    {
    }
    public partial class AspNetUserTokenService:BaseService<AspNetUserTokens>,IAspNetUserTokenService
    {
        public AspNetUserTokenService(IAspNetUserTokenRepository repository):base(repository){}
    }
}
