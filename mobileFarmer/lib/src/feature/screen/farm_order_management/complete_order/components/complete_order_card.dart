import 'package:farmer_application/src/feature/model/farm.dart';
import 'package:farmer_application/src/feature/model/farm_order.dart';
import 'package:farmer_application/src/share/constants/converts.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CompleteOrderCard extends StatelessWidget {
  final FarmOrder farmOrder;
  final void Function()? onPressed;

  const CompleteOrderCard(
      {Key? key, required this.farmOrder, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return TextButton(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            // height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: Colors.grey.withOpacity(0.6), width: 1)),
            child: Column(
              children: [
                // const SizedBox(height: 5,),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                  child: Row(
                    children: [
                      Text('Mã đơn hàng: ' + farmOrder.code,
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: Colors.black)),
                      // Spacer(),
                      // Text('15: 26 27/2/2022',
                      //     style: TextStyle(
                      //         fontFamily: 'BeVietnamPro',
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 12.sp,
                      //         color: Colors.black)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                      convertFormatHour(DateTime.parse(farmOrder.createAt)) +
                          ' ' +
                          convertFormatDate(DateTime.parse(farmOrder.createAt)),
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                          color: Colors.grey)),
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.6),
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.green,
                        size: 16.sp,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(farmOrder.status,
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: Colors.black)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text('Khách hàng: ' + farmOrder.customerName,
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                              color: Colors.black.withOpacity(0.8))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text('Đặt hàng tại: ' + farmOrder.farmName,
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                              color: Colors.black.withOpacity(0.8))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Chiến dịch: ',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                              color: Colors.black.withOpacity(0.8))),
                      Container(
                        width: 255,
                        child: Text(farmOrder.campaignName,
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color: Colors.black.withOpacity(0.8))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Trạng thái: ',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                              color: Colors.black.withOpacity(0.8))),
                      Container(
                        width: 255,
                        child: Text(farmOrder.paymentStatus,
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color: Colors.black.withOpacity(0.8))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hình thức thanh toán: ',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                              color: Colors.black.withOpacity(0.8))),
                      Text(farmOrder.paymentTypeName,
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                              color: Colors.black.withOpacity(0.8))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Đánh giá từ khách hàng: ',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                              color: Colors.black.withOpacity(0.8))),
                      farmOrder.feedBackCreateAt != '' ? Text('Đã đánh giá',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                              color: Colors.black.withOpacity(0.8))) : Text('Chưa đánh giá',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                              color: Colors.black.withOpacity(0.8))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Spacer(),
                      Text('Xem chi tiết',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              fontSize: 12.sp,
                              color: Color.fromRGBO(95, 212, 144, 1.0))),
                      IconWidget(
                          icon: Iconsax.arrow_right_1,
                          color: Color.fromRGBO(95, 212, 144, 1.0),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      onPressed: onPressed,
    );
  }
}
