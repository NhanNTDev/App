using Microsoft.AspNetCore.Mvc.ModelBinding;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DiCho.DataService.ViewModels
{
    public class ProductModel
    {
    }
    public class ProductModelMappingHarvest
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
        public int? Status { get; set; }
        [BindNever]
        public int? FarmId { get; set; }
        [BindNever]
        public int? ProductCategoryId { get; set; }
    }
}
