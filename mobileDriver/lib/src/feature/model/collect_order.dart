// class CollectOrder {
//   final int? id;
//   final List<FarmOrder> farmOrders;
//
//   CollectOrder({this.id, required this.farmOrders});
//
//   factory CollectOrder.fromJson(Map<String, dynamic> json) {
//     return CollectOrder(
//         id: json['id'],
//         farmOrders: List<FarmOrder>.from(json['farmOrders']
//             .map((itemsJson) => FarmOrder.fromJsonModel(itemsJson))));
//   }
//
//   // Magic goes here. you can use this function to from json method.
//   static CollectOrder fromJsonModel(Map<String, dynamic> json) =>
//       CollectOrder.fromJson(json);
// }
//
// class FarmOrder {
//   final int? id;
//   final String code;
//   final String farmName;
//   final String farmAddress;
//   final String note;
//   final List<HarvestOrder> harvestOrders;
//
//   FarmOrder(
//       {this.id,
//       required this.code,
//       required this.farmName,
//       required this.farmAddress,
//         required this.note,
//       required this.harvestOrders});
//
//   factory FarmOrder.fromJson(Map<String, dynamic> json) {
//     return FarmOrder(
//         id: json['id'],
//         code: json['code'],
//         farmName: json['farm']['name'],
//         farmAddress: json['farm']['address'],
//         note: json['note'] ?? '',
//         harvestOrders: List<HarvestOrder>.from(json['productHarvestOrders']
//             .map((itemsJson) => HarvestOrder.fromJsonModel(itemsJson))));
//   }
//
//   // Magic goes here. you can use this function to from json method.
//   static FarmOrder fromJsonModel(Map<String, dynamic> json) =>
//       FarmOrder.fromJson(json);
// }
//
// class HarvestOrder {
//   final int? id;
//   final String productName;
//   final String unit;
//   final num quantity;
//
//   HarvestOrder(
//       {this.id,
//       required this.productName,
//       required this.unit,
//       required this.quantity});
//
//   factory HarvestOrder.fromJson(Map<String, dynamic> json) {
//     return HarvestOrder(
//       id: json['id'],
//       productName: json['productName'],
//       unit: json['unit'],
//       quantity: json['quantity'],
//     );
//   }
//
//   // Magic goes here. you can use this function to from json method.
//   static HarvestOrder fromJsonModel(Map<String, dynamic> json) =>
//       HarvestOrder.fromJson(json);
// }


class CollectDestination {
  final String? collectionCode;
  final num totalWeight;
  final List<Farm> farms;

  CollectDestination({this.collectionCode, required this.totalWeight, required this.farms});

  factory CollectDestination.fromJson(Map<String, dynamic> json) {
    return CollectDestination(
        collectionCode: json['collectionCode'] ?? '',
        totalWeight: json['totalWeight'] ?? 0,
        farms: List<Farm>.from(json['farms']
            .map((itemsJson) => Farm.fromJsonModel(itemsJson))));
  }

  // Magic goes here. you can use this function to from json method.
  static CollectDestination fromJsonModel(Map<String, dynamic> json) =>
      CollectDestination.fromJson(json);
}

class Farm {
  final int? id;
  final String name;
  final String phone;
  final String address;
  final String farmZoneName;
  final List<FarmOrder> farmOrders;

  Farm(
      {this.id,
        required this.name,
        required this.phone,
        required this.address,
        required this.farmZoneName,
        required this.farmOrders});

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        address: json['address'],
        farmZoneName: json['farmZoneName'] ?? '',
        farmOrders: List<FarmOrder>.from(json['farmOrders']
            .map((itemsJson) => FarmOrder.fromJsonModel(itemsJson))));
  }

  // Magic goes here. you can use this function to from json method.
  static Farm fromJsonModel(Map<String, dynamic> json) =>
      Farm.fromJson(json);
}


class FarmOrder {
  final int? id;
  final String code;
  String status;
  String note;
  final String collectionCode;
  final List<ProductHarvestOrder> productHarvestOrders;

  FarmOrder(
      {this.id,
        required this.code,
        required this.status,
        required this.note,
        required this.collectionCode,
        required this.productHarvestOrders});

  factory FarmOrder.fromJson(Map<String, dynamic> json) {
    return FarmOrder(
        id: json['id'] ?? 0,
        code: json['code'] ?? '',
        status: json['status'] ?? '',
        note: json['note'] ?? '',
        collectionCode: json['collectionCode'] ?? '',
        productHarvestOrders: List<ProductHarvestOrder>.from(json['productHarvestOrders']
            .map((itemsJson) => ProductHarvestOrder.fromJsonModel(itemsJson))));
  }

  // Magic goes here. you can use this function to from json method.
  static FarmOrder fromJsonModel(Map<String, dynamic> json) =>
      FarmOrder.fromJson(json);
}

class ProductHarvestOrder {
  final int? id;
  final String productName;
  final String unit;
  final num quantity;

  ProductHarvestOrder(
      {this.id,
        required this.productName,
        required this.unit,
        required this.quantity});

  factory ProductHarvestOrder.fromJson(Map<String, dynamic> json) {
    return ProductHarvestOrder(
      id: json['id'] ?? 0,
      productName: json['productName'] ?? '',
      unit: json['unit'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }

  // Magic goes here. you can use this function to from json method.
  static ProductHarvestOrder fromJsonModel(Map<String, dynamic> json) =>
      ProductHarvestOrder.fromJson(json);
}
