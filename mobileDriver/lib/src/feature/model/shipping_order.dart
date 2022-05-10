// class ShippingOrder {
//   final int? id;
//   final String customerName;
//   final String code;
//   final num total;
//   final num shipCost;
//   final String phone;
//   final String address;
//   final String createAt;
//   final String note;
//   final String driverId;
//   final List<FarmOrder> farmOrders;
//
//   ShippingOrder(
//       {this.id,
//       required this.customerName,
//       required this.code,
//       required this.total,
//       required this.shipCost,
//       required this.phone,
//       required this.address,
//       required this.createAt,
//       required this.note,
//       required this.driverId,
//       required this.farmOrders});
//
//   factory ShippingOrder.fromJson(Map<String, dynamic> json) {
//     return ShippingOrder(
//       id: json['id'],
//       customerName: json['customerName'],
//       code: json['code'],
//       total: json['total'],
//       shipCost: json['shipCost'],
//       phone: json['phone'],
//       address: json['address'],
//       createAt: json['createAt'],
//       note: json['note'] ?? '',
//       driverId: json['driverId'],
//       farmOrders: List<FarmOrder>.from(json['farmOrders']
//           .map((itemsJson) => FarmOrder.fromJsonModel(itemsJson))),
//     );
//   }
//
//   // Magic goes here. you can use this function to from json method.
//   static ShippingOrder fromJsonModel(Map<String, dynamic> json) =>
//       ShippingOrder.fromJson(json);
// }
//
// class FarmOrder {
//   final int? id;
//   final String code;
//   final List<HarvestOrder> harvestOrders;
//
//   FarmOrder({this.id, required this.code, required this.harvestOrders});
//
//   factory FarmOrder.fromJson(Map<String, dynamic> json) {
//     return FarmOrder(
//       id: json['id'],
//       code: json['code'],
//       harvestOrders: List<HarvestOrder>.from(json['productHarvestOrders']
//           .map((itemsJson) => HarvestOrder.fromJsonModel(itemsJson))),
//     );
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
//   final num price;
//
//   HarvestOrder(
//       {this.id,
//       required this.productName,
//       required this.unit,
//       required this.quantity,
//       required this.price});
//
//   factory HarvestOrder.fromJson(Map<String, dynamic> json) {
//     return HarvestOrder(
//       id: json['id'],
//       productName: json['productName'],
//       unit: json['unit'],
//       quantity: json['quantity'],
//       price: json['price'],
//     );
//   }
//
//   // Magic goes here. you can use this function to from json method.
//   static HarvestOrder fromJsonModel(Map<String, dynamic> json) =>
//       HarvestOrder.fromJson(json);
// }
//
class CountTask {
  final num taskOfCollections;
  final num taskOfShipments;
  final num taskOfDeliveries;

  CountTask({
    required this.taskOfCollections,
    required this.taskOfShipments,
    required this.taskOfDeliveries,
  });

  factory CountTask.fromJson(Map<String, dynamic> json) {
    return CountTask(
      taskOfCollections: json['taskOfCollections'],
      taskOfShipments: json['taskOfShipments'],
      taskOfDeliveries: json['taskOfDeliveries'],
    );
  }

  // Magic goes here. you can use this function to from json method.
  static CountTask fromJsonModel(Map<String, dynamic> json) =>
      CountTask.fromJson(json);
}

class DeliveryShipping{
  final String deliveryCode;
  final num totalWeight;
  final List<Address> addresses;

  DeliveryShipping({required this.deliveryCode, required this.totalWeight, required this.addresses});

  factory DeliveryShipping.fromJson(Map<String, dynamic> json) {
    return DeliveryShipping(
      deliveryCode: json['deliveryCode'],
      totalWeight: json['totalWeight'],
      addresses: List<Address>.from(json['addresses']
          .map((itemsJson) => Address.fromJsonModel(itemsJson))),
    );
  }

  // Magic goes here. you can use this function to from json method.
  static DeliveryShipping fromJsonModel(Map<String, dynamic> json) =>
      DeliveryShipping.fromJson(json);
}

class Address{
  final String address;
  final num weight;
  final List<Order> orders;

  Address({required this.address, required this.weight, required this.orders});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      weight: json['weight'],
      orders: List<Order>.from(json['orders']
          .map((itemsJson) => Order.fromJsonModel(itemsJson))),
    );
  }

  // Magic goes here. you can use this function to from json method.
  static Address fromJsonModel(Map<String, dynamic> json) =>
      Address.fromJson(json);

}

class Order{
  final int? id;
  final num weightOfOrder;
  final String customerName;
  final String code;
  final num total;
  final num shipCost;
  final String phone;
  final String address;
  String status;
  final String createAt;
  final String note;
  final String driverId;
  final String deliveryCode;
  final List<FarmOrder> farmOrders;

  Order({
    this.id, required this.weightOfOrder, required this.customerName,required this.code, required this.total,
    required this.shipCost, required this.phone, required this.address,required this.status, required this.createAt,
    required this.note, required this.driverId, required this.deliveryCode,required this.farmOrders
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      weightOfOrder: json['weightOfOrder'],
      customerName: json['customerName'],
      code: json['code'],
      total: json['total'],
      shipCost: json['shipCost'],
      phone: json['phone'],
      address: json['address'],
      status: json['status'],
      createAt: json['createAt'],
      note: json['note'] ?? '',
      driverId: json['driverId'],
      deliveryCode: json['deliveryCode'],
      farmOrders: List<FarmOrder>.from(json['farmOrders']
          .map((itemsJson) => FarmOrder.fromJsonModel(itemsJson))),
    );
  }

  // Magic goes here. you can use this function to from json method.
  static Order fromJsonModel(Map<String, dynamic> json) =>
      Order.fromJson(json);


}

class FarmOrder{
  final int? id;
  final String code;
  final List<ProductHarvest> productHarvestOrders;

  FarmOrder({
    this.id, required this.code, required this.productHarvestOrders
  });

  factory FarmOrder.fromJson(Map<String, dynamic> json) {
    return FarmOrder(
      id: json['id'],
      code: json['code'],
      productHarvestOrders: List<ProductHarvest>.from(json['productHarvestOrders']
          .map((itemsJson) => ProductHarvest.fromJsonModel(itemsJson))),
    );
  }

  // Magic goes here. you can use this function to from json method.
  static FarmOrder fromJsonModel(Map<String, dynamic> json) =>
      FarmOrder.fromJson(json);
}

class ProductHarvest{
  final int? id;
  final String productName;
  final String unit;
  final num quantity;
  final num price;
  final int? harvestCampaignId;

  ProductHarvest({
    this.id, required this.productName, required this.unit,
    required this.quantity, required this.price, this.harvestCampaignId,
  });

  factory ProductHarvest.fromJson(Map<String, dynamic> json) {
    return ProductHarvest(
      id: json['id'],
      productName: json['productName'],
      unit: json['unit'],
      quantity: json['quantity'],
      price: json['price'],
      harvestCampaignId: json['harvestCampaignId'],
    );
  }

  // Magic goes here. you can use this function to from json method.
  static ProductHarvest fromJsonModel(Map<String, dynamic> json) =>
      ProductHarvest.fromJson(json);
}