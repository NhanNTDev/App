using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class Feedback
    {
        public int Id { get; set; }
        public string Content { get; set; }
        public int? Star { get; set; }
        public DateTime? CreateAt { get; set; }
        public int? OrdersId { get; set; }

        public virtual Order Orders { get; set; }
    }
}
