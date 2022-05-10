import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const IconWidget(
      {Key? key,
      required this.icon,
      required this.color,
      required this.fontSize,
      required this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      String.fromCharCode(icon.codePoint),
      style: TextStyle(
        inherit: false,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
      ),
    );
  }
}
