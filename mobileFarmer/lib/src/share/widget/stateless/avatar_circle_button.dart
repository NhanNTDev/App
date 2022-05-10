import 'package:flutter/material.dart';

class AvatarCircleButton extends StatelessWidget {
  final void Function()? onPressed;
  final double height;
  final double width;
  final Widget component;

  const AvatarCircleButton(
      {Key? key,
      required this.onPressed,
      required this.height,
      required this.width,
      required this.component})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: const BorderSide(
                      color: Colors.transparent, width: 1.0)))),
      onPressed: onPressed,
      child: SizedBox(
        height: height,
        width: width,
        child: component,
      ),
    );
  }
}
