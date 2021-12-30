using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class Address
    {
        public Address()
        {
            ClusteringOrders = new HashSet<ClusteringOrder>();
        }

        public int Id { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Country { get; set; }
        public string City { get; set; }
        public string District { get; set; }
        public string Description { get; set; }
        public string CustomerId { get; set; }
        public int? DeliveryZoneId { get; set; }

        public virtual AspNetUsers Customer { get; set; }
        public virtual DeliveryZone DeliveryZone { get; set; }
        public virtual ICollection<ClusteringOrder> ClusteringOrders { get; set; }
    }
}
