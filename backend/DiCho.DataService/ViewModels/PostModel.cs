using DiCho.Core.Attributes;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.ViewModels
{
    public class PostModel
    {
        public static string[] Fields = {
            "Id", "Title", "CampaignId", "CampaignName", "FarmId", "FarmName", "ProductHarvestInCampaignId", "ProductName", "ProductImage", "CreateAt", "CustomerId"
        };
        [BindNever]
        public int? Id { get; set; }
        [BindNever]
        public string Title { get; set; }
        [BindNever]
        public int? CampaignId { get; set; }
        [BindNever]
        public string CampaignName { get; set; }
        [BindNever]
        public string CampaignStatus { get; set; }
        [BindNever]
        public int? FarmId { get; set; }
        [BindNever]
        public string FarmName { get; set; }
        [BindNever]
        public int? ProductHarvestInCampaignId { get; set; }
        [StringAttribute]
        public string ProductName { get; set; }
        [BindNever]
        public string ProductImage { get; set; }
        [BindNever]
        public DateTime? CreateAt { get; set; }
        [BindNever]
        public string CustomerId { get; set; }
        [BindNever]
        public string CustomerName { get; set; }
    }

    public class PostCreateModel
    {
        public string Title { get; set; }
        public int? CampaignId { get; set; }
        public string CampaignName { get; set; }
        public int? FarmId { get; set; }
        public string FarmName { get; set; }
        public int? ProductHarvestInCampaignId { get; set; }
        public string ProductName { get; set; }
        public string ProductImage { get; set; }
        public string CustomerId { get; set; }
    }
}
