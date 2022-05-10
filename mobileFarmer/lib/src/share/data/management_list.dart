import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ManagementCardModel {
  final IconData icon;
  final String title;
  final Color color;

  ManagementCardModel({required this.icon, required this.title, required this.color});
}

final List<ManagementCardModel> listManagementButton = [
  ManagementCardModel(
      icon: Iconsax.building_3,
      title: "Nông trại",
      color: Color.fromRGBO(255, 138, 138, 1.0)),
  // ManagementCardModel(
  //     icon: Iconsax.box,
  //     title: "Sản phẩm",
  //     color: Color.fromRGBO(253, 189, 94, 1.0)),
  ManagementCardModel(
      icon: Iconsax.sun_1,
      title: "Mùa vụ",
      color: Color.fromRGBO(202, 231, 24, 1.0)),
  ManagementCardModel(
      icon: Iconsax.note_1,
      title: "Đơn hàng",
      color: Color.fromRGBO(106, 224, 118, 1.0)),
  ManagementCardModel(
      icon: Iconsax.profile_2user,
      title: "Khách hàng",
      color: Color.fromRGBO(10, 181, 99, 0.5)),
  ManagementCardModel(
      icon: Iconsax.status_up,
      title: "Doanh thu",
      color: Color.fromRGBO(224, 198, 106, 1.0)),
  ManagementCardModel(
      icon: Iconsax.activity,
      title: "Chiến dịch của tôi",
      color: Color.fromRGBO(92, 145, 224, 1.0))
];

final List<ManagementCardModel> listCampaignManagementButton = [
  ManagementCardModel(
      icon: Iconsax.activity,
      title: "Tham gia chiến dịch",
      color: Color.fromRGBO(92, 145, 224, 1.0))
];
