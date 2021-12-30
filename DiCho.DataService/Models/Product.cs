using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class Product
    {
        public Product()
        {
            Harvests = new HashSet<Harvest>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public int? Status { get; set; }
        public int? FarmId { get; set; }
        public int? ProductCategoryId { get; set; }

        public virtual Farm Farm { get; set; }
        public virtual ProductCategory ProductCategory { get; set; }
        public virtual ICollection<Harvest> Harvests { get; set; }
    }
}
