import 'package:delivery_driver_application/src/feature/model/shipping_order.dart';
import 'package:delivery_driver_application/src/share/constants/converts.dart';
import 'package:delivery_driver_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ShippingCancelTaskCard extends StatelessWidget {
  final DeliveryShipping shippingOrder;
  // final Widget farmOrder;

  const ShippingCancelTaskCard(
      {Key? key, required this.shippingOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          // height: 500,
          width: 350,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.5))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // height: 60,
                    width: 110,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    // margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromRGBO(213, 249, 225, 1.0)),
                    alignment: Alignment.center,
                    child: Text('Giao hàng',
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w400,
                            // fontSize: 15.sp,
                            fontSize: 12.sp,
                            color: Color.fromRGBO(0, 171, 86, 1.0))),
                  ),
                  Spacer(),
                  Container(
                    // height: 60,
                    // width: 140,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    // margin: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    child: Text(shippingOrder.deliveryCode,
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w400,
                            // fontSize: 15.sp,
                            fontSize: 11.sp,
                            color: Colors.grey)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconWidget(
                        icon: Iconsax.note_1,
                        color: Color.fromRGBO(26, 148, 255, 1.0),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 296,
                      child: Text(shippingOrder.totalWeight.toString(),
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                              // fontSize: 15.sp,
                              fontSize: 14.sp,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.black.withOpacity(0.5),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconWidget(
                        icon: Iconsax.user,
                        color: Colors.redAccent,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      // width: 296,
                      child: Text('Khách hàng:',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp,
                              fontSize: 12.sp,
                              color: Colors.black)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      // width: 296,
                      child: Text(shippingOrder.totalWeight.toString(),
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp,
                              fontSize: 12.sp,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconWidget(
                        icon: Iconsax.call_calling,
                        color: Colors.redAccent,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      // width: 296,
                      child: Text('Số điện thoại:',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp,
                              fontSize: 12.sp,
                              color: Colors.black)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      // width: 296,
                      child: Text(shippingOrder.totalWeight.toString(),
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp,
                              fontSize: 12.sp,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconWidget(
                        icon: Iconsax.location,
                        color: Colors.redAccent,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      // width: 296,
                      child: Text('Địa chỉ:',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp,
                              fontSize: 12.sp,
                              color: Colors.black)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 236,
                      child: Text(shippingOrder.totalWeight.toString(),
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp,
                              fontSize: 12.sp,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconWidget(
                        icon: Iconsax.task,
                        color: Colors.grey,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      // width: 296,
                      child: Text('Danh sách sản phẩm:',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp,
                              fontSize: 13.sp,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 15,
              // ),
              // farmOrder
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
              //   child: ListView.builder(
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true,
              //     physics: BouncingScrollPhysics(),
              //     itemCount: shippingOrder.addresses.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return _buildPlayerModelList(
              //           shippingOrder.addresses[index]);
              //     },
              //   ),
              // ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('Phí vận chuyển',
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          // fontSize: 15.sp,
                          fontSize: 12.sp,
                          color: Colors.black)),
                  Spacer(),
                  Text(shippingOrder.totalWeight.toString(),
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          // fontSize: 15.sp,
                          fontSize: 12.sp,
                          color: Colors.black)),

                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('Tổng',
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w600,
                          // fontSize: 15.sp,
                          fontSize: 14.sp,
                          color: Colors.black)),
                  Spacer(),
                  Text(shippingOrder.totalWeight.toString() + " đ",
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          // fontSize: 15.sp,
                          fontSize: 13.sp,
                          color: Colors.black)),

                ],
              ),
              SizedBox(height: 10,),
              Container(
                // width: 296,
                  alignment: Alignment.centerRight,

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        child: Text('Lí do:  ${shippingOrder.deliveryCode}',
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w400,
                                // fontSize: 15.sp,
                                fontSize: 11.sp,
                                color: Colors.grey)),
                      ),
                      Spacer(),
                      Text('Đã hủy',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                              // fontSize: 15.sp,
                              fontSize: 13.sp,
                              color: Colors.redAccent))
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerModelList(FarmOrder items) {
    // print(items.id);
    return Card(
      child: ExpansionTile(
        title: Row(
          children: [
            // Text('Đơn hàng: ',
            //     style: TextStyle(
            //         fontFamily: 'BeVietnamPro',
            //         fontWeight: FontWeight.w400,
            //         // fontSize: 15.sp,
            //         fontSize: 12.sp,
            //         color: Color.fromRGBO(204, 129, 0, 1.0))),
            Text(items.code.toString(),
                style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.w500,
                    // fontSize: 15.sp,
                    fontSize: 12.sp,
                    color: Colors.black)),
            // Container(width:35,child: TextButton(onPressed: (){}, child: IconWidget(icon: Iconsax.tick_circle,color: Colors.green,fontSize: 16.sp,fontWeight: FontWeight.w600,))),
            // Container(width:35,child: TextButton(onPressed: (){}, child: IconWidget(icon: Iconsax.close_circle,color: Colors.redAccent,fontSize: 16.sp,fontWeight: FontWeight.w600,))),
          ],
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: items.productHarvestOrders.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Text(items.productHarvestOrders[index].productName,
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w400,
                            // fontSize: 15.sp,
                            fontSize: 11.sp,
                            color: Colors.black.withOpacity(0.9))),
                    Text('(x' + items.productHarvestOrders[index].quantity.toString() + " " + items.productHarvestOrders[index].unit + ")",
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w400,
                            // fontSize: 15.sp,
                            fontSize: 11.sp,
                            color: Colors.black.withOpacity(0.9))),
                    Spacer(),
                    Text((items.productHarvestOrders[index].price * items.productHarvestOrders[index].quantity).toString() + "vnđ",
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w400,
                            // fontSize: 15.sp,
                            fontSize: 11.sp,
                            color: Colors.black.withOpacity(0.9))),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 15,)
        ],
      ),
    );
  }
}
