// // import 'package:delivery_driver_application/src/feature/repository/collect_order_repository.dart';
// // import 'package:delivery_driver_application/src/feature/screen/collect_product_task/collect_product_task_screen.dart';
// // import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
// // import 'package:delivery_driver_application/src/share/constants/app_uidata.dart';
// // import 'package:delivery_driver_application/src/share/widget/stateless/icon_widget.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_spinkit/flutter_spinkit.dart';
// // import 'package:iconsax/iconsax.dart';
// // import 'package:page_transition/page_transition.dart';
// //
// // import '../processing_task_bloc.dart';
// // import '../processing_task_screen.dart';
// // import 'processing_task_card.dart';
// //
// class ListProcessingTask extends StatefulWidget {
//   final String deliveryDriverId;
//
//   const ListProcessingTask({Key? key, required this.deliveryDriverId})
//       : super(key: key);
//
//   @override
//   _ListProcessingTaskState createState() => _ListProcessingTaskState();
// }
//
// class _ListProcessingTaskState extends State<ListProcessingTask>
//     with SingleTickerProviderStateMixin {
//   final _scrollController = ScrollController();
//   final _formKey = GlobalKey<FormState>();
//   int statusCode = 0;
//   bool isPress = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }
//
//   final collectOrderRepository = CollectOrderRepository();
//
//   Future<dynamic> updateStatus(int farmOrderId, int status) async {
//     statusCode =
//         await collectOrderRepository.updateStatusFarmOrder(farmOrderId, status);
//     setState(() {
//       if (statusCode == 200) {
//         UIData.toastMessage("Cập nhật thành công");
//         Navigator.pop(context);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   const CollectProductTaskScreen(initPage: 0)),
//         );
//       } else {
//         UIData.toastMessage("Cập nhật thất bại");
//       }
//     });
//   }
//
//   Future<dynamic> cancelFarmOrder(int farmOrderId, String note) async {
//     statusCode =
//     await collectOrderRepository.cancelFarmOrder(farmOrderId, note);
//     setState(() {
//       if (statusCode == 200) {
//         UIData.toastMessage("Cập nhật thành công");
//         Navigator.pop(context);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//               const CollectProductTaskScreen(initPage: 0)),
//         );
//       } else {
//         UIData.toastMessage("Cập nhật thất bại");
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size _size = MediaQuery.of(context).size;
//     return BlocBuilder<ProcessingTaskBloc, ProcessingTaskState>(
//       builder: (context, state) {
//         switch (state.status) {
//           case ProcessingTaskStatus.failure:
//             return Container(
//               padding: EdgeInsets.only(top: 30),
//               alignment: Alignment.center,
//               child: Text(
//                 'Đã có lỗi xảy ra',
//                 textAlign: TextAlign.justify,
//                 style: TextStyle(
//                     height: 1.5,
//                     fontFamily: 'BeVietnamPro',
//                     fontWeight: FontWeight.w400,
//                     fontSize: 11.sp,
//                     color: Colors.grey),
//               ),
//             );
//           case ProcessingTaskStatus.success:
//             if (state.collectOrders.isEmpty) {
//               return Container(
//                 padding: EdgeInsets.only(top: 30),
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Hiện không có đơn hàng nào cần thu',
//                   textAlign: TextAlign.justify,
//                   style: TextStyle(
//                       height: 1.5,
//                       fontFamily: 'BeVietnamPro',
//                       fontWeight: FontWeight.w400,
//                       fontSize: 11.sp,
//                       color: Colors.grey),
//                 ),
//               );
//             }
//             return SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.82,
//                 child: ListView.builder(
//                   padding: const EdgeInsets.only(
//                       // top: 5,
//                       left: kPaddingDefault * 0.6,
//                       right: kPaddingDefault * 0.6),
//                   physics: const ScrollPhysics(),
//                   shrinkWrap: true,
//                   // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   //     crossAxisCount: 1,
//                   //     // mainAxisExtent: _size.height * 0.28
//                   //   // mainAxisSpacing: 5,
//                   //   // crossAxisSpacing: 45,
//                   //   // childAspectRatio: (0.58),
//                   // ),
//                   itemCount: state.collectOrders.length,
//                   controller: _scrollController,
//                   itemBuilder: (BuildContext context, int index) {
//                     return index >= state.collectOrders.length
//                         ? Container(
//                       // padding: EdgeInsets.only(top: 10),
//                         alignment: Alignment.topCenter,
//                         child: SizedBox(
//                           width: 30,
//                           height: 30,
//                           child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,),)
//                     )
//                         : Column(
//                       children: [ProcessingTaskCard(
//                           collectOrder: state.collectOrders[index],
//                           onAccept: () {},
//                           onCancel: () {},
//                           farmOrder: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               // Text('Parent'),
//                               ListView.builder(
//                                   itemCount: state
//                                       .collectOrders[index].farmOrders.length,
//                                   physics: const ClampingScrollPhysics(),
//                                   shrinkWrap: true,
//                                   itemBuilder:
//                                       (BuildContext context, int index1) {
//                                     return Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Card(
//                                           child: ExpansionTile(
//                                             title: Text(state
//                                                 .collectOrders[index]
//                                                 .farmOrders[index1]
//                                                 .code, style: TextStyle(
//                                                 fontFamily: 'BeVietnamPro',
//                                                 fontWeight: FontWeight.w500,
//                                                 // fontSize: 15.sp,
//                                                 fontSize: 12.sp,
//                                                 color: Colors.black)),
//                                             children: [
//                                               ListView.builder(
//                                                   itemCount: state
//                                                       .collectOrders[index]
//                                                       .farmOrders[index1]
//                                                       .harvestOrders
//                                                       .length,
//                                                   physics:
//                                                   ClampingScrollPhysics(),
//                                                   shrinkWrap: true,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                       int index2) {
//                                                     if (index2 ==
//                                                         state
//                                                             .collectOrders[
//                                                         index]
//                                                             .farmOrders[
//                                                         index1]
//                                                             .harvestOrders
//                                                             .length -
//                                                             1) {
//                                                       return Column(
//                                                         children: [
//                                                           ListTile(
//                                                               title: Row(
//                                                                 children: [
//                                                                   Text('- ',
//                                                                       style: TextStyle(
//                                                                           fontFamily: 'BeVietnamPro',
//                                                                           fontWeight: FontWeight.w400,
//                                                                           // fontSize: 15.sp,
//                                                                           fontSize: 12.sp,
//                                                                           color: Colors.black)),
//                                                                   Text(
//                                                                       state
//                                                                           .collectOrders[
//                                                                       index]
//                                                                           .farmOrders[
//                                                                       index1]
//                                                                           .harvestOrders[
//                                                                       index2]
//                                                                           .productName,
//                                                                       style: TextStyle(
//                                                                           fontFamily: 'BeVietnamPro',
//                                                                           fontWeight: FontWeight.w400,
//                                                                           // fontSize: 15.sp,
//                                                                           fontSize: 12.sp,
//                                                                           color: Colors.black)),
//                                                                   Text(
//                                                                       ' (x' +
//                                                                           state
//                                                                               .collectOrders[
//                                                                           index]
//                                                                               .farmOrders[
//                                                                           index1]
//                                                                               .harvestOrders[
//                                                                           index2]
//                                                                               .quantity
//                                                                               .toString() +
//                                                                           " " +
//                                                                           state
//                                                                               .collectOrders[index]
//                                                                               .farmOrders[index1]
//                                                                               .harvestOrders[index2]
//                                                                               .unit +
//                                                                           ')',
//                                                                       style: TextStyle(
//                                                                           fontFamily: 'BeVietnamPro',
//                                                                           fontWeight: FontWeight.w400,
//                                                                           // fontSize: 15.sp,
//                                                                           fontSize: 12.sp,
//                                                                           color: Colors.black)),
//                                                                 ],
//                                                               )),
//                                                           Row(
//                                                             children: [
//                                                               Spacer(),
//                                                               Container(
//                                                                   width: 35,
//                                                                   child: TextButton(
//                                                                       onPressed: () {
//                                                                         showDialog<String>(
//                                                                           context: context,
//                                                                           builder: (BuildContext context) => StatefulBuilder(builder: (context, setState){
//                                                                             return AlertDialog(
//                                                                               title: const Text('Xác nhận'),
//                                                                               content: const Text('Bạn xác nhận đã thu đơn hàng này?'),
//                                                                               actions: <Widget>[
//                                                                                 TextButton(
//                                                                                   onPressed: () => Navigator.pop(context, 'Cancel'),
//                                                                                   child: const Text('Không'),
//                                                                                 ),
//                                                                                 TextButton(
//                                                                                   onPressed: () {
//                                                                                     Navigator.pop(context, 'ON');
//                                                                                     setState(() {
//                                                                                       updateStatus(state.collectOrders[index]
//                                                                                           .farmOrders[index1].id as int, 4);
//                                                                                     });
//                                                                                   }, child: const Text('Có'),
//                                                                                 ),
//                                                                               ],
//                                                                             );
//                                                                           }),
//                                                                         );
//
//                                                                       },
//                                                                       child: IconWidget(
//                                                                         icon:
//                                                                         Iconsax.tick_circle,
//                                                                         color:
//                                                                         Colors.green,
//                                                                         fontSize:
//                                                                         16.sp,
//                                                                         fontWeight:
//                                                                         FontWeight.w600,
//                                                                       ))),
//                                                               Container(
//                                                                   width: 35,
//                                                                   child: TextButton(
//                                                                       onPressed: () {
//                                                                         showDialog<String>(
//                                                                           context: context,
//                                                                           builder: (BuildContext context) => StatefulBuilder(builder: (context, setState){
//                                                                             return AlertDialog(
//                                                                               title: const Text('Xác nhận'),
//                                                                               content: SizedBox(
//                                                                                 height: 110,
//                                                                                 child: Form(
//                                                                                   key: _formKey,
//                                                                                   autovalidateMode: isPress
//                                                                                       ? AutovalidateMode.always
//                                                                                       : AutovalidateMode.disabled,
//                                                                                   child: Column(
//                                                                                     children: [
//                                                                                       Text('Bạn xác nhận hủy đơn hàng này?'),
//                                                                                       SizedBox(height: 10,),
//                                                                                       TextFormField(
//                                                                                         style: TextStyle(
//                                                                                             fontFamily: 'BeVietnamPro',
//                                                                                             fontWeight: FontWeight.w400,
//                                                                                             fontSize: 13.sp,
//                                                                                             color: Colors.black),
//                                                                                         textInputAction: TextInputAction.done,
//                                                                                         onChanged: (value){
//                                                                                           setState(() {
//                                                                                           });
//                                                                                         },
//                                                                                         decoration: InputDecoration(
//                                                                                           isDense: true,
//                                                                                           // contentPadding: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
//                                                                                           // labelText: "Resevior Name",
//                                                                                           fillColor: Colors.white,
//                                                                                           enabledBorder: OutlineInputBorder(
//                                                                                             borderSide:  BorderSide(
//                                                                                                 color: Colors.grey.withOpacity(0.4),
//                                                                                                 width: 1,
//                                                                                                 style: BorderStyle.solid),
//                                                                                             borderRadius: BorderRadius.circular(10.0),
//                                                                                           ),
//                                                                                           border: OutlineInputBorder(
//                                                                                             borderSide: const BorderSide(color: Colors.orange, width: 1.0),
//                                                                                             borderRadius: BorderRadius.circular(10.0),
//                                                                                           ),
//                                                                                           focusedBorder: OutlineInputBorder(
//                                                                                             borderSide:
//                                                                                             BorderSide(color: Colors.lightBlue.withOpacity(0.6), width: 2.5),
//                                                                                             borderRadius: BorderRadius.circular(8),
//                                                                                           ),
//                                                                                           // labelText: "Tên nông trại",
//                                                                                           // labelStyle: TextStyle(fontSize: 18),
//                                                                                           floatingLabelBehavior: FloatingLabelBehavior.always,
//                                                                                           // prefixIcon: prefixIcon,
//                                                                                           hintText: 'Nhập lí do hủy đơn',
//                                                                                           hintStyle: TextStyle(
//                                                                                               fontFamily: 'BeVietnamPro',
//                                                                                               fontWeight: FontWeight.w500,
//                                                                                               fontSize: 11.sp,
//                                                                                               color: Colors.grey),
//                                                                                         ),
//                                                                                         // The validator receives the text that the user has entered.
//                                                                                         autovalidateMode: AutovalidateMode.disabled,
//                                                                                         validator: (value){
//                                                                                           if(value!.trim().isEmpty){
//                                                                                             return 'Vui lòng điền vào chỗ này';
//                                                                                           }
//                                                                                         },
//                                                                                       ),
//                                                                                     ],
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                               actions: <Widget>[
//                                                                                 TextButton(
//                                                                                   onPressed: () => Navigator.pop(context, 'Cancel'),
//                                                                                   child: const Text('Không'),
//                                                                                 ),
//                                                                                 TextButton(
//                                                                                   onPressed: () {
//                                                                                     setState(() {
//                                                                                       if (_formKey.currentState!
//                                                                                           .validate()) {
//                                                                                         Navigator.pop(
//                                                                                             context, 'ON');
//                                                                                         cancelFarmOrder(state.collectOrders[index]
//                                                                                             .farmOrders[index1].id as int, 'Sản phẩm không đạt tiêu chuẩn');
//                                                                                       }
//                                                                                     });
//                                                                                   }, child: const Text('Có'),
//                                                                                 ),
//                                                                               ],
//                                                                             );
//                                                                           }),
//                                                                         );
//
//                                                                       },
//                                                                       child: IconWidget(
//                                                                         icon:
//                                                                         Iconsax.close_circle,
//                                                                         color:
//                                                                         Colors.redAccent,
//                                                                         fontSize:
//                                                                         16.sp,
//                                                                         fontWeight:
//                                                                         FontWeight.w600,
//                                                                       ))),
//                                                             ],
//                                                           )
//                                                         ],
//                                                       );
//                                                     }
//                                                     return ListTile(
//                                                         title: Row(
//                                                           children: [
//                                                             Text('- ',
//                                                                 style: TextStyle(
//                                                                     fontFamily:
//                                                                     'BeVietnamPro',
//                                                                     fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                     // fontSize: 15.sp,
//                                                                     fontSize:
//                                                                     12.sp,
//                                                                     color: Colors
//                                                                         .black)),
//                                                             Text(
//                                                                 state
//                                                                     .collectOrders[
//                                                                 index]
//                                                                     .farmOrders[
//                                                                 index1]
//                                                                     .harvestOrders[
//                                                                 index2]
//                                                                     .productName,
//                                                                 style: TextStyle(
//                                                                     fontFamily:
//                                                                     'BeVietnamPro',
//                                                                     fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                     // fontSize: 15.sp,
//                                                                     fontSize:
//                                                                     12.sp,
//                                                                     color: Colors
//                                                                         .black)),
//                                                             Text(
//                                                                 ' (x' +
//                                                                     state
//                                                                         .collectOrders[
//                                                                     index]
//                                                                         .farmOrders[
//                                                                     index1]
//                                                                         .harvestOrders[
//                                                                     index2]
//                                                                         .quantity
//                                                                         .toString() +
//                                                                     " " +
//                                                                     state
//                                                                         .collectOrders[
//                                                                     index]
//                                                                         .farmOrders[
//                                                                     index1]
//                                                                         .harvestOrders[
//                                                                     index2]
//                                                                         .unit +
//                                                                     ')',
//                                                                 style: TextStyle(
//                                                                     fontFamily:
//                                                                     'BeVietnamPro',
//                                                                     fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                     // fontSize: 15.sp,
//                                                                     fontSize:
//                                                                     12.sp,
//                                                                     color: Colors
//                                                                         .black)),
//                                                           ],
//                                                         ));
//                                                   }),
//                                               // SizedBox(height: 50,)
//                                             ],
//                                           ),
//                                         ),
//                                         // Text('Parent'),
//                                       ],
//                                     );
//                                   }),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                             ],
//                           )), SizedBox(height: 20,)],
//                     );
//                   },
//                 ));
//           default:
//             return Container(
//               // padding: EdgeInsets.only(top: 10),
//                 alignment: Alignment.topCenter,
//                 child: SizedBox(
//                   width: 30,
//                   height: 30,
//                   child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,),)
//             );
//           // Container(height:20, width: 20,child: const CircularProgressIndicator());
//         }
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _scrollController
//       ..removeListener(_onScroll)
//       ..dispose();
//     super.dispose();
//   }
//
//   void _onScroll() {
//     if (_isBottom) context.read<ProcessingTaskBloc>().add(ProcessingFetched());
//   }
//
//   bool get _isBottom {
//     if (!_scrollController.hasClients) return false;
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.offset;
//     return currentScroll >= (maxScroll * 0.9);
//   }
// }
//

import 'package:delivery_driver_application/src/feature/repository/collect_order_repository.dart';
import 'package:delivery_driver_application/src/feature/screen/collect_product_task/collect_product_task_screen.dart';
import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
import 'package:delivery_driver_application/src/share/constants/app_uidata.dart';
import 'package:delivery_driver_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

import '../complete_task_bloc.dart';
import '../complete_task_screen.dart';
import 'complete_task_card.dart';

class ListCompleteTask extends StatefulWidget {
  final String deliveryDriverId;

  const ListCompleteTask({Key? key, required this.deliveryDriverId})
      : super(key: key);

  @override
  _ListCompleteTaskState createState() => _ListCompleteTaskState();
}

class _ListCompleteTaskState extends State<ListCompleteTask>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return BlocBuilder<CompleteTaskBloc, CompleteTaskState>(
      builder: (context, state) {
        switch (state.status) {
          case CompleteTaskStatus.failure:
            return Container(
              padding: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: Text(
                'Đã có lỗi xảy ra',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    height: 1.5,
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.w400,
                    fontSize: 11.sp,
                    color: Colors.grey),
              ),
            );
          case CompleteTaskStatus.success:
            if (state.collectOrders.isEmpty) {
              return Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  'Hiện không có đơn hàng nào được thu',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      height: 1.5,
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      color: Colors.grey),
                ),
              );
            }
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.78,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    // top: 5,
                      left: kPaddingDefault * 0.6,
                      right: kPaddingDefault * 0.6),
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 1,
                  //     // mainAxisExtent: _size.height * 0.28
                  //   // mainAxisSpacing: 5,
                  //   // crossAxisSpacing: 45,
                  //   // childAspectRatio: (0.58),
                  // ),
                  itemCount: state.collectOrders.length,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.collectOrders.length
                        ? Container(
                      // padding: EdgeInsets.only(top: 10),
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,),)
                    )
                        : CompleteTaskCard(
                      collectOrder: state.collectOrders[index],
                    );
                  },
                ));
          default:
            return Container(
              // padding: EdgeInsets.only(top: 10),
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,),)
            );
        // Container(height:20, width: 20,child: const CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<CompleteTaskBloc>().add(CompleteFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
