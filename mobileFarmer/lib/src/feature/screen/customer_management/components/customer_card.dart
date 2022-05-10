import 'package:farmer_application/src/feature/model/customer.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomerCard extends StatelessWidget {
  final Customer customer;

  const CustomerCard({Key? key, required this.customer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(customer.image, width: 50, height: 50, fit: BoxFit.fitHeight,),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        customer.name,
                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                            fontSize: 14.sp, color: Color.fromRGBO(61, 55, 55, 1.0)),),
                    ),
                    customer.gender == "Nam" ? IconWidget(icon: Icons.male, color: Colors.blueAccent,
                        fontSize: 14.sp, fontWeight: FontWeight.w600): IconWidget(icon: Icons.female,
                        color: Colors.pink, fontSize: 14.sp, fontWeight: FontWeight.w600)
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      customer.phone,
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                          color: Colors.grey),
                    )),
                SizedBox(
                  height: 4,
                ),
                Container(
                  width: 300,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      customer.address,
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                          color: Colors.grey),
                    )),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Container(
                        // width: 300,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tổng số đơn hàng đã mua: ',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: Colors.black),
                        )),
                    Container(
                        // width: 300,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          customer.countFarmOrders.toString(),
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: Colors.black),
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
