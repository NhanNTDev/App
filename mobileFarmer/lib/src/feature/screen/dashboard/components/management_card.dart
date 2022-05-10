import 'package:farmer_application/src/share/data/management_list.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManagementCard extends StatelessWidget {
  final ManagementCardModel model;
  final void Function()? onPressed;

  const ManagementCard({Key? key, required this.model, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 63,
          width: 63,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(4, 4), //hanges position of shadow
                ),
              ]),
          child: TextButton(
            onPressed: onPressed,
            child: IconWidget(
              icon: model.icon,
              color: const Color.fromRGBO(95, 212, 144, 1.0),
              fontWeight: FontWeight.w500,
              fontSize: 23.sp,
            ),
          ),
        ),
        const SizedBox(height: 10,),
        SizedBox(
          width: _size.width * 0.25,
          child: Text(model.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                  fontSize: 11.sp, color: Colors.grey.withOpacity(0.8))),
        ),
      ],
    );
  }
}
