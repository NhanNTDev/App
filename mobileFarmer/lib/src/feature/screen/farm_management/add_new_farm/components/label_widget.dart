import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget titleLabel(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        Text(label,
            style: TextStyle(
                fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                fontSize: 11.sp, color: Color.fromRGBO(107, 114, 128, 1.0))),
        Text(':',
            style: TextStyle(
                fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                fontSize: 12.sp, color: Colors.black.withOpacity(0.5))),
      ],
    ),
  );
}

Widget titleLabelRequired(
    String label, IconData icon, Color iconColor, bool isRequired, bool limit) {
  return Container(
    padding: EdgeInsets.only(left: kPaddingDefault * 2),
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        IconWidget(icon: icon, color: iconColor, fontSize: 15.sp, fontWeight: FontWeight.w700),
        SizedBox(width: 5,),
        Text(label,
            style: TextStyle(
                fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                fontSize: 12.sp, color: Color.fromRGBO(61, 55, 55, 1.0))),
        limit ? Text(' (Tối đa 5 ảnh) ',
                style: TextStyle(
                    fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                    fontSize: 11.sp, color: Colors.black.withOpacity(0.7))) : Container(),
        isRequired ? Container() : const SizedBox(width: 5,),
        isRequired ? Container() : Text('(Không bắt buộc) ',
                style: TextStyle(
                    fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                    fontSize: 11.sp, color: Colors.black.withOpacity(0.7))),
        isRequired ? Text('*',
                style: TextStyle(
                    fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                    fontSize: 15.sp, color: Colors.redAccent)) : Container(),
        Text(':',
            style: TextStyle(
                fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                fontSize: 12.sp, color: Colors.black.withOpacity(0.5))),
      ],
    ),
  );
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
