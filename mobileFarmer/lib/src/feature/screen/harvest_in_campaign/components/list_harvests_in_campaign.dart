import 'package:farmer_application/src/feature/screen/harvest_in_campaign/harvest_in_campaign_detail/harvest_in_campaign_detail_screen.dart';
import 'package:farmer_application/src/feature/screen/harvest_in_campaign/harvest_in_campaign_screen.dart';
import 'package:farmer_application/src/feature/screen/harvest_management/harvest_management_bloc.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../harvest_in_campaign_bloc.dart';

import 'harvest_in_campaign_card.dart';

class ListHarvestsInCampaign extends StatefulWidget {
  final int campaignId;
  final int farmId;
  final String farmName;
  final String status;
  final String campaignName;
  const ListHarvestsInCampaign({Key? key, required this.campaignId, required this.farmId, required this.farmName, required this.status, required this.campaignName}) : super(key: key);

  @override
  _ListHarvestsInCampaignState createState() => _ListHarvestsInCampaignState();
}

class _ListHarvestsInCampaignState extends State<ListHarvestsInCampaign>
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
    return BlocBuilder<HarvestInCampaignBloc, HarvestInCampaignState>(
      builder: (context, state) {
        switch (state.status) {
          case HarvestInCampaignStatus.failure:
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
          case HarvestInCampaignStatus.success:
            if (state.harvestsInCampaign.isEmpty) {
              return Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  'Nông trại này chưa có sản phẩm nào trong chiến dịch',
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
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      top: 5,
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
                      ? state.harvestsInCampaign.length
                      : state.harvestsInCampaign.length + 1,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.harvestsInCampaign.length
                        ? Container(
                            // padding: EdgeInsets.only(top: 10),
                            alignment: Alignment.topCenter,
                      child: SizedBox(width: 30, height: 30, child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,)),
                          )
                        // Container(height:20, width: 20,child: const CircularProgressIndicator())
                        : GestureDetector(
                            child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Column(
                                  children: [
                                    HarvestInCampaignCard(
                                      harvest: state.harvestsInCampaign[index],
                                      onPressed: () {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  curve: Curves.easeInOut,
                                                  duration: const Duration(milliseconds: 400),
                                                  reverseDuration:
                                                  const Duration(milliseconds: 400),
                                                  type: PageTransitionType.rightToLeftJoined,
                                                  child: HarvestInCampaignDetailScreen(harvestInCampaignId: state.harvestsInCampaign[index].id as int, farmId: widget.farmId,campaignId: widget.campaignId,status: widget.status),
                                                  // FarmDetailScreen(
                                                  //   farm: state.farms[index],
                                                  // ),
                                                  childCurrent: HarvestInCampaignScreen(campaignId: widget.campaignId, farmId: widget.farmId, farmName: widget.farmName, status: widget.status,campaignName: widget.campaignName,)));
                                        });
                                      },
                                    ),
                                    index == state.harvestsInCampaign.length - 1
                                        ? Container()
                                        : Container(
                                            color: Colors.grey.withOpacity(0.2),
                                            height: 3,
                                          ),
                                  ],
                                )),
                          );
                    // : Container(alignment: Alignment.center,height:200,child: Text((index + 1).toString()));
                  },
                ));
          default:
            return Container(
              padding: const EdgeInsets.only(top: 30),
              alignment: Alignment.topCenter,
              child: SizedBox(width: 30, height: 30, child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,)),
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
    if (_isBottom) context.read<HarvestInCampaignBloc>().add(HarvestInCampaignFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
