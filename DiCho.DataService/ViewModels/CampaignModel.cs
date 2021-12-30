using DiCho.Core.Attributes;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.ViewModels
{
    public class CampaignModel
    {
        public static string[] Fields = {
            "Id", "Name", "Image1", "Image2", "Image3", "Image4", "Image5", "Description", "StartAtt", "EndAtt", 
            "Slot", "Weekly", "Status", "CountFarmApply"
        };
        public int? Id { get; set; }
        [StringAttribute]
        public string Name { get; set; }
        [BindNever]
        public string Image1 { get; set; }
        [BindNever]
        public string Image2 { get; set; }
        [BindNever]
        public string Image3 { get; set; }
        [BindNever]
        public string Image4 { get; set; }
        [BindNever]
        public string Image5 { get; set; }
        [BindNever]
        public string Description { get; set; }
        [BindNever]
        public DateTime? StartAtt { get; set; }
        [BindNever]
        public DateTime? EndAtt { get; set; }
        [BindNever]
        public int? Slot { get; set; }
        [BindNever]
        public bool? Weekly { get; set; }
        [BindNever]
        public bool? Event { get; set; }
        [BindNever]
        public int? CountFarmApply { get; set; }
        [BindNever]
        public int? Status { get; set; }
    }
}
