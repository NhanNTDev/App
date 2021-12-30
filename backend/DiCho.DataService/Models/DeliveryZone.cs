using System;
using System.Collections.Generic;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class DeliveryZone
    {
        public DeliveryZone()
        {
            Addresses = new HashSet<Address>();
            CampaignDeliveryZones = new HashSet<CampaignDeliveryZone>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Address> Addresses { get; set; }
        public virtual ICollection<CampaignDeliveryZone> CampaignDeliveryZones { get; set; }
    }
}
