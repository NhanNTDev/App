class Farm {
  final int? id;
  final String name;
  final String avatar;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String description;
  final String address;
  final bool active;
  final num totalStar;
  final num feedbacks;

  Farm(
      {this.id,
      required this.name,
      required this.avatar,
      required this.image1,
      required this.image2,
      required this.image3,
      required this.image4,
      required this.image5,
      required this.description,
      required this.address,
      required this.active,
      required this.totalStar,
      required this.feedbacks,
      });

  factory Farm.fromJson(Map<String, dynamic> json) {
    print(json['name']);
    return Farm(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      image1: json['image1'] ?? 'data:image/jpeg;base64,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',
      image2: json['image2'] ?? '',
      image3: json['image3'] ?? '',
      image4: json['image4'] ?? '',
      image5: json['image5'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      active: json['active'],
      totalStar: json['totalStar'] ?? 0,
      feedbacks: json['feedbacks'] ?? 0,
    );
  }

  // Magic goes here. you can use this function to from json method.
  static Farm fromJsonModel(Map<String, dynamic> json) => Farm.fromJson(json);
}


class FarmModel{
  final int farmId;
  final String farmName;

  FarmModel({required this.farmId, required this.farmName});

  factory FarmModel.fromJson(Map<String, dynamic> json) {
    return FarmModel(
      farmId: json['id'],
      farmName: json['name'],
    );
  }

  static FarmModel fromJsonModel(Map<String, dynamic> json) => FarmModel.fromJson(json);
}

class SearchFarm{
  final int? id;
  final String name;
  final String avatar;
  final String address;

  SearchFarm({this.id, required this.name, required this.avatar, required this.address});

  factory SearchFarm.fromJson(Map<String, dynamic> json) {
    return SearchFarm(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      address: json['address'],
    );
  }

  static SearchFarm fromJsonModel(Map<String, dynamic> json) => SearchFarm.fromJson(json);
}