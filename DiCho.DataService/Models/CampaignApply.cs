using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class CampaignApply
    {
        public CampaignApply()
        {
            HarvestCampaigns = new HashSet<HarvestCampaign>();
        }

        public int Id { get; set; }
        public int? Status { get; set; }
        public int? FarmId { get; set; }
        public int? CampaignId { get; set; }

        public virtual Campaign Campaign { get; set; }
        public virtual Farm Farm { get; set; }
        public virtual ICollection<HarvestCampaign> HarvestCampaigns { get; set; }
    }
}
