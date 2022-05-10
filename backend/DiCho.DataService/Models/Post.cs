using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class Post
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public int? CampaignId { get; set; }
        public string CampaignName { get; set; }
        public int? FarmId { get; set; }
        public string FarmName { get; set; }
        public int? ProductHarvestInCampaignId { get; set; }
        public string ProductName { get; set; }
        public string ProductImage { get; set; }
        public DateTime? CreateAt { get; set; }
        public string CustomerId { get; set; }

        public virtual AspNetUsers Customer { get; set; }
    }
}
