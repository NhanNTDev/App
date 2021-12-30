using DiCho.Core.Attributes;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.ViewModels
{
    public class ProductCategoryModel
    {
        public static string[] Fields = {
            "Id", "Name", "Image", "Description", "Status", "ProductInventory"
        };
        public int? Id { get; set; }
        [StringAttribute]
        public string Name { get; set; }
        [BindNever]
        public string Description { get; set; }
        [BindNever]
        public string Image { get; set; }
        public int? Status { get; set; }
        [BindNever]
        public int? ProductInventory { get; set; }
    }
}
