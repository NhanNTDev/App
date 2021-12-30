
using Microsoft.EntityFrameworkCore;
using DiCho.Core.BaseConnect;
using DiCho.DataService.Models;
namespace DiCho.DataService.Repositories
{
    public partial interface IDeliveryZoneRepository :IBaseRepository<DeliveryZone>
    {
    }
    public partial class DeliveryZoneRepository :BaseRepository<DeliveryZone>, IDeliveryZoneRepository
    {
         public DeliveryZoneRepository(DbContext dbContext) : base(dbContext)
         {
         }
    }
}

