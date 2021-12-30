namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IFeedbackService:IBaseService<Feedback>
    {
    }
    public partial class FeedbackService:BaseService<Feedback>,IFeedbackService
    {
        public FeedbackService(IFeedbackRepository repository):base(repository){}
    }
}
