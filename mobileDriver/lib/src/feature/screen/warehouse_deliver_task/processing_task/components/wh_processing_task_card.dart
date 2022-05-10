import 'dart:developer';

import 'package:delivery_driver_application/src/feature/model/collect_order.dart';
import 'package:delivery_driver_application/src/feature/model/warehouse_deliver_order.dart';
import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
import 'package:delivery_driver_application/src/share/constants/converts.dart';
import 'package:delivery_driver_application/src/share/widget/stateless/icon_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timelines/timelines.dart';

class WhProcessingTaskCard extends StatelessWidget {
  final WarehouseDeliverOrder warehouseDeliverOrder;
  final void Function()? onAccept;
  final void Function()? onCancel;
  // final Widget farmOrder;

  const WhProcessingTaskCard(
      {Key? key, required this.warehouseDeliverOrder, required this.onAccept, required this.onCancel})
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
                        color: Color.fromRGBO(105, 219, 255, 1.0)),
                    alignment: Alignment.center,
                    child: Text('Luân chuyển',
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w400,
                            // fontSize: 15.sp,
                            fontSize: 11.sp,
                            color: Colors.white)),
                  ),
                  Spacer(),
                  Container(
                    // height: 60,
                    // width: 140,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    // margin: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    child: Text(convertFormatDate(DateTime.parse(warehouseDeliverOrder.createAt)),
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
                      width: 295,
                      child: Text(warehouseDeliverOrder.code,
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
                        icon: Iconsax.car,
                        color: Colors.redAccent,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      // width: 296,
                      child: Text('Xuất phát từ:',
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
                      child: Text(warehouseDeliverOrder.warehouseFrom,
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
              SizedBox(height: 5,),
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
                      width: 296,
                      child: Text(warehouseDeliverOrder.from,
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w400,
                              // fontSize: 15.sp,
                              fontSize: 11.sp,
                              color: Colors.grey)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              SizedBox(height: 10,),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconWidget(
                        icon: Iconsax.weight,
                        color: Colors.grey,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      // width: 296,
                      child: Text('Tổng khối lượng:',
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
                      child: Text(warehouseDeliverOrder.totalWeight.toString() + " Kg",
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
                      child: Text('Danh sách các điểm đến:',
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
              SizedBox(
                height: 15,
              ),
              // farmOrder
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: warehouseDeliverOrder.shipmentDestinations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      // width: 500,
                      child: Row(
                        children: [
                          Container( height: 100.0, child: TimelineNode.simple(color: Color.fromRGBO(255, 174, 79, 1.0),)),
                          SizedBox(width: 10,),
                          Container(
                            // height: 70.0,
                            width: 292,
                            child: Column(
                              children: [
                                _buildPlayerModelList(
                                    warehouseDeliverOrder.shipmentDestinations[index], index)
                              ],
                            ),
                          )

                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: TextButton(onPressed: onAccept, child: Text('Xác nhận hoàn thành',style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w500,
                        // fontSize: 15.sp,
                        fontSize: 13.sp,
                      color: Colors.white
                    ))),
                  )

                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerModelList(ShipmentDestination items, int index) {
    // print(items.id);
    return Card(
      child: ExpansionTile(
        title: Column(
          children: [
            Row(
              children: [
                IconWidget(
                    icon: Iconsax.car,
                    color: Colors.redAccent,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600),
                SizedBox(
                  width: 5,
                ),
                Container(
                  // width: 296,
                  child: Text('Điểm đến ${index + 1}:',
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
                  child: Text(items.warehouseTo,
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          // fontSize: 15.sp,
                          fontSize: 12.sp,
                          color: Colors.black)),
                ),

                // Text(items.address.toString(),
                //     style: TextStyle(
                //         fontFamily: 'BeVietnamPro',
                //         fontWeight: FontWeight.w500,
                //         // fontSize: 15.sp,
                //         fontSize: 12.sp,
                //         color: Colors.black)),
                // Container(width:35,child: TextButton(onPressed: (){}, child: IconWidget(icon: Iconsax.tick_circle,color: Colors.green,fontSize: 16.sp,fontWeight: FontWeight.w600,))),
                // Container(width:35,child: TextButton(onPressed: (){}, child: IconWidget(icon: Iconsax.close_circle,color: Colors.redAccent,fontSize: 16.sp,fontWeight: FontWeight.w600,))),
              ],
            ),
            SizedBox(height: 5,),
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
                    width: 190,
                    child: Text(items.address,
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w400,
                            // fontSize: 15.sp,
                            fontSize: 11.sp,
                            color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ],
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Danh sách đơn hàng',
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: Colors.black)),
                    // Text(items.id.toString(),
                    //     style: TextStyle(
                    //         fontFamily: 'BeVietnamPro',
                    //         fontWeight: FontWeight.w500,
                    //         // fontSize: 15.sp,
                    //         fontSize: 12.sp,
                    //         color: Colors.grey))
                    // _getListOrders(items.orders[1])
                  ],
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: items.orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: Text("- " + items.orders[index].code,  style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500,
                            // fontSize: 15.sp,
                            fontSize: 11.sp,
                            color: Colors.grey)),
                      );
                    },
                  ),
                ),
              ],
            )
          ),
          SizedBox(height: 15,)
        ],
      ),
    );
  }
}
