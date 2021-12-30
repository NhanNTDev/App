using Microsoft.AspNetCore.Mvc.ModelBinding;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.ViewModels
{
    public class HarvestCampaignModel
    {
        public static string[] Fields = {
            "Id", "Unit", "Inventory", "Price", "Status", "HarvestId", "CampaignApplyId", "Harvest", "CampaignApply"
        };
        public int? Id { get; set; }
        [BindNever]
        public string Unit { get; set; }
        [BindNever]
        public int? Inventory { get; set; }
        public double? Price { get; set; }
        [BindNever]
        public int? Status { get; set; }
        [BindNever]
        public int? HarvestId { get; set; }
        [BindNever]
        public int? CampaignApplyId { get; set; }
        public virtual CampaignApplyModelMappingHarvestCampaign CampaignApply { get; set; }
        [BindNever]
        public virtual HarvestModelMappingHarvestCampaign Harvest { get; set; }
    }
}
