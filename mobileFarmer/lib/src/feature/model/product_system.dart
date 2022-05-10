class ProductSystem {
  final int? id;
  final String name;
  final int minPrice;
  final int maxPrice;
  final String unit;
  final String province;
  final int productCategoryId;

  // final bool status;

  ProductSystem({
    this.id,
    required this.name,
    required this.minPrice,
    required this.maxPrice,
    required this.unit,
    required this.province,
    required this.productCategoryId,
  });

  factory ProductSystem.fromJson(Map<String, dynamic> json) {
    return ProductSystem(
      id: json['id'],
      name: json['name'],
      minPrice: json['minPrice'],
      maxPrice: json['maxPrice'],
      unit: json['unit'] ?? '',
      province: json['province'],
      productCategoryId: json['productCategoryId'],
    );
  }

  // Magic goes here. you can use this function to from json method.
  static ProductSystem fromJsonModel(Map<String, dynamic> json) =>
      ProductSystem.fromJson(json);
}

class ProductSalesCampaign {
  final int? id;
  final String productName;
  final String unit;
  final num capacity;


  ProductSalesCampaign({
    this.id,
    required this.productName,
    required this.unit,
    required this.capacity,
  });

  factory ProductSalesCampaign.fromJson(Map<String, dynamic> json) {
    return ProductSalesCampaign(
      id: json['id'],
      productName: json['productName'],
      unit: json['unit'],
      capacity: json['capacity'] ?? 0,
    );
  }

  // Magic goes here. you can use this function to from json method.
  static ProductSalesCampaign fromJsonModel(Map<String, dynamic> json) =>
      ProductSalesCampaign.fromJson(json);
}
