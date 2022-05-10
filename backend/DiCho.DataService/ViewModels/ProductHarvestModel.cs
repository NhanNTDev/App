using DiCho.Core.Attributes;
using DiCho.DataService.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using System;
using System.Collections.Generic;

namespace DiCho.DataService.ViewModels
{
    public class ProductHarvestModel
    {
        public static string[] Fields = {
            "Id", "Name", "ProductName", "Image1", "Image2", "Image3", "Image4", "Image5", "Description",
            "EstimatedTime", "EstimatedProduction", "InventoryTotal", "Unit", "FarmId", "ProductSystemId", "StartAt", "ActualProduction",
            "Farm", "ProductSystem"
        };
        public int? Id { get; set; }
        [StringAttribute]
        public string Name { get; set; }
        [StringAttribute]
        public string ProductName { get; set; }
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
        public DateTime? StartAt { get; set; }
        [BindNever]
        public DateTime? EstimatedTime { get; set; }
        [BindNever]
        public double? EstimatedProduction { get; set; }
        [BindNever]
        public double? ActualProduction { get; set; }
        [BindNever]
        public double? InventoryTotal { get; set; }
        public int? FarmId { get; set; }
        [BindNever]
        public int? ProductSystemId { get; set; }

        public virtual FarmMappingHarvestModel Farm { get; set; }
        public virtual ProductSystemMappingHarvestModel ProductSystem { get; set; }
    }

    public class ProductHarvestCreateInputModel
    {
        public string Name { get; set; }
        public string ProductName { get; set; }
        public IFormFileCollection Images { get; set; }
        public string Description { get; set; }
        public DateTime? StartAt { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? EstimatedProduction { get; set; }
        public double? ActualProduction { get; set; }
        public int? FarmId { get; set; }
        public int? ProductSystemId { get; set; }
    }

    public class ProductHarvestDetailViewModel
    {
        public int? Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public DateTime? StartAt { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? EstimatedProduction { get; set; }
        public double? ActualProduction { get; set; }
        public double? InventoryTotal { get; set; }
        public int? FarmId { get; set; }
        public int? ProductSystemId { get; set; }

        public int? CampaignId { get; set; }
        public int? MaxCapacity { get; set; }
        public int? MinCapacity { get; set; }
        public virtual FarmMappingHarvestModel Farm { get; set; }
        public virtual ProductSystemMappingHarvestModel ProductSystem { get; set; }
    }

    public class ProductHarvestCreateModel
    {
        public string Name { get; set; }
        public string ProductName { get; set; }
        public double? Price { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public DateTime? StartAt { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? EstimatedProduction { get; set; }
        public double? ActualProduction { get; set; }
        public double? InventoryTotal { get; set; }
        public int? FarmId { get; set; }
        public int? ProductSystemId { get; set; }
    }

    public class ProductHarvestUpdateInputModel
    {
        public int? Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public IFormFileCollection Images { get; set; }
        public string Description { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? ActualProduction { get; set; }
    }

    public class ProductHarvestUpdateModel
    {
        public int? Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? ActualProduction { get; set; }
        public double? InventoryTotal { get; set; }
    }

    public class HarvestMappingModel
    {
        [BindNever]
        public int? Id { get; set; }
        [BindNever]
        public string Name { get; set; }
        [BindNever]
        public string ProductName { get; set; }
        [BindNever]
        public string Description { get; set; }
        [BindNever]
        public DateTime? StartAt { get; set; }
        [BindNever]
        public double? InventoryTotal { get; set; }
        [BindNever]
        public string Image1 { get; set; }
        [BindNever]
        public int? FarmId { get; set; }
        [BindNever]
        public int? ProductSystemId { get; set; }

        [BindNever]
        public virtual FarmMappingHarvestModel Farm { get; set; }
        [BindNever]
        public virtual ProductSystemMappingHarvestModel ProductSystem { get; set; }
    }
    public class HarvestMappingCartModel
    {
        public int? Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? EstimatedProduction { get; set; }
        public double? InventoryTotal { get; set; }
        public int? FarmId { get; set; }
        public int? ProductSystemId { get; set; }

        public virtual FarmMappingHarvestModel Farm { get; set; }
        public virtual ProductSystemMappingHarvestModel ProductSystem { get; set; }
    }

    public class ProductHarvestMappingCampaignModel
    {
        public int? Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? EstimatedProduction { get; set; }
        public double? InventoryTotal { get; set; }
        public string Unit { get; set; }
        public double? ValueChangeOfUnit { get; set; }
        public int? FarmId { get; set; }
        public int? ProductSystemId { get; set; }

        public virtual ICollection<ProductHarvestMapToFarmInCampaign> ProductHarvestInCampaigns { get; set; }
    }

    public class HarvestApplyRequestModel
    {
        public int? Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? EstimatedProduction { get; set; }
        public double? InventoryTotal { get; set; }
        public DateTime? StartAt { get; set; }
        public int? ProductSystemId { get; set; }

        public virtual ProductSystemMappingHarvestModel ProductSystem { get; set; }
    }

    public class HarvestApplyModel
    {
        public int? Id { get; set; }
        public string Name { get; set; }
    }

    public class HarvestDetailModel
    {
        public int? Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public double? InventoryTotal { get; set; }
        public int? ProductSystemId { get; set; }

        public virtual ProductSystemMappingHarvestModel ProductSystem { get; set; }
    }

    public class HarvestMapItemCartModel
    {
        public int? Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? EstimatedProduction { get; set; }
        public double? InventoryTotal { get; set; }
        public DateTime? StartAt { get; set; }
        public bool? Active { get; set; }
        public int? FarmId { get; set; }
        public int? ProductSystemId { get; set; }

        public virtual FarmItemCartViewModel Farm { get; set; }
        public virtual ProductSystem ProductSystem { get; set; }
    }

    public class ProductHarvestSearchNameModel
    {
        public static string[] Fields = {
            "Id", "Name", "Image1"
        };
        [BindNever]
        public int? Id { get; set; }
        [StringAttribute]
        public string Name { get; set; }
        [BindNever]
        public string Image1 { get; set; }
        [BindNever]
        public string FarmName { get; set; }
    }

    public class HarvestDataMapModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? EstimatedProduction { get; set; }
        public double? InventoryTotal { get; set; }
        public DateTime? StartAt { get; set; }
        public bool? Active { get; set; }
        public int? FarmId { get; set; }
        public int? ProductSystemId { get; set; }
        public virtual ICollection<HarvestCampaignDataMapModel> ProductHarvestInCampaigns { get; set; }
        //public virtual ProductSystemDataMapModel ProductSystem { get; set; }
        public virtual FarmDataMapModel Farm { get; set; }
    }

    public class HarvestDataMapProductSystemModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? EstimatedProduction { get; set; }
        public double? InventoryTotal { get; set; }
        public DateTime? StartAt { get; set; }
        public bool Active { get; set; }
        public int? FarmId { get; set; }
        public int? ProductSystemId { get; set; }
        public virtual ProductSystemDataMapModel ProductSystem { get; set; }
        public virtual FarmDataMapModel Farm { get; set; }
    }

    public class HarvestSuggestFarmerApplyModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public double? Price { get; set; }
        public string Image1 { get; set; }
        public string UnitSystem { get; set; }
        public double? MinPrice { get; set; }
        public double? MaxPrice { get; set; }
        public string FarmName { get; set; }
        public double? InventoryHarvest { get; set; }
        public int? MaxCapacity { get; set; }
        public int? MinCapacity { get; set; }
        public double? InventoryTotal { get; set; }
    }

    public class HarvestSuggestFarmerApplyData
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? EstimatedProduction { get; set; }
        public double? InventoryTotal { get; set; }
        public DateTime? StartAt { get; set; }
        public bool Active { get; set; }
        public int? FarmId { get; set; }
        public int? ProductSystemId { get; set; }
        public virtual ProductSystemDataMapModel ProductSystem { get; set; }
        public virtual FarmMappingHarvestModel Farm { get; set; }
    }

    public class HarvestMapNotiModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Image1 { get; set; }
        public virtual FarmMapNotiModel Farm { get; set; }
    }

    public class HarvestMappingHarvestCampaignModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? EstimatedProduction { get; set; }
        public double? InventoryTotal { get; set; }
        public DateTime? StartAt { get; set; }
        public bool? Active { get; set; }
        public int? FarmId { get; set; }
        public int? ProductSystemId { get; set; }
        public virtual ProductSystemMappingHarvestModel ProductSystem { get; set; }
        public virtual FarmMappingHarvestInCampaign Farm { get; set; }
    }

    public class ProductHarvestOriginModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string ProductName { get; set; }
        public double? Price { get; set; }
        public string Image1 { get; set; }
        public string Image2 { get; set; }
        public string Image3 { get; set; }
        public string Image4 { get; set; }
        public string Image5 { get; set; }
        public string Description { get; set; }
        public DateTime? EstimatedTime { get; set; }
        public double? EstimatedProduction { get; set; }
        public double? ActualProduction { get; set; }
        public double? InventoryTotal { get; set; }
        public DateTime? StartAt { get; set; }
        public bool Active { get; set; }
        public int? FarmId { get; set; }
        public int? ProductSystemId { get; set; }

        public virtual FarmMappingCampaignModel Farm { get; set; }
        public virtual ProductSystemMappingHarvestModel ProductSystem { get; set; }
    }
}
