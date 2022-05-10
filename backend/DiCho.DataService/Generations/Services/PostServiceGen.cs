namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IPostService:IBaseService<Post>
    {
    }
    public partial class PostService:BaseService<Post>,IPostService
    {
        public PostService(IUnitOfWork unitOfWork,IPostRepository repository):base(unitOfWork,repository){}
    }
}
