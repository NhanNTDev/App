import 'package:farmer_application/src/feature/model/harvest.dart';
import 'package:farmer_application/src/share/constants/converts.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class HarvestCard extends StatelessWidget {
  final Harvest harvest;
  final void Function()? onPressed;

  const HarvestCard({Key? key, required this.harvest, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width,
      child: TextButton(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(harvest.image1, width: 95, height: 120, fit: BoxFit.fitHeight,),
            ),
            SizedBox(width: 12,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 247,
                  child: Text(harvest.name, style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w700,
                        fontSize: 13.sp, color: Color.fromRGBO(61, 55, 55, 1.0)),),
                ),
                SizedBox(height: 6,),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(color: Color.fromRGBO(95, 212, 144, 1.0), borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        harvest.productName, style: TextStyle(
                            fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                            fontSize: 9.sp, color: Color.fromRGBO(255, 255, 255, 1.0)),),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(color: Color.fromRGBO(95, 212, 144, 1.0), borderRadius: BorderRadius.circular(4)),
                      child: Text(harvest.categoryName,
                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                            fontSize: 9.sp, color: Color.fromRGBO(255, 255, 255, 1.0)),),
                    ),
                  ],
                ),
                SizedBox(height: 6,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text('Ngày bắt đầu mùa vụ: ',
                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                            fontSize: 11.sp, color: Color.fromRGBO(61, 55, 55, 0.7)),),
                      SizedBox(width: 4,),
                      Text(convertFormatDate(DateTime.parse(harvest.startAt)),
                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                            fontSize: 10.sp, color: Colors.black),)
                    ],
                  ),
                ),
                SizedBox(height: 2,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text('Ngày thu hoạch dự kiến: ',
                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                            fontSize: 11.sp, color: Color.fromRGBO(61, 55, 55, 0.7)),),
                      SizedBox(width: 4,),
                      Text(convertFormatDate(DateTime.parse(harvest.estimatedTime)),
                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                            fontSize: 10.sp, color: Colors.black),)
                    ],
                  ),),
                SizedBox(height: 3,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconWidget(icon: Iconsax.house_2, color: Colors.grey,
                          fontSize: 12.sp, fontWeight: FontWeight.w600),
                      SizedBox(width: 4,),
                      Container(
                        width: 228,
                        child: Text(harvest.farmName, style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 11.sp, color: Colors.black),
                        ),
                      )
                    ],
                  ),),
                SizedBox(height: 4,),
                harvest.inventoryTotal > 0 ? Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Đang mở bán', style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 11.sp, color: Color.fromRGBO(95, 212, 144, 1.0)),)) : Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Đã hết hàng',
                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 11.sp, color: Colors.redAccent),)),
              ],
            )
          ],
        ), onPressed: onPressed,
      ),
    );
  }
}
