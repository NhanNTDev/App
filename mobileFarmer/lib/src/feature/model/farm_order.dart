class FarmOrder {
  final int? id;
  final String code;
  final num total;
  final String status;
  final String createAt;
  final int orderId;
  final String customerName;
  final String campaignName;
  final String paymentStatus;
  final String paymentTypeName;
  final String farmName;
  final String feedBackCreateAt;
  final String note;

  FarmOrder(
      {this.id,
      required this.code,
      required this.total,
      required this.status,
      required this.createAt,
      required this.orderId,
      required this.customerName,
      required this.campaignName,
      required this.paymentStatus,
      required this.paymentTypeName,
      required this.farmName,
      required this.feedBackCreateAt,
      required this.note,
      });

  factory FarmOrder.fromJson(Map<String, dynamic> json) {
    return FarmOrder(
        id: json['id'],
        code: json['code'],
        total: json['total'],
        status: json['status'],
        createAt: json['createAt'],
        orderId: json['orderId'],
        customerName: json['customerName'] ?? '',
        campaignName: json['campaignName'],
        paymentStatus: json['paymentStatus'] ?? '',
        paymentTypeName: json['paymentTypeName'],
        farmName: json['farm']['name'],
      feedBackCreateAt: json['feedBackCreateAt'] ?? '',
      note: json['note'] ?? '',
    );
  }

  // Magic goes here. you can use this function to from json method.
  static FarmOrder fromJsonModel(Map<String, dynamic> json) =>
      FarmOrder.fromJson(json);
}

class FarmOrderDetail {
  final int? id;
  final String code;
  final num total;
  final String status;
  final String createAt;
  final int orderId;
  final String address;
  final String phone;
  final String customerName;
  final String campaignName;
  final String paymentStatus;
  final String paymentTypeName;
  final String farmName;
  final num star;
  final String content;
  final String feedBackCreateAt;
  final String note;
  final List<HarvestOrder> harvestOrders;

  FarmOrderDetail(
      {this.id,
      required this.code,
      required this.total,
      required this.status,
      required this.createAt,
      required this.orderId,
      required this.customerName,
      required this.campaignName,
      required this.phone,
      required this.address,
      required this.paymentStatus,
      required this.paymentTypeName,
      required this.farmName,
      required this.star,
      required this.content,
      required this.feedBackCreateAt,
      required this.note,
      required this.harvestOrders});

  factory FarmOrderDetail.fromJson(Map<String, dynamic> json) {
    return FarmOrderDetail(
        id: json['id'],
        code: json['code'] ?? '',
        total: json['total'] ?? 0,
        status: json['status'] ?? '',
        createAt: json['createAt'] ?? '',
        orderId: json['orderId'] ?? 0,
        customerName: json['customerName'] ?? '',
        address: json['address'] ?? '',
        campaignName: json['campaignName'] ?? '',
        phone: json['phone'] ?? '',
        paymentStatus: json['paymentStatus'] ?? '',
        paymentTypeName: json['paymentTypeName'] ?? '',
        farmName: json['farm']['name'] ?? '',
        star: json['star'] ?? 0,
        content: json['content'] ?? '',
        feedBackCreateAt: json['feedBackCreateAt'] ?? '',
        note: json['note'] ?? '',
        harvestOrders: List<HarvestOrder>.from(json['productHarvestOrders']
            .map((itemsJson) => HarvestOrder.fromJsonModel(itemsJson))));
  }

  // Magic goes here. you can use this function to from json method.
  static FarmOrderDetail fromJsonModel(Map<String, dynamic> json) =>
      FarmOrderDetail.fromJson(json);
}

class HarvestOrder {
  final int? id;
  final String productName;
  final String unit;
  final num quantity;
  final num price;

  HarvestOrder(
      {this.id,
      required this.productName,
      required this.unit,
      required this.quantity,
      required this.price});

  factory HarvestOrder.fromJson(Map<String, dynamic> json) {
    return HarvestOrder(
      id: json['id'],
      productName: json['productName'],
      unit: json['unit'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  // Magic goes here. you can use this function to from json method.
  static HarvestOrder fromJsonModel(Map<String, dynamic> json) =>
      HarvestOrder.fromJson(json);
}
