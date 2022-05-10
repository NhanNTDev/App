import 'package:farmer_application/src/feature/screen/farm_order_management/processing_order/processing_order_detail/processing_order_detail_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../../order_management_screen.dart';
import '../processing_order_bloc.dart';
import 'processing_order_card.dart';

class ListProcessingFarmOrder extends StatefulWidget {
  const ListProcessingFarmOrder({Key? key}) : super(key: key);

  @override
  _ListProcessingFarmOrderState createState() =>
      _ListProcessingFarmOrderState();
}

class _ListProcessingFarmOrderState extends State<ListProcessingFarmOrder>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessingFarmOrderBloc, ProcessingFarmOrderState>(
      builder: (context, state) {
        switch (state.status) {
          case ProcessingFarmOrderStatus.failure:
            return const Center(child: Text('Đã có lỗi xảy ra'));
          case ProcessingFarmOrderStatus.success:
            if (state.farmOrders.isEmpty) {
              return const Center(
                  child: Text('Hiện không có đơn hàng đang xử lí'));
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
                  itemCount: state.hasReachedMax
                      ? state.farmOrders.length
                      : state.farmOrders.length + 1,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.farmOrders.length ? Container(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                                width: 30, height: 30,
                                child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,)),
                          )
                        : GestureDetector(
                            child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                child: ProcessingOrderCard(
                                  farmOrder: state.farmOrders[index],
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(context, PageTransition(
                                              curve: Curves.easeInOut,
                                              duration: const Duration(milliseconds: 400),
                                              reverseDuration: const Duration(milliseconds: 400),
                                              type: PageTransitionType.rightToLeftJoined,
                                              settings: RouteSettings(name: "/needconfirmorder"),
                                              child: ProcessingOrderDetailScreen(
                                                farmOrderId: state.farmOrders[index].id as int,),
                                              childCurrent: const OrderManagementScreen(initPage: 2,)));
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: 10,)
                            ],
                          ));
                  },
                ));
          default:
            return Container(
              padding: const EdgeInsets.only(top: 30),
              alignment: Alignment.topCenter,
              child: SizedBox(
                  width: 30, height: 30,
                  child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,)),
            );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController..removeListener(_onScroll)..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom)
      context.read<ProcessingFarmOrderBloc>().add(ProcessingFarmOrderFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
