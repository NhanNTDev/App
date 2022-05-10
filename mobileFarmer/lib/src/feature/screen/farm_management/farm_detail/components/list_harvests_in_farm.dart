import 'package:farmer_application/src/feature/screen/farm_management/farm_detail/farm_detail_screen.dart';
import 'package:farmer_application/src/feature/screen/harvest_management/harvest_detail/harvest_detail_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import '../harvest_in_farm_bloc.dart';
import 'harvest_in_farm_card.dart';

class ListHarvestsInFarm extends StatefulWidget {
  final int farmId;

  const ListHarvestsInFarm({Key? key, required this.farmId}) : super(key: key);

  @override
  _ListHarvestsInFarmState createState() => _ListHarvestsInFarmState();
}

class _ListHarvestsInFarmState extends State<ListHarvestsInFarm>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HarvestInFarmBloc, HarvestInFarmState>(
      builder: (context, state) {
        switch (state.status) {
          case HarvestInFarmStatus.failure:
            return Container(
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
          case HarvestInFarmStatus.success:
            if (state.harvestsInFarm.isEmpty) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  'Chưa có mùa vụ nào trong nông trại này',
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
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      top: 5,
                      left: kPaddingDefault * 0.6,
                      right: kPaddingDefault * 0.6),
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.hasReachedMax
                      ? state.harvestsInFarm.length
                      : state.harvestsInFarm.length + 1,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.harvestsInFarm.length
                        ? Container(
                            // padding: EdgeInsets.only(top: 10),
                            alignment: Alignment.topCenter,
                            child: const SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator()),
                          )
                        : GestureDetector(
                            child: Container(
                                color: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    HarvestInFarmCard(
                                      harvest: state.harvestsInFarm[index],
                                      onPressed: () {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  curve: Curves.easeInOut,
                                                  duration: const Duration(
                                                      milliseconds: 400),
                                                  reverseDuration:
                                                      const Duration(
                                                          milliseconds: 400),
                                                  type: PageTransitionType
                                                      .rightToLeftJoined,
                                                  child: HarvestDetailScreen(
                                                    harvestId: state
                                                        .harvestsInFarm[index]
                                                        .id as int,
                                                  ),
                                                  childCurrent:
                                                      FarmDetailScreen(
                                                          farmId:
                                                              widget.farmId)));
                                        });
                                      },
                                    ),
                                    index == state.harvestsInFarm.length - 1
                                        ? Container()
                                        : Container(
                                            color: Colors.grey.withOpacity(0.2),
                                            height: 3,
                                          ),
                                  ],
                                )),
                          );
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
      context.read<HarvestInFarmBloc>().add(HarvestInFarmFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
