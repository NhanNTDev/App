using Microsoft.AspNetCore.Mvc.ModelBinding;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.ViewModels
{
    public class HarvestModel
    {
    }

    public class HarvestModelMappingHarvestCampaign
    {
        [BindNever]
        public int? Id { get; set; }
        [BindNever]
        public string Name { get; set; }
        [BindNever]
        public string Description { get; set; }
        [BindNever]
        public DateTime? StartAt { get; set; }
        [BindNever]
        public int? Status { get; set; }
        [BindNever]
        public int? FarmId { get; set; }
        [BindNever]
        public int? ProductId { get; set; }
        public virtual ProductModelMappingHarvest Product { get; set; }
    }
}
