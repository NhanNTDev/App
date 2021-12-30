using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class HarvestCampaign
    {
        public HarvestCampaign()
        {
            OrderItems = new HashSet<OrderItem>();
        }

        public int Id { get; set; }
        public string Unit { get; set; }
        public int? Inventory { get; set; }
        public double? Price { get; set; }
        public int? Status { get; set; }
        public int? HarvestId { get; set; }
        public int? CampaignApplyId { get; set; }

        public virtual CampaignApply CampaignApply { get; set; }
        public virtual Harvest Harvest { get; set; }
        public virtual ICollection<OrderItem> OrderItems { get; set; }
    }
}
