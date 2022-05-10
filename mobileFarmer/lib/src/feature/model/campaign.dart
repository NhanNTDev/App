import 'package:farmer_application/src/feature/model/farm.dart';
import 'package:farmer_application/src/feature/model/product_system.dart';

class Campaign {
  final int? id;
  final String name;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String type;
  final String description;
  final String startAt;
  final String endAt;
  final String startRecruitmentAt;
  final String endRecruitmentAt;
  final String status;
  final int farmInCampaign;
  final int campaignZoneId;
  final String campaignZoneName;
  final List<String> campaignDeliveryZones;
  final List<ProductSalesCampaign> productSalesCampaigns;

  // final bool status;

  Campaign({
    this.id,
    required this.name,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.type,
    required this.description,
    required this.startAt,
    required this.endAt,
    required this.startRecruitmentAt,
    required this.endRecruitmentAt,
    required this.status,
    required this.farmInCampaign,
    required this.campaignZoneId,
    required this.campaignZoneName,
    required this.campaignDeliveryZones,
    required this.productSalesCampaigns,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
        id: json['id'],
        name: json['name'],
        image1: json['image1'] ?? '',
        image2: json['image2'] ?? '',
        image3: json['image3'] ?? '',
        image4: json['image4'] ?? '',
        image5: json['image5'] ?? '',
        type: json['type'],
        description: json['description'],
        startAt: json['startAt'],
        endAt: json['endAt'],
        startRecruitmentAt: json['startRecruitmentAt'],
        endRecruitmentAt: json['endRecruitmentAt'],
        status: json['status'],
        farmInCampaign: json['farmInCampaign'],
        campaignZoneId: json['campaignZoneId'],
        campaignZoneName: json['campaignZoneName'],
        campaignDeliveryZones: List.from(json['deliveryZoneName']),
        productSalesCampaigns: List<ProductSalesCampaign>.from(
            json['productSalesCampaigns'].map(
                (itemsJson) => ProductSalesCampaign.fromJsonModel(itemsJson))));
  }

  // Magic goes here. you can use this function to from json method.
  static Campaign fromJsonModel(Map<String, dynamic> json) =>
      Campaign.fromJson(json);
}

class CampaignJoinedDetail {
  final int? id;
  final String name;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String type;
  final String description;
  final String endRecruitmentAt;
  final String startAt;
  final String endAt;
  final String status;
  final int farmInCampaign;
  final int campaignZoneId;
  final String campaignZoneName;
  final List<FarmModel> farms;
  final List<String> campaignDeliveryZones;
  final List<ProductSalesCampaign> productSalesCampaigns;

  // final bool status;

  CampaignJoinedDetail(
      {this.id,
      required this.name,
      required this.image1,
      required this.image2,
      required this.image3,
      required this.image4,
      required this.image5,
      required this.endRecruitmentAt,
      required this.type,
      required this.description,
      required this.startAt,
      required this.endAt,
      required this.status,
      required this.farmInCampaign,
      required this.campaignZoneId,
      required this.campaignZoneName,
      required this.farms,
      required this.campaignDeliveryZones,
        required this.productSalesCampaigns,});

  factory CampaignJoinedDetail.fromJson(Map<String, dynamic> json) {
    return CampaignJoinedDetail(
        id: json['id'],
        name: json['name'],
        image1: json['image1'] ?? '',
        image2: json['image2'] ?? '',
        image3: json['image3'] ?? '',
        image4: json['image4'] ?? '',
        image5: json['image5'] ?? '',
        type: json['type'],
        description: json['description'],
        endRecruitmentAt: json['endRecruitmentAt'],
        startAt: json['startAt'],
        endAt: json['endAt'],
        status: json['status'],
        farmInCampaign: json['farmInCampaign'],
        campaignZoneId: json['campaignZoneId'],
        campaignZoneName: json['campaignZoneName'],
        farms: List.from(
            json['farms'].map((itemsJson) => FarmModel.fromJson(itemsJson))),
        campaignDeliveryZones: List.from(json['deliveryZoneName']),
        productSalesCampaigns: List<ProductSalesCampaign>.from(
            json['productSalesCampaigns'].map(
                    (itemsJson) => ProductSalesCampaign.fromJsonModel(itemsJson))));
  }

  // Magic goes here. you can use this function to from json method.
  static Campaign fromJsonModel(Map<String, dynamic> json) =>
      Campaign.fromJson(json);
}

class CampaignCanJoin {
  final int? id;
  final String name;
  final String image1;
  final String type;
  final String description;
  final String startAt;
  final String endAt;
  final String status;
  final int farmInCampaign;
  final int campaignZoneId;
  final String campaignZoneName;
  final List<String> farms;

  // final bool status;

  CampaignCanJoin(
      {this.id,
      required this.name,
      required this.image1,
      required this.type,
      required this.description,
      required this.startAt,
      required this.endAt,
      required this.status,
      required this.farmInCampaign,
      required this.campaignZoneId,
      required this.campaignZoneName,
      required this.farms});

  factory CampaignCanJoin.fromJson(Map<String, dynamic> json) {
    print(List.from(json['farms']).length);
    return CampaignCanJoin(
        id: json['id'],
        name: json['name'],
        image1: json['image1'] ?? '',
        type: json['type'],
        description: json['description'],
        startAt: json['startAt'],
        endAt: json['endAt'],
        status: json['status'],
        farmInCampaign: json['farmInCampaign'],
        campaignZoneId: json['campaignZoneId'],
        campaignZoneName: json['campaignZoneName'],
        farms: List.from(json['farms']));
  }

  // Magic goes here. you can use this function to from json method.
  static CampaignCanJoin fromJsonModel(Map<String, dynamic> json) =>
      CampaignCanJoin.fromJson(json);
}

class JoinedCampaign {
  final int? id;
  final String name;
  final String image1;
  final String type;
  final String description;
  final String startAt;
  final String endAt;
  final String timeApply;
  final String status;
  final int farmInCampaign;
  final int campaignZoneId;
  final String campaignZoneName;
  final List<String> farms;

  // final bool status;

  JoinedCampaign(
      {this.id,
      required this.name,
      required this.image1,
      required this.type,
      required this.description,
      required this.startAt,
      required this.endAt,
      required this.timeApply,
      required this.status,
      required this.farmInCampaign,
      required this.campaignZoneId,
      required this.campaignZoneName,
      required this.farms});

  factory JoinedCampaign.fromJson(Map<String, dynamic> json) {
    print(List.from(json['farms']).length);
    return JoinedCampaign(
        id: json['id'],
        name: json['name'],
        image1: json['image1'] ?? '',
        type: json['type'],
        description: json['description'],
        startAt: json['startAt'],
        endAt: json['endAt'],
        timeApply: json['timeApply'] ?? DateTime.now().toString(),
        status: json['status'],
        farmInCampaign: json['farmInCampaign'],
        campaignZoneId: json['campaignZoneId'],
        campaignZoneName: json['campaignZoneName'],
        farms: List.from(json['farms']));
  }

  // Magic goes here. you can use this function to from json method.
  static JoinedCampaign fromJsonModel(Map<String, dynamic> json) =>
      JoinedCampaign.fromJson(json);
}

class SearchJoinCampaign {
  final int? id;
  final String name;
  final String image1;
  final String status;
  final int campaignZoneId;
  final String campaignZoneName;
  final List<String> farms;

  SearchJoinCampaign(
      {this.id,
      required this.name,
      required this.image1,
      required this.status,
      required this.campaignZoneId,
      required this.campaignZoneName,
      required this.farms});

  factory SearchJoinCampaign.fromJson(Map<String, dynamic> json) {
    return SearchJoinCampaign(
      id: json['id'],
      name: json['name'],
      image1: json['image1'],
      status: json['status'],
      campaignZoneId: json['campaignZoneId'],
      campaignZoneName: json['campaignZoneName'],
      farms: List<String>.from(json['farms']),
    );
  }

  static SearchJoinCampaign fromJsonModel(Map<String, dynamic> json) =>
      SearchJoinCampaign.fromJson(json);
}
