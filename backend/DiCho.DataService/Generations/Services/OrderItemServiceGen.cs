namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IOrderItemService:IBaseService<OrderItem>
    {
    }
    public partial class OrderItemService:BaseService<OrderItem>,IOrderItemService
    {
        public OrderItemService(IOrderItemRepository repository):base(repository){}
    }
}
