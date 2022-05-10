namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IUserFollowService:IBaseService<UserFollow>
    {
    }
    public partial class UserFollowService:BaseService<UserFollow>,IUserFollowService
    {
        public UserFollowService(IUnitOfWork unitOfWork,IUserFollowRepository repository):base(unitOfWork,repository){}
    }
}
