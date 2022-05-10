class Account {
  String? id;
  final String token;
  final String role;
  final String username;
  final String phoneNumber;
  final String tokenType;
  final String expires;
  final String name;
  final String avatar;
  final String email;
  final String gender;
  final String address;
  final String dateOfBirth;

  Account(
      {this.id,
      required this.token,
      required this.role,
      required this.username,
      required this.tokenType,
      required this.expires,
      required this.name,
      required this.avatar,
      required this.email,
      required this.phoneNumber,
      required this.gender,
      required this.address,
      required this.dateOfBirth});

  static Account fromJson(Map<String, dynamic> json) => Account(
      id: json['user']['id'],
      token: json['token'],
      role: json['user']['role'],
      username: json['user']['userName'],
      tokenType: json['tokenType'],
      expires: json['expires'],
      name: json['user']['name'] ?? '',
      avatar: json['user']['image'],
      email: json['user']['email'] ?? '',
      gender: json['user']['gender'] ?? '',
      phoneNumber: json['user']['phoneNumber'],
      address: json['user']['address'] ?? '',
      dateOfBirth: json['user']['dateOfBirth'] ?? DateTime.now().toString());

// Map<String, dynamic> toJson() => {
//       'id': id,
//       'token': token,
//       'role': role,
//       'username': username,
//       'tokenType': tokenType,
//       'expires': expires,
//       'shortName': shortName,
//       'name': name,
//       'image': image,
//       'email': email
//     };
}

class DashBoard {
  final num farms;
  final num harvests;
  final num orderConfirms;
  final num customerOrder;


  DashBoard(
      {required this.farms,
        required this.harvests,
        required this.orderConfirms,
        required this.customerOrder,});

  static DashBoard fromJson(Map<String, dynamic> json) => DashBoard(
    farms: json['farms'],
    harvests: json['harvests'],
    orderConfirms: json['orderConfirms'],
    customerOrder: json['customerOrder'],);
}

class Revenue {
  final num totalRevenues;
  final num customers;
  final num farmOrders;


  Revenue(
      {required this.totalRevenues,
        required this.customers,
        required this.farmOrders,});

  static Revenue fromJson(Map<String, dynamic> json) => Revenue(
    totalRevenues: json['totalRevenues'],
    customers: json['customers'],
    farmOrders: json['farmOrders'],
    );
}