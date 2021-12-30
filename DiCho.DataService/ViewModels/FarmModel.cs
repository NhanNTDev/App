using DiCho.Core.Attributes;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.ViewModels
{
    public class FarmModel
    {
        public static string[] Fields = {
            "Id", "Name", "Image1", "Image2", "Image3", "Image4", "Image5", "Description", "Address", "Status", "AddAt", "FarmerId", "FarmAreaId"
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
        public string Address { get; set; }
        [BindNever]
        public int? Status { get; set; }
        [BindNever]
        public DateTime? AddAt { get; set; }
        public string FarmerId { get; set; }
        [BindNever]
        public int? FarmAreaId { get; set; }

    }
    public class FarmModelMappingCampaignApply
    {
        [BindNever]
        public int? Id { get; set; }
        [BindNever]
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
        public string Address { get; set; }
        [BindNever]
        public int? Status { get; set; }
        [BindNever]
        public DateTime? AddAt { get; set; }
        [BindNever]
        public string FarmerId { get; set; }
        [BindNever]
        public int? FarmAreaId { get; set; }

    }
}
