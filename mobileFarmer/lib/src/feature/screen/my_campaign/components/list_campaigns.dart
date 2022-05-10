import 'package:farmer_application/src/feature/screen/my_campaign/my_campaign_detail/my_campaign_detail_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../my_campaign_bloc.dart';
import '../my_campaign_screen.dart';
import 'campaign_card.dart';

class ListCampaigns extends StatefulWidget {
  const ListCampaigns({Key? key}) : super(key: key);

  @override
  _ListCampaignsState createState() => _ListCampaignsState();
}

class _ListCampaignsState extends State<ListCampaigns>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCampaignBloc, MyCampaignState>(
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
            );
          case CampaignStatus.success:
            if (state.campaigns.isEmpty) {
              return Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  'Bạn chưa tham gia vào chiến dịch nào',
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
                                                  reverseDuration: const Duration(milliseconds: 400),
                                                  type: PageTransitionType.rightToLeftJoined,
                                                  child:
                                                      MyCampaignDetailScreen(campaignId: state.campaigns[index].id as int,),
                                                  childCurrent: const MyCampaignScreen()));
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
    if (_isBottom) context.read<MyCampaignBloc>().add(CampaignFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
