namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IProductService:IBaseService<Product>
    {
    }
    public partial class ProductService:BaseService<Product>,IProductService
    {
        public ProductService(IProductRepository repository):base(repository){}
    }
}
