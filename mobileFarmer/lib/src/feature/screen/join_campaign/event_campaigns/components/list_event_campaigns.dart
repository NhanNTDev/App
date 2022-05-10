import 'package:farmer_application/src/feature/screen/join_campaign/components/campaign_card.dart';
import 'package:farmer_application/src/feature/screen/join_campaign/join_campaign_detail/join_campaign_detail_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../../join_campaign_screen.dart';
import '../join_event_campaign_bloc.dart';


class ListEventCampaigns extends StatefulWidget {
  final String farmerId;
  const ListEventCampaigns({Key? key, required this.farmerId}) : super(key: key);

  @override
  _ListEventCampaignsState createState() => _ListEventCampaignsState();
}

class _ListEventCampaignsState extends State<ListEventCampaigns>
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
    return BlocBuilder<JoinEventCampaignBloc, JoinEventCampaignState>(
      builder: (context, state) {
        switch (state.status) {
          case CampaignStatus.failure:
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
            );;
          case CampaignStatus.success:
            if (state.campaigns.isEmpty) {
              return Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  'Hiện chưa có chiến dịch bạn có thể tham gia',
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
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      top: 5,
                      left: kPaddingDefault * 0.6,
                      right: kPaddingDefault * 0.6),
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.hasReachedMax
                      ? state.campaigns.length
                      : state.campaigns.length + 1,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.campaigns.length
                        ? Container(
                      // padding: EdgeInsets.only(top: 10),
                      alignment: Alignment.topCenter,
                      child: SizedBox(width: 30, height: 30, child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,)),
                    )
                        : GestureDetector(
                      child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Column(
                            children: [
                              CampaignCard(
                                campaign: state.campaigns[index],
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
                                            child:
                                            JoinCampaignDetailScreen(campaignId: state.campaigns[index].id as int,farmerId: widget.farmerId,),
                                            childCurrent:
                                            const JoinCampaignScreen(initPage: 0,)));
                                  });
                                },
                              ),
                              index == state.campaigns.length - 1
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
                  child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,),
                ));
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
    if (_isBottom) context.read<JoinEventCampaignBloc>().add(EventCampaignFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
