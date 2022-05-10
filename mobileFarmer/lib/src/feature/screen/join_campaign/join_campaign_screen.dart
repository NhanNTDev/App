import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/screen/join_campaign/all_campaigns/join_all_campaign_screen.dart';
import 'package:farmer_application/src/feature/screen/join_campaign/weekly_campaigns/join_weekly_campaign_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../share/constants/app_constant.dart';
import 'event_campaigns/join_event_campaign_screen.dart';

class JoinCampaignScreen extends StatefulWidget {
  final int initPage;
  const JoinCampaignScreen({Key? key, required this.initPage}) : super(key: key);

  @override
  _JoinCampaignScreenState createState() => _JoinCampaignScreenState();
}

class _JoinCampaignScreenState extends State<JoinCampaignScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  int countCampaign = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: DefaultTabController(
            initialIndex: widget.initPage,
            length: 5,
            child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 70,
                  backgroundColor: kBlueDefault,
                  elevation: 0,
                  leading: Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  leadingWidth: 10,
                  title: Center(
                    child: Text('Tham gia chiến dịch',
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: Colors.white)),
                  ),
                ),
                body: Column(
                  children: [
                    Container(
                      color: kBlueDefault,
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3.0,
                        isScrollable: true,
                        labelColor: Colors.black87,
                        unselectedLabelColor: Colors.black45,
                        tabs: <Widget>[
                          Tab(
                              child: Text('Tất cả',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.sp,
                                      color: Colors.white))),
                          Tab(
                              child: Text('Chiến dịch sự kiện',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.sp,
                                      color: Colors.white))),
                          Tab(
                              child: Text('Chiến dịch hàng tuần',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.sp,
                                      color: Colors.white))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: const <Widget>[
                          Center(
                            child: JoinAllCampaignScreen(),
                          ),
                          Center(
                            child: JoinEventCampaignScreen(),
                          ),
                          Center(
                            child: JoinWeeklyCampaignScreen(),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
        tablet: SafeArea(
          child: Scaffold(
            appBar: AppBar(),
          ),
        ),
        desktop: SafeArea(
          child: Scaffold(
            appBar: AppBar(),
          ),
        ));
  }
}
