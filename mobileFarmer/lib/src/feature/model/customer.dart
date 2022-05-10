class Customer {
  final String? id;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String image;
  final String gender;
  final String dateOfBirth;
  final int countFarmOrders;

  Customer(
      {this.id,
        required this.name,
        required this.phone,
        required this.email,
        required this.address,
        required this.image,
        required this.gender,
        required this.dateOfBirth,
        required this.countFarmOrders,
      });

  factory Customer.fromJson(Map<String, dynamic> json) {
    print(json);
    return Customer(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      image: json['image'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      countFarmOrders: json['countFarmOrders'] ?? 0,
    );
  }

  // Magic goes here. you can use this function to from json method.
  static Customer fromJsonModel(Map<String, dynamic> json) => Customer.fromJson(json);
}
