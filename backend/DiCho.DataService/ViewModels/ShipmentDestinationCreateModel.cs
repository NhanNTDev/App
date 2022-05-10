using System.Collections.Generic;

namespace DiCho.DataService.ViewModels
{
    public class ShipmentDestinationCreateModel
    {
        public string Address { get; set; }
        public int ShipmentId { get; set; }
    }

    public class ShipmentDestinationViewModel
    {
        public int Id { get; set; }
        public string WarehouseTo { get; set; }
        public string Address { get; set; }
        public List<OrderModelForDriver> Orders { get; set; }
    }
}
