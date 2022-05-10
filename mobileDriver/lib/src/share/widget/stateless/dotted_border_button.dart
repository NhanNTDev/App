import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'icon_widget.dart';

class DottedBorderButton extends StatelessWidget{
  final void Function()? onPressed;
  final Color color;
  const DottedBorderButton({Key? key, required this.onPressed, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: TextButton(
        onPressed: onPressed,
        child: DottedBorder(
          color: color,
          strokeWidth: 2,
          radius: const Radius.circular(10),
          dashPattern: const [10, 5],
          customPath: (size) {
            return Path()
              ..moveTo(10, 0)
              ..lineTo(size.width - 10, 0)
              ..arcToPoint(Offset(size.width, 10),
                  radius: const Radius.circular(10))
              ..lineTo(size.width, size.height - 10)
              ..arcToPoint(Offset(size.width - 10, size.height),
                  radius: const Radius.circular(10))
              ..lineTo(10, size.height)
              ..arcToPoint(Offset(0, size.height - 10),
                  radius: const Radius.circular(10))
              ..lineTo(0, 10)
              ..arcToPoint(const Offset(10, 0),
                  radius: const Radius.circular(10));
          },
          child: Container(
            alignment: Alignment.center,
            child: IconWidget(
                icon: Iconsax.add,
                color: color,
                fontSize: 30,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

}