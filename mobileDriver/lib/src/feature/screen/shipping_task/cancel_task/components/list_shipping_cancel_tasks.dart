import 'package:delivery_driver_application/src/feature/repository/shipping_order_repository.dart';
import 'package:delivery_driver_application/src/feature/screen/shipping_task/shipping_task_screen.dart';
import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
import 'package:delivery_driver_application/src/share/constants/app_uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../shipping_cancel_task_bloc.dart';
import '../shipping_cancel_task_screen.dart';
import 'shipping_cancel_task_card.dart';

class ListShippingCancelTask extends StatefulWidget {
  final String deliveryDriverId;

  const ListShippingCancelTask({Key? key, required this.deliveryDriverId})
      : super(key: key);

  @override
  _ListShippingCancelTaskState createState() => _ListShippingCancelTaskState();
}

class _ListShippingCancelTaskState extends State<ListShippingCancelTask>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  int statusCode = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return BlocBuilder<ShippingCancelTaskBloc, ShippingCancelTaskState>(
      builder: (context, state) {
        switch (state.status) {
          case ShippingCancelTaskStatus.failure:
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
          case ShippingCancelTaskStatus.success:
            if (state.shippingOrders.isEmpty) {
              return Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  'Hiện chưa có đơn hàng nào bị hủy',
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
                  itemCount: state.hasReachedMax ? state.shippingOrders.length : state.shippingOrders.length + 1,
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
                        : ShippingCancelTaskCard(shippingOrder: state.shippingOrders[index]);
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
    if (_isBottom) context.read<ShippingCancelTaskBloc>().add(ShippingCancelFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
