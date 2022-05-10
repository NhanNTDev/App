using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace DiCho.DataService.ViewModels
{
    public class WareHouseZoneModel
    {
        [BindNever]
        public int Id { get; set; }
        [BindNever]
        public int ZoneId { get; set; }
        [BindNever]
        public string WareHouseZoneName { get; set; }
    }

    public class WareHouseZoneCreateModel
    {
        public int ZoneId { get; set; }
    }

    public class WareHouseZoneDataMapModel
    {
        public int Id { get; set; }
        public int ZoneId { get; set; }
        public string WareHouseZoneName { get; set; }
        public int? WareHouseId { get; set; }
    }
}
