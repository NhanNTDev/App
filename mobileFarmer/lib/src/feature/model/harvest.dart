class Harvest {
  final int? id;
  final String name;
  final String productName;
  final String productNameChange;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String description;
  final String startAt;
  final String estimatedTime;
  final num estimatedProduction;
  final num actualProduction;
  final num inventoryTotal;
  final String unit;
  final String farmName;
  final String categoryName;
  final int minPrice;
  final int maxPrice;
  final String productSystemName;

  Harvest(
      {this.id,
      required this.name,
      required this.productName,
        required this.productNameChange,
      required this.image1,
      required this.image2,
      required this.image3,
      required this.image4,
      required this.image5,
      required this.description,
      required this.startAt,
      required this.estimatedTime,
      required this.estimatedProduction,
      required this.actualProduction,
      required this.inventoryTotal,
      required this.unit,
      required this.farmName,
      required this.categoryName,
      required this.minPrice,
      required this.maxPrice,
      required this.productSystemName});

  factory Harvest.fromJson(Map<String, dynamic> json) {
    return Harvest(
        id: json['id'],
        name: json['name'],
        productName: json['productSystem']['name'] ?? '',
        image1: json['image1'] ?? '',
        image2: json['image2'] ?? '',
        image3: json['image3'] ?? '',
        image4: json['image4'] ?? '',
        image5: json['image5'] ?? '',
        description: json['description'] ?? '',
        startAt: json['startAt'],
        estimatedTime: json['estimatedTime'],
        estimatedProduction: json['estimatedProduction'] ?? 0,
        actualProduction: json['actualProduction'] ?? 0,
        inventoryTotal: json['inventoryTotal'],
        productNameChange: json['productName'],
        unit: json['productSystem']['unit'] ?? '',
        farmName: json['farm']['name'],
        categoryName: json['productSystem']['productCategory']['name'],
        minPrice: json['productSystem']['minPrice'],
        maxPrice: json['productSystem']['maxPrice'],
        productSystemName: json['productSystem']['name'],
    );
  }

  // Magic goes here. you can use this function to from json method.
  static Harvest fromJsonModel(Map<String, dynamic> json) =>
      Harvest.fromJson(json);
}

class HarvestModel {
  final int harvestId;
  final String harvestName;

  HarvestModel({required this.harvestId, required this.harvestName});

  factory HarvestModel.fromJson(Map<String, dynamic> json) {
    return HarvestModel(
      harvestId: json['id'],
      harvestName: json['name'],
    );
  }

  static HarvestModel fromJsonModel(Map<String, dynamic> json) =>
      HarvestModel.fromJson(json);
}

class SearchHarvest{
  final int? id;
  final String name;
  final String image1;
  final String farmName;

  SearchHarvest({this.id, required this.name, required this.image1, required this.farmName});

  factory SearchHarvest.fromJson(Map<String, dynamic> json) {
    return SearchHarvest(
      id: json['id'],
      name: json['name'],
      image1: json['image1'],
      farmName: json['farmName'],
    );
  }

  static SearchHarvest fromJsonModel(Map<String, dynamic> json) => SearchHarvest.fromJson(json);
}

class HarvestSuggest{
  final int? id;
  final String name;

  HarvestSuggest({this.id, required this.name});

  factory HarvestSuggest.fromJson(Map<String, dynamic> json) {
    return HarvestSuggest(
      id: json['id'],
      name: json['name'],
    );
  }

  static HarvestSuggest fromJsonModel(Map<String, dynamic> json) => HarvestSuggest.fromJson(json);
}