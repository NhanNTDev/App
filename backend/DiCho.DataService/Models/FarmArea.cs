using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class FarmArea
    {
        public FarmArea()
        {
            Farms = new HashSet<Farm>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Farm> Farms { get; set; }
    }
}
