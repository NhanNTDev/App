import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../wh_complete_task_bloc.dart';
import 'wh_complete_task_card.dart';

class ListWhCompleteTask extends StatefulWidget {
  final String deliveryDriverId;

  const ListWhCompleteTask({Key? key, required this.deliveryDriverId})
      : super(key: key);

  @override
  _ListWhCompleteTaskState createState() => _ListWhCompleteTaskState();
}

class _ListWhCompleteTaskState extends State<ListWhCompleteTask>
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
    return BlocBuilder<WhCompleteTaskBloc, WhCompleteTaskState>(
      builder: (context, state) {
        switch (state.status) {
          case WhCompleteTaskStatus.failure:
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
          case WhCompleteTaskStatus.success:
            if (state.warehouseDeliverOrders.isEmpty) {
              return Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  'Chưa có chuyến hàng hoàn thành',
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
                        : Container(padding: EdgeInsets.only(top: 10),child: WhProcessingTaskCard(warehouseDeliverOrder: state.warehouseDeliverOrders[index]));
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
    if (_isBottom) context.read<WhCompleteTaskBloc>().add(WhCompleteFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
