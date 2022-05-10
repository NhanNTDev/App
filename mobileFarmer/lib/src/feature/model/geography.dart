class ProvinceOrCity {
  final String code;
  final String name;
  final String slug;
  final String type;
  final String nameWithType;

  ProvinceOrCity({
    required this.code,
    required this.name,
    required this.slug,
    required this.type,
    required this.nameWithType,
  });

  static ProvinceOrCity fromJson(Map<String, dynamic> json) => ProvinceOrCity(
        code: json['code'],
        name: json['name'],
        slug: json['slug'],
        type: json['type'],
        nameWithType: json['name_with_type'],
      );
}

class District {
  final String code;
  final String parentCode;
  final String name;
  final String type;
  final String slug;
  final String nameWithType;
  final String path;
  final String pathWithType;

  District({
    required this.code,
    required this.parentCode,
    required this.name,
    required this.slug,
    required this.type,
    required this.nameWithType,
    required this.path,
    required this.pathWithType,
  });

  static District fromJson(Map<String, dynamic> json) => District(
        code: json['code'],
        parentCode: json['parent_code'],
        name: json['name'],
        slug: json['slug'],
        type: json['type'],
        nameWithType: json['name_with_type'],
        path: json['path'],
        pathWithType: json['path_with_type'],
      );
}

class SubDistrictOrVillage {
  final String code;
  final String parentCode;
  final String name;
  final String type;
  final String slug;
  final String nameWithType;
  final String path;
  final String pathWithType;

  SubDistrictOrVillage({
    required this.code,
    required this.parentCode,
    required this.name,
    required this.slug,
    required this.type,
    required this.nameWithType,
    required this.path,
    required this.pathWithType,
  });

  static SubDistrictOrVillage fromJson(Map<String, dynamic> json) =>
      SubDistrictOrVillage(
        code: json['code'],
        parentCode: json['parent_code'],
        name: json['name'],
        slug: json['slug'],
        type: json['type'],
        nameWithType: json['name_with_type'],
        path: json['path'],
        pathWithType: json['path_with_type'],
      );
}
