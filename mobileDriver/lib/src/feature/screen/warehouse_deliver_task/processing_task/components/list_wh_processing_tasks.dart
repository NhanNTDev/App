import 'package:delivery_driver_application/src/feature/repository/collect_order_repository.dart';
import 'package:delivery_driver_application/src/feature/repository/warehouse_deliver_order_repository.dart';
import 'package:delivery_driver_application/src/feature/screen/collect_product_task/collect_product_task_screen.dart';
import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
import 'package:delivery_driver_application/src/share/constants/app_uidata.dart';
import 'package:delivery_driver_application/src/share/widget/stateless/icon_widget.dart';
import 'package:delivery_driver_application/src/share/widget/stateless/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

import '../../warehouse_deliver_task_screen.dart';
import '../wh_processing_task_bloc.dart';
import '../wh_processing_task_screen.dart';
import 'wh_processing_task_card.dart';

class ListWhProcessingTask extends StatefulWidget {
  final String deliveryDriverId;

  const ListWhProcessingTask({Key? key, required this.deliveryDriverId})
      : super(key: key);

  @override
  _ListWhProcessingTaskState createState() => _ListWhProcessingTaskState();
}

class _ListWhProcessingTaskState extends State<ListWhProcessingTask>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  int statusCode = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  final _warehouseDeliverOrderRepository = WarehouseDeliverOrderRepository();

  Future<dynamic> updateStatus(int shipmentId) async {
    statusCode =
        await _warehouseDeliverOrderRepository.updateStatusShipment(shipmentId);
    setState(() {
      if (statusCode == 200) {
        isLoading = false;
        UIData.toastMessage("Cập nhật thành công");
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const WarehouseDeliverTaskScreen(initPage: 0)),
        );
      } else {
        isLoading = false;
        UIData.toastMessage("Cập nhật thất bại");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ProgressHUD(child: BlocBuilder<WhProcessingTaskBloc, WhProcessingTaskState>(
      builder: (context, state) {
        switch (state.status) {
          case WhProcessingTaskStatus.failure:
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
          case WhProcessingTaskStatus.success:
            if (state.warehouseDeliverOrders.isEmpty) {
              return Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  'Hiện không có chuyến hàng nào cần luân chuyển',
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
                  itemCount: state.hasReachedMax ? state.warehouseDeliverOrders.length : state.warehouseDeliverOrders.length + 1,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.warehouseDeliverOrders.length
                        ? Container(
                      // padding: EdgeInsets.only(top: 10),
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,),)
                    )
                        : WhProcessingTaskCard(warehouseDeliverOrder: state.warehouseDeliverOrders[index], onAccept: (){
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Xác nhận'),
                          content: const Text('Bạn xác nhận đã hoàn thành chuyến hàng này?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Không'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'ON');
                                setState(() {
                                  isLoading = true;
                                  print(state.warehouseDeliverOrders[index].id);
                                  updateStatus(state.warehouseDeliverOrders[index].id as int);
                                });
                              }, child: const Text('Có'),
                            ),
                          ],
                        ),
                      );
                    }, onCancel: (){});
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
    ), inAsyncCall: isLoading);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<WhProcessingTaskBloc>().add(WhProcessingFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
