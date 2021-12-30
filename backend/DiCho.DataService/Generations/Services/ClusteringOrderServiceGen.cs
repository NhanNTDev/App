namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IClusteringOrderService:IBaseService<ClusteringOrder>
    {
    }
    public partial class ClusteringOrderService:BaseService<ClusteringOrder>,IClusteringOrderService
    {
        public ClusteringOrderService(IClusteringOrderRepository repository):base(repository){}
    }
}
