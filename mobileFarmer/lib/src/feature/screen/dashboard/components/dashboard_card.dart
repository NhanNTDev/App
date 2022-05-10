import 'package:farmer_application/src/share/data/dashboard_list.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class DashboardCard extends StatelessWidget {
  final DashboardCardModel model;

  const DashboardCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return SizedBox(
      width: 135,
      child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0),),
          child: Container(
            width: _size.width * 0.32,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(23),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 1,
                    blurRadius: 5, offset: const Offset(3, 3), // changes position of shadow
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 15, left: 15, top: _size.height * 0.016),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: _size.height * 0.05,
                        height: _size.height * 0.05,
                        decoration: BoxDecoration(color: model.color, borderRadius: BorderRadius.circular(10)),
                        child: IconWidget(color: Colors.black, icon: model.icon,
                          fontWeight: FontWeight.w500, fontSize: 16.sp,
                        ),
                      ),
                      const Spacer(),
                      IconWidget(icon: Iconsax.arrow_right_34, color: Colors.black,
                          fontSize: 15.sp, fontWeight: FontWeight.w700)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: _size.height * 0.02),
                  child: Text(model.title,
                      style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                          fontSize: 12.sp, color: Colors.black)),
                ),
                const Spacer(),
                Text(model.number.toString(),
                    style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                        fontSize: 18.sp, color: Colors.black)),
                const Spacer(),
                Container(
                  width: _size.width * 0.3,
                  padding: EdgeInsets.only(bottom: _size.height * 0.016),
                  child: Text(model.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                        color: Colors.grey, fontSize: 10.sp,
                      )),
                )
              ],
            ),
            alignment: Alignment.center,
          )),
    );
  }
}
