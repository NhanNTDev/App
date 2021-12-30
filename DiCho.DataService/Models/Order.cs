using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class Order
    {
        public Order()
        {
            Feedbacks = new HashSet<Feedback>();
            OrderItems = new HashSet<OrderItem>();
        }

        public int Id { get; set; }
        public double? Total { get; set; }
        public int? Status { get; set; }
        public DateTime? CreateAt { get; set; }
        public int? FarmId { get; set; }
        public int? ClusteringOrderId { get; set; }

        public virtual ClusteringOrder ClusteringOrder { get; set; }
        public virtual Farm Farm { get; set; }
        public virtual ICollection<Feedback> Feedbacks { get; set; }
        public virtual ICollection<OrderItem> OrderItems { get; set; }
    }
}
