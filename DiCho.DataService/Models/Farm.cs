using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class Farm
    {
        public Farm()
        {
            CampaignApplies = new HashSet<CampaignApply>();
            Harvests = new HashSet<Harvest>();
            Orders = new HashSet<Order>();
            Products = new HashSet<Product>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public string Address { get; set; }
        public int? Status { get; set; }
        public DateTime? AddAt { get; set; }
        public string FarmerId { get; set; }
        public int? FarmAreaId { get; set; }

        public virtual FarmArea FarmArea { get; set; }
        public virtual AspNetUsers Farmer { get; set; }
        public virtual ICollection<CampaignApply> CampaignApplies { get; set; }
        public virtual ICollection<Harvest> Harvests { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<Product> Products { get; set; }
    }
}
