using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class Payment
    {
        public Payment()
        {
            ClusteringOrders = new HashSet<ClusteringOrder>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public int? Status { get; set; }

        public virtual ICollection<ClusteringOrder> ClusteringOrders { get; set; }
    }
}
