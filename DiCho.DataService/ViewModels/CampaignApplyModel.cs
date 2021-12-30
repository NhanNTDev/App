using Microsoft.AspNetCore.Mvc.ModelBinding;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.ViewModels
{
    public class CampaignApplyModel
    {
        public static string[] Fields = {
            "Id", "Status", "FarmId", "CampaignId", "Farm"
        };
        public int? Id { get; set; }
        public int? Status { get; set; }
        public int? FarmId { get; set; }
        public int? CampaignId { get; set; }
        public virtual FarmModelMappingCampaignApply Farm { get; set; }  
    }
    public class CampaignApplyModelMappingHarvestCampaign
    {
        [BindNever]
        public int? FarmId { get; set; }
        [BindNever]
        public int? CampaignId { get; set; }
    }
}
