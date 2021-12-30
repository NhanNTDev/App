using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class Harvest
    {
        public Harvest()
        {
            HarvestCampaigns = new HashSet<HarvestCampaign>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime? StartAt { get; set; }
        public int? Status { get; set; }
        public int? FarmId { get; set; }
        public int? ProductId { get; set; }

        public virtual Farm Farm { get; set; }
        public virtual Product Product { get; set; }
        public virtual ICollection<HarvestCampaign> HarvestCampaigns { get; set; }
    }
}
