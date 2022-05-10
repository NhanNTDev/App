using DiCho.Core.Attributes;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using System.Collections.Generic;

namespace DiCho.DataService.ViewModels
{
    public class WareHouseModel
    {
        public static string[] Fields = {
            "Id", "Name", "Address", "WarehouseManagerId", "WarehouseManagerName", "WareHouseZones"
        };
        [BindNever]
        public int? Id { get; set; }
        [StringAttribute]
        public string Name { get; set; }
        [BindNever]
        public string Address { get; set; }
        [BindNever]
        public string WarehouseManagerId { get; set; }
        [BindNever]
        public string WarehouseManagerName { get; set; }
        [BindNever]
        public virtual ICollection<WareHouseZoneModel> WareHouseZones { get; set; }
    }

    public class WareHouseDataMapModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public bool? Active { get; set; }
        public string WarehouseManagerId { get; set; }

        public virtual ICollection<WareHouseZoneDataMapModel> WareHouseZones { get; set; }
    }

    public class WareHouseCreateModel
    {
        public string Name { get; set; }
        public string Address { get; set; }

        public virtual ICollection<WareHouseZoneCreateModel> WareHouseZones { get; set; }
    }

    public class WareHouseUpdateModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string WarehouseManagerId { get; set; }
        public virtual ICollection<WareHouseZoneCreateModel> WareHouseZones { get; set; }
    }
}
