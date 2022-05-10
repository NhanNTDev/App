import 'package:delivery_driver_application/src/feature/model/collect_order.dart';
import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
import 'package:delivery_driver_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timelines/timelines.dart';



class CompleteTaskCard extends StatefulWidget{
  final CollectDestination collectOrder;

  const CompleteTaskCard({Key? key, required this.collectOrder}) : super(key: key);

  @override
  _CompleteTaskCardState createState() => _CompleteTaskCardState();
}

String processing = 'Đang bàn giao cho bên vận chuyển';
String completed = 'Đã bàn giao cho bên vận chuyển';
String canceled = 'Đã hủy';

class _CompleteTaskCardState extends State<CompleteTaskCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          // height: 500,
          width: 350,
          padding: EdgeInsets.all(10),
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
                        color: kBlueDefault),
                    alignment: Alignment.center,
                    child: Text('Thu hàng',
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w400,
                            // fontSize: 15.sp,
                            fontSize: 12.sp,
                            color: Colors.white)),
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
                      child: Text(widget.collectOrder.collectionCode.toString(),
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
                      child: Text('Danh sách các nông trại cần tới: ',
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
                  itemCount: widget.collectOrder.farms.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      // width: 500,
                      child: Row(
                        children: [
                          Container(
                              height: 140.0, child: TimelineNode.simple(color: Color.fromRGBO(255, 174, 79, 1.0),)),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            // height: 70.0,
                            width: 292,
                            child: Column(
                              children: [
                                _buildPlayerModelList(
                                    widget.collectOrder.farms[index], index)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Spacer(),
                  Text('Đã thu hàng', style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w500,
                  // fontSize: 15.sp,
                  fontSize: 13.sp,
                  color: Colors.green))
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerModelList(Farm items, int index) {
    // print(items.id);
    return Container(
      child: Card(
        child: ExpansionTile(
          title: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconWidget(
                      icon: Iconsax.building_3,
                      color: Colors.redAccent,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    // width: 90,
                    // child: Text('Điểm đến ${index + 1}:',
                    child: Text('Điểm đến:',
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
                    width: 113,
                    child: Text(items.name,
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
              SizedBox(
                height: 5,
              ),
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
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconWidget(
                        icon: Iconsax.call,
                        color: Colors.redAccent,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 190,
                      child: Text(items.phone,
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
            SizedBox(height: 10,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: items.farmOrders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ExpansionTile(
                              title: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 3),
                                    alignment: Alignment.centerLeft,
                                    child: Text(items.farmOrders[index].code,
                                        style: TextStyle(
                                            fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.w500,
                                            // fontSize: 15.sp,
                                            fontSize: 11.sp,
                                            color: Colors.black)),
                                  ),
                                  Spacer(),
                                  if(items.farmOrders[index].status == completed)
                                    ...[
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 3),
                                        alignment: Alignment.centerLeft,
                                        child: IconWidget(icon: Iconsax.tick_circle, color: Colors.green,fontSize: 16.sp, fontWeight: FontWeight.w600),
                                      )
                                    ]
                                  else if(items.farmOrders[index].status == canceled)
                                    ...[
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 3),
                                        alignment: Alignment.centerLeft,
                                        child: IconWidget(icon: Iconsax.close_circle, color: Colors.redAccent,fontSize: 16.sp, fontWeight: FontWeight.w600),
                                      )
                                    ]
                                  else
                                    ...[
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 3),
                                        alignment: Alignment.centerLeft,
                                        child: IconWidget(icon: Iconsax.bucket_circle, color: Colors.amber,fontSize: 16.sp, fontWeight: FontWeight.w600),
                                      )
                                    ]
                                ],
                              ),
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: items.farmOrders[index]
                                        .productHarvestOrders.length,
                                    itemBuilder:
                                        (BuildContext context, int index1) {
                                      if(index1 == items.farmOrders[index].productHarvestOrders.length -1){
                                        return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 5),
                                            child: Column(
                                              children: [

                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 190,
                                                      child: Text(
                                                          "- " +
                                                              items
                                                                  .farmOrders[index]
                                                                  .productHarvestOrders[
                                                              index1]
                                                                  .productName,
                                                          style: TextStyle(
                                                              fontFamily:
                                                              'BeVietnamPro',
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              // fontSize: 15.sp,
                                                              fontSize: 11.sp,
                                                              color: Colors.black)),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                        "x${items.farmOrders[index].productHarvestOrders[index1].quantity} ${items.farmOrders[index].productHarvestOrders[index1].unit}",
                                                        style: TextStyle(
                                                            fontFamily:
                                                            'BeVietnamPro',
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            // fontSize: 15.sp,
                                                            fontSize: 11.sp,
                                                            color: Colors.black)),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                items
                                                    .farmOrders[index].status == "Đã hủy" ? Container(
                                                  padding: EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 180,
                                                        child: Text(
                                                            "Lí do: ${items.farmOrders[index].note}",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'BeVietnamPro',
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                // fontSize: 15.sp,
                                                                fontSize: 11.sp,
                                                                color: Colors.grey)),
                                                      ),
                                                      // Spacer(),
                                                      // Text(
                                                      //     "Đã hủy",
                                                      //     style: TextStyle(
                                                      //         fontFamily:
                                                      //         'BeVietnamPro',
                                                      //         fontWeight:
                                                      //         FontWeight.w500,
                                                      //         // fontSize: 15.sp,
                                                      //         fontSize: 13.sp,
                                                      //         color: Colors.redAccent)),
                                                    ],
                                                  ),
                                                ) : Container(),
                                              ],
                                            ));
                                      }
                                      return Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 5),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 190,
                                                    child: Text(
                                                        "- " +
                                                            items
                                                                .farmOrders[index]
                                                                .productHarvestOrders[
                                                            index1]
                                                                .productName,
                                                        style: TextStyle(
                                                            fontFamily:
                                                            'BeVietnamPro',
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            // fontSize: 15.sp,
                                                            fontSize: 11.sp,
                                                            color: Colors.black)),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                      "x${items.farmOrders[index].productHarvestOrders[index1].quantity} ${items.farmOrders[index].productHarvestOrders[index1].unit}",
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'BeVietnamPro',
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          // fontSize: 15.sp,
                                                          fontSize: 11.sp,
                                                          color: Colors.black)),
                                                ],
                                              )
                                            ],
                                          ));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
