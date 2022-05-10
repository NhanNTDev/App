import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../feedback_in_farm_bloc.dart';
import 'feedback_card.dart';

class ListFeedback extends StatefulWidget {
  const ListFeedback({Key? key}) : super(key: key);

  @override
  _ListFeedbackState createState() => _ListFeedbackState();
}

class _ListFeedbackState extends State<ListFeedback>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackInFarmBloc, FeedbackInFarmState>(
      builder: (context, state) {
        switch (state.status) {
          case FeedbackInFarmStatus.failure:
            return Container(
              padding: const EdgeInsets.only(top: 30),
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
          case FeedbackInFarmStatus.success:
            if (state.feedbacks.isEmpty) {
              return Container(
                padding: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  'Chưa có đánh giá',
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
                      left: kPaddingDefault * 0.6,
                      right: kPaddingDefault * 0.6),
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.hasReachedMax
                      ? state.feedbacks.length
                      : state.feedbacks.length + 1,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.feedbacks.length
                        ? Container(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                                width: 30,
                                height: 30,
                                child: SpinKitHourGlass(
                                  color: kBlueDefault,
                                  size: 30.sp,
                                )),
                          )
                        : GestureDetector(
                            child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: FeedbackCard(
                                  feedback: state.feedbacks[index],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ));
                  },
                ));
          default:
            return Container(
              padding: const EdgeInsets.only(top: 30),
              alignment: Alignment.topCenter,
              child: SizedBox(
                  width: 30,
                  height: 30,
                  child: SpinKitHourGlass(
                    color: kBlueDefault,
                    size: 30.sp,
                  )),
            );
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
    if (_isBottom)
      context.read<FeedbackInFarmBloc>().add(FeedbackInFarmFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
