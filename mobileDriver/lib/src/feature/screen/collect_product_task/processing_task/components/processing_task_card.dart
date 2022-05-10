import 'package:delivery_driver_application/src/feature/model/collect_order.dart';
import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
import 'package:delivery_driver_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timelines/timelines.dart';

import '../../../../../share/constants/app_uidata.dart';
import '../../../../repository/collect_order_repository.dart';
import '../../collect_product_task_screen.dart';

class ProcessingTaskCard extends StatefulWidget{
  final CollectDestination collectOrder;
  final void Function()? onAccept;
  final void Function()? onCancel;

  const ProcessingTaskCard({Key? key, required this.collectOrder, this.onCancel, this.onAccept}) : super(key: key);

  @override
  _ProcessingTaskCardState createState() => _ProcessingTaskCardState();
}


String processing = 'Đang bàn giao cho bên vận chuyển';
String completed = 'Đã bàn giao cho bên vận chuyển';
String canceled = 'Đã hủy';

class _ProcessingTaskCardState extends State<ProcessingTaskCard> {
  final _formKey = GlobalKey<FormState>();
  int statusCode = 0;
  bool isPress = false;
  String cancelReason = '';
  bool isLoading = false;
  bool lastProcessFarmOrder = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    statusCode = 0;
    isPress = false;
    cancelReason = '';
    isLoading = false;
    super.dispose();
  }

  final collectOrderRepository = CollectOrderRepository();

  Future<dynamic> updateStatus(int farmOrderId, int status, FarmOrder farmOrder) async {
    statusCode =
    await collectOrderRepository.updateStatusFarmOrder(farmOrderId, status);
    setState(() {
      if (statusCode == 200) {
        isLoading = false;
        UIData.toastMessage("Cập nhật thành công");
        farmOrder.status = 'Đã bàn giao cho bên vận chuyển';
        Navigator.pop(context, 'ON');
        // Navigator.pop(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //       const CollectProductTaskScreen(initPage: 0)),
        // );
      } else {
        isLoading = false;
        UIData.toastMessage("Cập nhật thất bại");
      }
    });
  }

  Future<dynamic> cancelFarmOrder(int farmOrderId, String note, FarmOrder farmOrder) async {
    statusCode =
    await collectOrderRepository.cancelFarmOrder(farmOrderId, note);
    setState(() {
      if (statusCode == 200) {
        isLoading = false;
        UIData.toastMessage("Cập nhật thành công");
        farmOrder.status = 'Đã hủy';
        farmOrder.note = cancelReason;
        Navigator.pop(
                context, 'ON');
        // Navigator.pop(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //       const CollectProductTaskScreen(initPage: 0)),
        // );
      } else {
        isLoading = false;
        UIData.toastMessage("Cập nhật thất bại");
      }
    });
  }

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
                  // Spacer(),
                  // Container(
                  //   // height: 60,
                  //   // width: 140,
                  //   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  //   // margin: EdgeInsets.symmetric(horizontal: 10),
                  //   alignment: Alignment.center,
                  //   // child: Text(convertFormatDate(DateTime.parse(warehouseDeliverOrder.createAt)),
                  //   child: Text('hello',
                  //       style: TextStyle(
                  //           fontFamily: 'BeVietnamPro',
                  //           fontWeight: FontWeight.w400,
                  //           // fontSize: 15.sp,
                  //           fontSize: 11.sp,
                  //           color: Colors.grey)),
                  // ),
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
              // Container(
              //   alignment: Alignment.centerLeft,
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       IconWidget(
              //           icon: Iconsax.car,
              //           color: Colors.redAccent,
              //           fontSize: 13.sp,
              //           fontWeight: FontWeight.w600),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Container(
              //         // width: 296,
              //         child: Text('Xuất phát từ:',
              //             style: TextStyle(
              //                 fontFamily: 'BeVietnamPro',
              //                 fontWeight: FontWeight.w500,
              //                 // fontSize: 15.sp,
              //                 fontSize: 12.sp,
              //                 color: Colors.black)),
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Container(
              //         // width: 296,
              //         child: Text(collectOrder.totalWeight.toString(),
              //             style: TextStyle(
              //                 fontFamily: 'BeVietnamPro',
              //                 fontWeight: FontWeight.w500,
              //                 // fontSize: 15.sp,
              //                 fontSize: 12.sp,
              //                 color: Colors.black)),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 5,),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       IconWidget(
              //           icon: Iconsax.location,
              //           color: Colors.redAccent,
              //           fontSize: 13.sp,
              //           fontWeight: FontWeight.w600),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Container(
              //         width: 296,
              //         child: Text(collectOrder.totalWeight.toString(),
              //             style: TextStyle(
              //                 fontFamily: 'BeVietnamPro',
              //                 fontWeight: FontWeight.w400,
              //                 // fontSize: 15.sp,
              //                 fontSize: 11.sp,
              //                 color: Colors.grey)),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 5,),
              // SizedBox(height: 10,),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       IconWidget(
              //           icon: Iconsax.weight,
              //           color: Colors.grey,
              //           fontSize: 13.sp,
              //           fontWeight: FontWeight.w600),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Container(
              //         // width: 296,
              //         child: Text('Tổng khối lượng:',
              //             style: TextStyle(
              //                 fontFamily: 'BeVietnamPro',
              //                 fontWeight: FontWeight.w500,
              //                 // fontSize: 15.sp,
              //                 fontSize: 12.sp,
              //                 color: Colors.black)),
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Container(
              //         // width: 296,
              //         child: Text(collectOrder.totalWeight.toString() + " Kg",
              //             style: TextStyle(
              //                 fontFamily: 'BeVietnamPro',
              //                 fontWeight: FontWeight.w500,
              //                 // fontSize: 15.sp,
              //                 fontSize: 12.sp,
              //                 color: Colors.black)),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 15,),
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
              // Row(
              //   children: [
              //     Spacer(),
              //     Container(
              //       decoration: BoxDecoration(
              //           color: Colors.blue,
              //           borderRadius: BorderRadius.circular(8)
              //       ),
              //       child: TextButton(onPressed: onAccept, child: Text('Xác nhận hoàn thành',style: TextStyle(
              //           fontFamily: 'BeVietnamPro',
              //           fontWeight: FontWeight.w500,
              //           // fontSize: 15.sp,
              //           fontSize: 13.sp,
              //           color: Colors.white
              //       ))),
              //     )
              //
              //   ],
              // )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerModelList(Farm items, int index) {
    // print(items.id);
    return Card(
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
                  // width: 200,
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
                  width: 95,
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
                                    // IconWidget(
                                    if (index1 ==
                                        items.farmOrders[index]
                                                .productHarvestOrders.length -
                                            1) {
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
                                                                .farmOrders[
                                                                    index]
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
                                                            color:
                                                                Colors.black)),
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
                                              if(items.farmOrders[index].status == processing)
                                                ...[
                                                  // isLoading ? Padding(
                                                  //   padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                                                  //   child: Row(children: [Spacer(),Container(width: 20, height: 20,child: CircularProgressIndicator(color: kBlueDefault,))],),
                                                  // ) :
                                                  Row(
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    width: 35,
                                                    child: TextButton(
                                                        onPressed: (){
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext context) => StatefulBuilder(builder: (context, setState){
                                                              return AlertDialog(
                                                                title: const Text('Xác nhận'),
                                                                content: const Text('Bạn xác nhận đã thu đơn hàng này?'),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                    child: isLoading ? Container() :  Text('Không'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      // Navigator.pop(context, 'ON');
                                                                      setState(() {
                                                                        isLoading = true;
                                                                        updateStatus(items.farmOrders[index].id as int, 4,items.farmOrders[index]);
                                                                      });
                                                                    }, child: isLoading ? Container(width: 20, height: 20,child: CircularProgressIndicator(color: kBlueDefault,)): Text('Có'),
                                                                  ),
                                                                ],
                                                              );
                                                            }),
                                                          );

                                                        },
                                                        child: IconWidget(
                                                          icon: Iconsax
                                                              .tick_circle,
                                                          color: Colors.green,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
                                                  ),
                                                  Container(
                                                    width: 35,
                                                    child: TextButton(
                                                        onPressed: (){
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext context) => StatefulBuilder(builder: (context, setState){
                                                              return AlertDialog(
                                                                title: const Text('Xác nhận'),
                                                                content: SizedBox(
                                                                  height: 130,
                                                                  child: Form(
                                                                    key: _formKey,
                                                                    autovalidateMode: isPress
                                                                        ? AutovalidateMode.always
                                                                        : AutovalidateMode.disabled,
                                                                    child: Column(
                                                                      children: [
                                                                        Text('Bạn xác nhận hủy đơn hàng này?'),
                                                                        SizedBox(height: 10,),
                                                                        TextFormField(
                                                                          style: TextStyle(
                                                                              fontFamily: 'BeVietnamPro',
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 13.sp,
                                                                              color: Colors.black),
                                                                          textInputAction: TextInputAction.done,
                                                                          onChanged: (value){
                                                                            setState(() {
                                                                              cancelReason = value;
                                                                            });
                                                                          },
                                                                          decoration: InputDecoration(
                                                                            isDense: true,
                                                                            // contentPadding: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
                                                                            // labelText: "Resevior Name",
                                                                            fillColor: Colors.white,
                                                                            enabledBorder: OutlineInputBorder(
                                                                              borderSide:  BorderSide(
                                                                                  color: Colors.grey.withOpacity(0.4),
                                                                                  width: 1,
                                                                                  style: BorderStyle.solid),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                            border: OutlineInputBorder(
                                                                              borderSide: const BorderSide(color: Colors.orange, width: 1.0),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                            focusedBorder: OutlineInputBorder(
                                                                              borderSide:
                                                                              BorderSide(color: Colors.lightBlue.withOpacity(0.6), width: 2.5),
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                            // labelText: "Tên nông trại",
                                                                            // labelStyle: TextStyle(fontSize: 18),
                                                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                            // prefixIcon: prefixIcon,
                                                                            hintText: 'Nhập lí do hủy đơn',
                                                                            hintStyle: TextStyle(
                                                                                fontFamily: 'BeVietnamPro',
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 11.sp,
                                                                                color: Colors.grey),
                                                                          ),
                                                                          // The validator receives the text that the user has entered.
                                                                          autovalidateMode: AutovalidateMode.disabled,
                                                                          validator: (value){
                                                                            if(value!.trim().isEmpty){
                                                                              return 'Vui lòng điền vào chỗ này';
                                                                            }
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                    child: isLoading ? Container() : Text('Không'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        if (_formKey.currentState!
                                                                            .validate()) {
                                                                          // Navigator.pop(
                                                                          //     context, 'ON');
                                                                          isLoading = true;
                                                                          cancelFarmOrder(items.farmOrders[index].id as int, cancelReason, items.farmOrders[index]);
                                                                        }
                                                                      });
                                                                    }, child: isLoading ? Container(width: 20, height: 20,child: CircularProgressIndicator(color: kBlueDefault,)) : Text('Có'),
                                                                  ),
                                                                ],
                                                              );
                                                            }),
                                                          );
                                                        },
                                                        child: IconWidget(
                                                          icon: Iconsax
                                                              .close_circle,
                                                          color: Colors.redAccent,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                        )),
                                                  )
                                                ],
                                              )
                                                ]
                                              else if(items.farmOrders[index].status == completed)
                                                ...[Container(
                                                  padding: EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    children: [
                                                      Spacer(),
                                                      Text(
                                                          "Đã thu",
                                                          style: TextStyle(
                                                              fontFamily:
                                                              'BeVietnamPro',
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              // fontSize: 15.sp,
                                                              fontSize: 13.sp,
                                                              color: Colors.green)),
                                                    ],
                                                  ),
                                                ),]
                                              else ...[Container(
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
                                                    Spacer(),
                                                    Text(
                                                        "Đã hủy",
                                                        style: TextStyle(
                                                            fontFamily:
                                                            'BeVietnamPro',
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            // fontSize: 15.sp,
                                                            fontSize: 13.sp,
                                                            color: Colors.redAccent)),
                                                  ],
                                                ),
                                              ),]
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
                                                  width: 200,
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
                                                          color: Colors.grey)),
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
                                                        color: Colors.grey)),
                                              ],
                                            )
                                          ],
                                        ));

                                    //   Container(
                                    //   padding: EdgeInsets.symmetric(vertical: 3),
                                    //   child: Text("- " + items.farmOrders[index].code,  style: TextStyle(
                                    //       fontFamily: 'BeVietnamPro',
                                    //       fontWeight: FontWeight.w500,
                                    //       // fontSize: 15.sp,
                                    //       fontSize: 11.sp,
                                    //       color: Colors.grey)),
                                    // );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );

                        //   Container(
                        //   padding: EdgeInsets.symmetric(vertical: 3),
                        //   child: Text("- " + items.farmOrders[index].code,  style: TextStyle(
                        //       fontFamily: 'BeVietnamPro',
                        //       fontWeight: FontWeight.w500,
                        //       // fontSize: 15.sp,
                        //       fontSize: 11.sp,
                        //       color: Colors.grey)),
                        // );
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
    );
  }
}
