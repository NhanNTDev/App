using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class OrderItem
    {
        public int Id { get; set; }
        public int? Unit { get; set; }
        public int? Quantity { get; set; }
        public double? Price { get; set; }
        public double? Total { get; set; }
        public int? OrdersId { get; set; }
        public int? HarvestCampaignId { get; set; }

        public virtual HarvestCampaign HarvestCampaign { get; set; }
        public virtual Order Orders { get; set; }
    }
}
