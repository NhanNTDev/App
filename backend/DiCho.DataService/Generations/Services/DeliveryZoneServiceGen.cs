namespace DiCho.DataService.Services
{
    using DiCho.Core.BaseConnect;
    using DiCho.DataService.Models;
    using DiCho.DataService.Repositories;
    public partial interface IDeliveryZoneService:IBaseService<DeliveryZone>
    {
    }
    public partial class DeliveryZoneService:BaseService<DeliveryZone>,IDeliveryZoneService
    {
        public DeliveryZoneService(IDeliveryZoneRepository repository):base(repository){}
    }
}
