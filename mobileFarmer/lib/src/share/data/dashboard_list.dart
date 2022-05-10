import 'package:flutter/material.dart';

class DashboardCardModel {
  final Color color;
  final IconData icon;
  final String title;
  num? number;

  final String subtitle;

  DashboardCardModel(
      {required this.color,
      required this.icon,
      required this.title,
      this.number,
      required this.subtitle});
}


