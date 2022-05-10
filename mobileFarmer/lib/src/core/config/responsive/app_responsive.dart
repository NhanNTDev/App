import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeInfo) {
      if (sizeInfo.deviceScreenType == DeviceScreenType.desktop) {
        return desktop;
      } else if (sizeInfo.deviceScreenType == DeviceScreenType.tablet) {
        return tablet;
      } else if (sizeInfo.deviceScreenType == DeviceScreenType.mobile) {
        return mobile;
      }
      return const Center(
        child: Text("UI's support for this size!!!"),
      );
    });
  }
}
