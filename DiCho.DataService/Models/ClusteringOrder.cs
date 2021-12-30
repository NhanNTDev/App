using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class ClusteringOrder
    {
        public ClusteringOrder()
        {
            Orders = new HashSet<Order>();
        }

        public int Id { get; set; }
        public int? Total { get; set; }
        public int? Status { get; set; }
        public DateTime? CreateAt { get; set; }
        public int? PaymentId { get; set; }
        public int? CampaignId { get; set; }
        public int? AddressId { get; set; }

        public virtual Address Address { get; set; }
        public virtual Campaign Campaign { get; set; }
        public virtual Payment Payment { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
    }
}
