import 'package:farmer_application/src/feature/screen/farm_management/farm_detail/farm_detail_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../farm_management_bloc.dart';
import '../farm_management_screen.dart';
import 'farm_card.dart';

class ListFarm extends StatefulWidget {
  const ListFarm({Key? key}) : super(key: key);

  @override
  _ListFarmState createState() => _ListFarmState();
}

class _ListFarmState extends State<ListFarm>
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
    return BlocBuilder<FarmManagementBloc, FarmManagementState>(
      builder: (context, state) {
        switch (state.status) {
          case FarmStatus.failure:
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
          case FarmStatus.success:
            if (state.farms.isEmpty) {
              return Container(
                padding: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  'Chưa có nông trại',
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
                      ? state.farms.length
                      : state.farms.length + 1,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.farms.length
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
                                child: FarmCard(
                                  farm: state.farms[index],
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
                                              settings: const RouteSettings(
                                                  name: "/farmdetail"),
                                              child: FarmDetailScreen(
                                                farmId: state.farms[index].id,
                                              ),
                                              childCurrent:
                                                  const FarmManagementScreen()));
                                    });
                                  },
                                ),
                              ),
                              Container(
                                color: Colors.grey.withOpacity(0.3),
                                height: 3,
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
    if (_isBottom) context.read<FarmManagementBloc>().add(FarmFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
