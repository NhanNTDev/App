import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../cancel_task_bloc.dart';
import '../cancel_task_screen.dart';
import 'cancel_task_card.dart';

class ListCancelTask extends StatefulWidget {
  final String deliveryDriverId;

  const ListCancelTask({Key? key, required this.deliveryDriverId})
      : super(key: key);

  @override
  _ListCancelTaskState createState() => _ListCancelTaskState();
}

class _ListCancelTaskState extends State<ListCancelTask>
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
    return BlocBuilder<CancelTaskBloc, CancelTaskState>(
      builder: (context, state) {
        switch (state.status) {
          case CancelTaskStatus.failure:
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
          case CancelTaskStatus.success:
            if (state.collectOrders.isEmpty) {
              return Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  'Hiện không có đơn hàng nào bị hủy',
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
                height: MediaQuery.of(context).size.height * 0.82,
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
                        : CancelTaskCard(
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
    if (_isBottom) context.read<CancelTaskBloc>().add(CancelFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
