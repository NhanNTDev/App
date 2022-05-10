class HarvestInCampaign {
  final int? id;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String harvestName;
  final String productName;
  final String productCategoryName;
  final num price;
  final String unit;
  final num valueChangeOfUnit;
  final num inventory;
  final num quantity;
  final String status;
  final int harvestId;

  HarvestInCampaign({this.id,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.harvestName,
    required this.productName,
    required this.productCategoryName,
    required this.price,
    required this.unit,
    required this.valueChangeOfUnit,
    required this.inventory,
    required this.quantity,
    required this.status,
    required this.harvestId,
 });

  factory HarvestInCampaign.fromJson(Map<String, dynamic> json) {
    return HarvestInCampaign(
        id: json['id'],
        image1: json['image1'] ?? '',
        image2: json['image2'] ?? '',
        image3: json['image3'] ?? '',
        image4: json['image4'] ?? '',
        image5: json['image5'] ?? '',
        harvestName: json['harvestName'],
        productName: json['productName'],
        productCategoryName: json['productCategoryName'],
        price: json['price'],
        unit: json['unit'] ?? '',
        valueChangeOfUnit: json['valueChangeOfUnit'],
        inventory: json['inventory'],
        quantity: json['quantity'],
        status: json['status'],
        harvestId: json['harvestId']);
  }

  // Magic goes here. you can use this function to from json method.
  static HarvestInCampaign fromJsonModel(Map<String, dynamic> json) =>
      HarvestInCampaign.fromJson(json);
}

class CreateHarvestInCampaign {
  final num inventory;
  final num price;
  final String unit;
  final int valueChangeOfUnit;
  final int harvestId;
  final int campaignId;

  CreateHarvestInCampaign({required this.inventory,
    required this.price,
    required this.unit,
    required this.valueChangeOfUnit,
    required this.harvestId,
    required this.campaignId});

  Map toJson() =>
      {
        "inventory": inventory,
        "price": price,
        "unit": unit,
        "valueChangeOfUnit": valueChangeOfUnit,
        "harvestId": harvestId,
        "campaignId": campaignId
      };
}

class HarvestInCampaignDetail {
  final int? id;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String harvestName;
  final String productName;
  final String productSystemName;
  final String productCategoryName;
  final num price;
  final String unit;
  final num valueChangeOfUnit;
  final num inventory;
  final num quantity;
  final String status;
  final String harvestDescription;
  final String campaignName;
  final int harvestId;
  final String farmName;
  final int campaignId;

  HarvestInCampaignDetail({this.id,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.harvestName,
    required this.productName,
    required this.productSystemName,
    required this.productCategoryName,
    required this.price,
    required this.unit,
    required this.valueChangeOfUnit,
    required this.inventory,
    required this.quantity,
    required this.campaignName,
    required this.farmName,
    required this.status,
    required this.campaignId,
    required this.harvestDescription,
    required this.harvestId,
  });

  factory HarvestInCampaignDetail.fromJson(Map<String, dynamic> json) {
    return HarvestInCampaignDetail(
        id: json['id'],
        image1: json['image1'] ?? '',
        image2: json['image2'] ?? '',
        image3: json['image3'] ?? '',
        image4: json['image4'] ?? '',
        image5: json['image5'] ?? '',
        harvestName: json['harvestName'],
        productName: json['productName'],
        farmName: json['farmName'],
        productSystemName: json['productNameSystem'],
        productCategoryName: json['productCategoryName'],
        price: json['price'],
        unit: json['unit'] ?? '',
        valueChangeOfUnit: json['valueChangeOfUnit'],
        inventory: json['inventory'],
        quantity: json['quantity'],
        campaignName: json['campaign']['name'],
        campaignId: json['campaign']['id'],
        status: json['status'],
        harvestDescription: json['harvestDescription'] ?? '',
        harvestId: json['harvestId']);
  }

  // Magic goes here. you can use this function to from json method.
  static HarvestInCampaignDetail fromJsonModel(Map<String, dynamic> json) =>
      HarvestInCampaignDetail.fromJson(json);
}