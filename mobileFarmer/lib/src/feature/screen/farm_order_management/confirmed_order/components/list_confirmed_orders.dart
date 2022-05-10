import 'package:farmer_application/src/feature/screen/farm_order_management/confirmed_order/confirmed_order_detail/confirmed_order_detail_screen.dart';
import 'package:farmer_application/src/feature/screen/farm_order_management/need_confirm_order/need_confirm_order_detail/need_confirm_order_detail_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../../order_management_screen.dart';
import '../confirmed_order_bloc.dart';
import '../confirmed_order_screen.dart';
import 'confirmed_order_card.dart';

class ListConfirmedFarmOrder extends StatefulWidget {
  const ListConfirmedFarmOrder({Key? key}) : super(key: key);

  @override
  _ListConfirmedFarmOrderState createState() => _ListConfirmedFarmOrderState();
}

class _ListConfirmedFarmOrderState extends State<ListConfirmedFarmOrder>
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
    return BlocBuilder<ConfirmedFarmOrderBloc, ConfirmedFarmOrderState>(
      builder: (context, state) {
        switch (state.status) {
          case ConfirmedFarmOrderStatus.failure:
            return const Center(child: Text('Đã có lỗi xảy ra'));
          case ConfirmedFarmOrderStatus.success:
            if (state.farmOrders.isEmpty) {
              return const Center(child: Text('Hiện không có đơn hàng cần xử lí'));
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
                  itemCount: state.hasReachedMax
                      ? state.farmOrders.length
                      : state.farmOrders.length + 1,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.farmOrders.length
                        ? Container(
                      // padding: EdgeInsets.only(top: 10),
                      alignment: Alignment.topCenter,
                      child: SizedBox(width: 30, height: 30, child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,)),
                    )
                    // Container(height:20, width: 20,child: const CircularProgressIndicator())
                        : GestureDetector(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: ConfirmedOrderCard(
                                farmOrder: state.farmOrders[index],
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            curve: Curves.easeInOut,
                                            duration: const Duration(
                                                milliseconds: 400),
                                            reverseDuration: const Duration(
                                                milliseconds: 400),
                                            type: PageTransitionType
                                                .rightToLeftJoined,
                                            settings: RouteSettings(
                                                name: "/needconfirmorder"),
                                            child: ConfirmedOrderDetailScreen(
                                              // farmId: state.farms[index].id,
                                              farmOrderId: state.farmOrders[index].id as int,
                                            ),
                                            childCurrent:
                                            const OrderManagementScreen(initPage: 1,)));
                                  });
                                },
                              ),
                            ),
                            // Container(
                            //   color: Colors.grey.withOpacity(0.3),
                            //   height: 2,
                            // ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ));
                    // : Container(alignment: Alignment.center,height:200,child: Text((index + 1).toString()));
                  },
                ));
          default:
            return Container(
              padding: const EdgeInsets.only(top: 30),
              alignment: Alignment.topCenter,
              child: SizedBox(width: 30, height: 30, child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,)),
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
    if (_isBottom) context.read<ConfirmedFarmOrderBloc>().add(ConfirmedFarmOrderFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
