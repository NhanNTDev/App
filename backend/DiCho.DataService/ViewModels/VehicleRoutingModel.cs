using System.Collections.Generic;

namespace DiCho.DataService.ViewModels
{
    public class VehicleRoutingModel
    {
        public long[,] DistanceMatrix { get; set; }
        public int VehicleNumber { get; set; }
        public int Depot { get; set; }
    }
    public class VehicleRoutingViewModel
    {
        public string TotalDistance { get; set; }
        public double TotalWeight { get; set; }
        public List<RouteOfVihicle> RouteOfVihicles { get; set; }
    }

    public class RouteOfVihicle
    {
        public int Vihicle { get; set; }
        public double TotalWeightOfVihicle { get; set; }
        public Routes Routes { get; set; }
    }

    public class Routes
    {
        public Dictionary<string, double> Point { get; set; }
        public string Distance { get; set; }
    }
    public class VehicleRoutingViewModelObject
    {
        public string TotalDistance { get; set; }
        public double TotalWeight { get; set; }
        public List<RouteOfVihicleObject> RouteOfVihicles { get; set; }
    }

    public class RouteOfVihicleObject
    {
        public int Vihicle { get; set; }
        public double TotalWeightOfVihicle { get; set; }
        public RoutesObject Routes { get; set; }
    }

    public class RoutesObject
    {
        public Dictionary<string, List<OrderForDriverModel>> Point { get; set; }
        public string Distance { get; set; }
    }

    public class WarehouseDataRouting
    {
        public List<string> WarehouseAddresses { get; set; }
    }

    public class FarmDataRouting
    {
        public Dictionary<string, double> FarmRouting { get; set; }
    }

    public class DeliveryDataRouting
    {
        public Dictionary<string, double> DeliveryRouting { get; set; }
    }

    public class DistanceMatrixLong
    {
        public List<long> DistanceMatrix { get; set; }
    }

    public class VehicleRoutingAddressModel
    {
        public string Api_key = "AIzaSyDpCHIvLJ7SFW8wXTjShluXxRWfEkmGECA";
        public string[] Address =
        {
            "Tà Lài, TT. Tân Phú, Tân Phú, Đồng Nai, Việt Nam",
            "314 Đ. Lê Thị Riêng, Tân Thới An, Quận 12, Thành phố Hồ Chí Minh, Việt Nam",
            //"2/2 Đường 106, Phường Tăng Nhơn Phú A, Quận 9, Thành Phố Hồ Chí Minh",
            //"600 Nguyễn Lương Bằng, Phú Mỹ, Quận 7, Thành phố Hồ Chí Minh, Việt Nam",
            //"186 Đội Cung, Phường 8, Quận 11, Thành phố Hồ Chí Minh, Việt Nam"
        };
    }

    public class VehicleRoutingViewModel1
    {
        public string TotalDistance { get; set; }
        public List<RouteOfVihicle1> RouteOfVihicles { get; set; }
    }

    public class RouteOfVihicle1
    {
        public int Vihicle { get; set; }
        public Routes1 Routes { get; set; }
    }

    public class Routes1
    {
        public List<string> Point { get; set; }
        public string Distance { get; set; }
    }


    public class DistanceMatrixModel
    {
        public string[] Destination_addresses { get; set; }
        public string[] Origin_addresses { get; set; }
        public Row[] Rows { get; set; }
        public string Status { get; set; }
    }

    public class Row
    {
        public Element[] Elements { get; set; }
    }

    public class Element
    {
        public Distance Distance { get; set; }
        public Duration Duration { get; set; }
        public string Status { get; set; }
    }

    public class Distance
    {
        public string Text { get; set; }
        public int Value { get; set; }
    }

    public class Duration
    {
        public string Text { get; set; }
        public int Value { get; set; }
    }

}
