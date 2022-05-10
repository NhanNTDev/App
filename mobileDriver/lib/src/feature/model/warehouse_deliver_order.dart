// class WarehouseDeliverOrder {
//   final int? id;
//   final String code;
//   final String from;
//   final String to;
//   final String status;
//   final String driverId;
//   final String warehouseFrom;
//   final String warehouseTo;
//   final String createAt;
//   final num totalWeight;
//   final List<Order> orders;
//
//   WarehouseDeliverOrder(
//       {this.id,
//       required this.code,
//       required this.from,
//       required this.to,
//       required this.status,
//       required this.driverId,
//       required this.warehouseFrom,
//       required this.warehouseTo,
//       required this.createAt,
//       required this.totalWeight,
//       required this.orders});
//
//   factory WarehouseDeliverOrder.fromJson(Map<String, dynamic> json) {
//     return WarehouseDeliverOrder(
//         id: json['id'],
//         code: json['code'],
//         from: json['from'],
//         to: json['to'],
//         status: json['status'],
//         driverId: json['driverId'],
//         warehouseFrom: json['warehouseFrom'],
//         warehouseTo: json['warehouseTo'],
//         createAt: json['createAt'],
//         totalWeight: json['totalWeight'],
//         orders: List<Order>.from(json['orders']
//             .map((itemsJson) => Order.fromJsonModel(itemsJson))));
//   }
//
//   // Magic goes here. you can use this function to from json method.
//   static WarehouseDeliverOrder fromJsonModel(Map<String, dynamic> json) =>
//       WarehouseDeliverOrder.fromJson(json);
// }
//
// class Order {
//   final int? id;
//   final String code;
//   final String customerName;
//
//   Order(
//       {this.id,
//       required this.code,
//       required this.customerName,});
//
//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//         id: json['id'],
//         code: json['code'],
//         customerName: json['customerName'],);
//   }
//
//   // Magic goes here. you can use this function to from json method.
//   static Order fromJsonModel(Map<String, dynamic> json) => Order.fromJson(json);
// }

class WarehouseDeliverOrder {
  final int? id;
  final String code;
  final String warehouseFrom;
  final String from;
  final String status;
  final String driverId;
  final num totalWeight;
  final String createAt;
  final List<ShipmentDestination> shipmentDestinations;

  WarehouseDeliverOrder(
      {this.id,
        required this.code,
        required this.warehouseFrom,
        required this.from,
        required this.status,
        required this.driverId,
        required this.totalWeight,
        required this.createAt,
        required this.shipmentDestinations});

  factory WarehouseDeliverOrder.fromJson(Map<String, dynamic> json) {
    return WarehouseDeliverOrder(
        id: json['id'],
        code: json['code'],
        warehouseFrom: json['warehouseFrom'],
        from: json['from'],
        status: json['status'],
        driverId: json['driverId'],
        totalWeight: json['totalWeight'],
        createAt: json['createAt'],
        shipmentDestinations: List<ShipmentDestination>.from(json['shipmentDestinations']
            .map((itemsJson) => ShipmentDestination.fromJsonModel(itemsJson))));
  }

  // Magic goes here. you can use this function to from json method.
  static WarehouseDeliverOrder fromJsonModel(Map<String, dynamic> json) =>
      WarehouseDeliverOrder.fromJson(json);
}

class ShipmentDestination{
  final int? id;
  final String address;
  final String warehouseTo;
  final List<Order> orders;

  ShipmentDestination(
      {this.id,
        required this.address,
        required this.warehouseTo,
        required this.orders,});

  factory ShipmentDestination.fromJson(Map<String, dynamic> json) {
    return ShipmentDestination(
        id: json['id'],
        warehouseTo: json['warehouseTo'],
        address: json['address'],
        orders: List<Order>.from(json['orders']
            .map((itemsJson) => Order.fromJsonModel(itemsJson))));
  }

  // Magic goes here. you can use this function to from json method.
  static ShipmentDestination fromJsonModel(Map<String, dynamic> json) =>
      ShipmentDestination.fromJson(json);
}

class Order {
  final int? id;
  final String code;
  final String customerName;

  Order(
      {this.id,
        required this.code,
        required this.customerName,});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      code: json['code'],
      customerName: json['customerName'],);
  }

  // Magic goes here. you can use this function to from json method.
  static Order fromJsonModel(Map<String, dynamic> json) => Order.fromJson(json);
}
