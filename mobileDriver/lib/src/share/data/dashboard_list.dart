import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DashboardCardModel {
  final Color color;
  final IconData icon;
  final String title;
  final int number;

  final String subtitle;

  const DashboardCardModel(
      {required this.color,
      required this.icon,
      required this.title,
      required this.number,
      required this.subtitle});
}

List<DashboardCardModel> dashboardList = [
  const DashboardCardModel(
      color: Color.fromRGBO(198, 230, 255, 1.0),
      icon: Iconsax.building_3,
      title: 'Nông trại',
      number: 04,
      subtitle: 'Đang sở hữu'),
  const DashboardCardModel(
      color: Color.fromRGBO(255, 218, 218, 1.0),
      icon: Iconsax.sun_1,
      title: 'Mùa vụ',
      number: 86,
      subtitle: 'Đang có'),
  const DashboardCardModel(
      color: Color.fromRGBO(253, 226, 156, 1.0),
      icon: Iconsax.note_1,
      title: 'Đơn hàng',
      number: 143,
      subtitle: 'Chưa xử lí'),
  const DashboardCardModel(
      color: Color.fromRGBO(181, 245, 117, 1.0),
      icon: Iconsax.user,
      title: 'Khách hàng',
      number: 1200,
      subtitle: 'Người'),
];
