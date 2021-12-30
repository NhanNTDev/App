using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class Campaign
    {
        public Campaign()
        {
            CampaignApplies = new HashSet<CampaignApply>();
            CampaignDeliveryZones = new HashSet<CampaignDeliveryZone>();
            ClusteringOrders = new HashSet<ClusteringOrder>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public DateTime? StartAtt { get; set; }
        public DateTime? EndAtt { get; set; }
        public DateTime? StartRecruitmentAt { get; set; }
        public DateTime? EndRecruitmentAt { get; set; }
        public int? Slot { get; set; }
        public bool? Weekly { get; set; }
        public bool? Event { get; set; }
        public int? Status { get; set; }

        public virtual ICollection<CampaignApply> CampaignApplies { get; set; }
        public virtual ICollection<CampaignDeliveryZone> CampaignDeliveryZones { get; set; }
        public virtual ICollection<ClusteringOrder> ClusteringOrders { get; set; }
    }
}
