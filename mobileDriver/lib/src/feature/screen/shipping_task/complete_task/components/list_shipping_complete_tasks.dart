// import 'package:delivery_driver_application/src/feature/repository/shipping_order_repository.dart';
// import 'package:delivery_driver_application/src/feature/repository/warehouse_deliver_order_repository.dart';
// import 'package:delivery_driver_application/src/feature/screen/collect_product_task/collect_product_task_screen.dart';
// import 'package:delivery_driver_application/src/feature/screen/shipping_task/shipping_task_screen.dart';
// import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
// import 'package:delivery_driver_application/src/share/constants/app_uidata.dart';
// import 'package:delivery_driver_application/src/share/widget/stateless/progress_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
//
// import '../shipping_processing_task_bloc.dart';
// import '../shipping_processing_task_screen.dart';
// import 'shipping_processing_task_card.dart';
//
// class ListShippingProcessingTask extends StatefulWidget {
//   final String deliveryDriverId;
//
//   const ListShippingProcessingTask({Key? key, required this.deliveryDriverId})
//       : super(key: key);
//
//   @override
//   _ListShippingProcessingTaskState createState() => _ListShippingProcessingTaskState();
// }
//
// class _ListShippingProcessingTaskState extends State<ListShippingProcessingTask>
//     with SingleTickerProviderStateMixin {
//   final _scrollController = ScrollController();
//   final _formKey = GlobalKey<FormState>();
//   int statusCode = 0;
//   bool isPress = false;
//   String cancelReason = '';
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }
//
//   final _shippingOrderRepository = ShippingOrderRepository();
//
//   Future<dynamic> updateStatus(int orderId) async {
//     statusCode =
//         await _shippingOrderRepository.updateStatusOrder(orderId, 7);
//     setState(() {
//       if (statusCode == 200) {
//         isLoading = false;
//         UIData.toastMessage("Cập nhật thành công");
//         Navigator.pop(context);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   const ShippingTaskScreen(initPage: 0)),
//         );
//       } else {
//         isLoading = false;
//         UIData.toastMessage("Cập nhật thất bại");
//       }
//     });
//   }
//
//   Future<dynamic> cancelOrder(int orderId, String note) async {
//     statusCode =
//     await _shippingOrderRepository.cancelOrder(orderId, note);
//     setState(() {
//       if (statusCode == 200) {
//         isLoading = false;
//         UIData.toastMessage("Hủy đơn thành công");
//         Navigator.pop(context);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//               const ShippingTaskScreen(initPage: 0)),
//         );
//       } else {
//         isLoading = false;
//         UIData.toastMessage("Hủy đơn thất bại");
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size _size = MediaQuery.of(context).size;
//     return ProgressHUD(child: BlocBuilder<ShippingProcessingTaskBloc, ShippingProcessingTaskState>(
//       builder: (context, state) {
//         switch (state.status) {
//           case ShippingProcessingTaskStatus.failure:
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
//           case ShippingProcessingTaskStatus.success:
//             if (state.shippingOrders.isEmpty) {
//               return Container(
//                 padding: EdgeInsets.only(top: 30),
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Hiện không có đơn hàng nào cần giao',
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
//                 height: MediaQuery.of(context).size.height * 0.78,
//                 child: ListView.builder(
//                   padding: const EdgeInsets.only(
//                     // top: 5,
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
//                   itemCount: state.hasReachedMax ? state.shippingOrders.length : state.shippingOrders.length + 1,
//                   controller: _scrollController,
//                   itemBuilder: (BuildContext context, int index) {
//                     return index >= state.shippingOrders.length
//                         ? Container(
//                       // padding: EdgeInsets.only(top: 10),
//                         alignment: Alignment.topCenter,
//                         child: SizedBox(
//                           width: 30,
//                           height: 30,
//                           child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,),)
//                     )
//                         : ShippingProcessingTaskCard(shippingOrder: state.shippingOrders[index], onAccept: (){
//                       showDialog<String>(
//                         context: context,
//                         builder: (BuildContext context) => AlertDialog(
//                           title: const Text('Xác nhận'),
//                           content: const Text('Bạn xác nhận đã giao thành công đơn hàng này?'),
//                           actions: <Widget>[
//                             TextButton(
//                               onPressed: () => Navigator.pop(context, 'Cancel'),
//                               child: const Text('Không'),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context, 'ON');
//                                 setState(() {
//                                   // print(state.shippingOrders[index].id);
//                                   isLoading = true;
//                                   updateStatus(state.shippingOrders[index].id as int);
//                                 });
//                               }, child: const Text('Có'),
//                             ),
//                           ],
//                         ),
//                       );
//                     }, onCancel: (){
//                       showDialog<String>(
//                         context: context,
//                         builder: (BuildContext context) => AlertDialog(
//                           title: const Text('Xác nhận'),
//                           content: SizedBox(
//                             height: 130,
//                             child: Form(
//                               key: _formKey,
//                               autovalidateMode: isPress
//                                   ? AutovalidateMode.always
//                                   : AutovalidateMode.disabled,
//                               child: Column(
//                                 children: [
//                                   Text('Bạn xác nhận hủy đơn hàng này?'),
//                                   SizedBox(height: 10,),
//                                   TextFormField(
//                                     style: TextStyle(
//                                         fontFamily: 'BeVietnamPro',
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 13.sp,
//                                         color: Colors.black),
//                                     textInputAction: TextInputAction.done,
//                                     onChanged: (value){
//                                       setState(() {
//                                         cancelReason = value;
//                                       });
//                                     },
//                                     decoration: InputDecoration(
//                                       isDense: true,
//                                       // contentPadding: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
//                                       // labelText: "Resevior Name",
//                                       fillColor: Colors.white,
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide:  BorderSide(
//                                             color: Colors.grey.withOpacity(0.4),
//                                             width: 1,
//                                             style: BorderStyle.solid),
//                                         borderRadius: BorderRadius.circular(10.0),
//                                       ),
//                                       border: OutlineInputBorder(
//                                         borderSide: const BorderSide(color: Colors.orange, width: 1.0),
//                                         borderRadius: BorderRadius.circular(10.0),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide:
//                                         BorderSide(color: Colors.lightBlue.withOpacity(0.6), width: 2.5),
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       // labelText: "Tên nông trại",
//                                       // labelStyle: TextStyle(fontSize: 18),
//                                       floatingLabelBehavior: FloatingLabelBehavior.always,
//                                       // prefixIcon: prefixIcon,
//                                       hintText: 'Nhập lí do hủy đơn',
//                                       hintStyle: TextStyle(
//                                           fontFamily: 'BeVietnamPro',
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 11.sp,
//                                           color: Colors.grey),
//                                     ),
//                                     // The validator receives the text that the user has entered.
//                                     autovalidateMode: AutovalidateMode.disabled,
//                                     validator: (value){
//                                       if(value!.trim().isEmpty){
//                                         return 'Vui lòng điền vào chỗ này';
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           actions: <Widget>[
//                             TextButton(
//                               onPressed: () => Navigator.pop(context, 'Cancel'),
//                               child: const Text('Không'),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 setState(() {
//                                   if (_formKey.currentState!
//                                       .validate()) {
//                                     Navigator.pop(
//                                         context, 'ON');
//                                     isLoading = true;
//                                     cancelOrder(state.shippingOrders[index].id as int, cancelReason);
//                                     // cancelFarmOrder(state.collectOrders[index]
//                                     //     .farmOrders[index1].id as int, 'Sản phẩm không đạt tiêu chuẩn');
//                                   }
//                                 });
//                               }, child: const Text('Có'),
//                             ),
//                           ],
//                         ),
//                       );
//                     });
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
//         // Container(height:20, width: 20,child: const CircularProgressIndicator());
//         }
//       },
//     ), inAsyncCall: isLoading);
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
//     if (_isBottom) context.read<ShippingProcessingTaskBloc>().add(ShippingProcessingFetched());
//   }
//
//   bool get _isBottom {
//     if (!_scrollController.hasClients) return false;
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.offset;
//     return currentScroll >= (maxScroll * 0.9);
//   }
// }

import 'package:delivery_driver_application/src/feature/repository/collect_order_repository.dart';
import 'package:delivery_driver_application/src/feature/screen/collect_product_task/collect_product_task_screen.dart';
import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
import 'package:delivery_driver_application/src/share/constants/app_uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../shipping_complete_task_bloc.dart';
import '../shipping_complete_task_screen.dart';
import 'shipping_complete_task_card.dart';

class ListShippingCompleteTask extends StatefulWidget {
  final String deliveryDriverId;

  const ListShippingCompleteTask({Key? key, required this.deliveryDriverId})
      : super(key: key);

  @override
  _ListShippingCompleteTaskState createState() => _ListShippingCompleteTaskState();
}

class _ListShippingCompleteTaskState extends State<ListShippingCompleteTask>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  int statusCode = 0;
  bool isPress = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  final collectOrderRepository = CollectOrderRepository();

  Future<dynamic> updateStatus(int farmOrderId, int status) async {
    statusCode =
    await collectOrderRepository.updateStatusFarmOrder(farmOrderId, status);
    setState(() {
      if (statusCode == 200) {
        UIData.toastMessage("Cập nhật thành công");
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const CollectProductTaskScreen(initPage: 0)),
        );
      } else {
        UIData.toastMessage("Cập nhật thất bại");
      }
    });
  }

  Future<dynamic> cancelFarmOrder(int farmOrderId, String note) async {
    statusCode =
    await collectOrderRepository.cancelFarmOrder(farmOrderId, note);
    setState(() {
      if (statusCode == 200) {
        UIData.toastMessage("Cập nhật thành công");
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const CollectProductTaskScreen(initPage: 0)),
        );
      } else {
        UIData.toastMessage("Cập nhật thất bại");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return BlocBuilder<ShippingCompleteTaskBloc, ShippingCompleteTaskState>(
      builder: (context, state) {
        switch (state.status) {
          case ShippingCompleteTaskStatus.failure:
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
          case ShippingCompleteTaskStatus.success:
            if (state.shippingOrders.isEmpty) {
              return Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  'Hiện không có đơn hàng nào hoàn thành',
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
                  itemCount: state.shippingOrders.length,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.shippingOrders.length
                        ? Container(
                      // padding: EdgeInsets.only(top: 10),
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,),)
                    )
                        : Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ShippingCompleteTaskCard(
                        deliveryShipping: state.shippingOrders[index],
                      ),
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
    if (_isBottom) context.read<ShippingCompleteTaskBloc>().add(ShippingCompleteFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
