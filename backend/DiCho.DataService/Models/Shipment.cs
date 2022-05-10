using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class Shipment
    {
        public Shipment()
        {
            Orders = new HashSet<Order>();
            ShipmentDestinations = new HashSet<ShipmentDestination>();
        }

        public int Id { get; set; }
        public string Code { get; set; }
        public string From { get; set; }
        public int? Status { get; set; }
        public double? TotalWeight { get; set; }
        public DateTime? CreateAt { get; set; }
        public string DriverId { get; set; }
        public int? WarehouseId { get; set; }

        public virtual AspNetUsers Driver { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<ShipmentDestination> ShipmentDestinations { get; set; }
    }
}
