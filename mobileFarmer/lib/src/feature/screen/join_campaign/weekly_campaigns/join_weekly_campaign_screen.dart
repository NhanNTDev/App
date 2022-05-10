import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/repository/campaign_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../share/widget/stateless/icon_widget.dart';
import '../join_campaign_screen.dart';
import '../search_join_campaign/search_join_campaign_screen.dart';
import 'components/list_weekly_campaigns.dart';
import 'join_weekly_campaign_bloc.dart';
import 'package:http/http.dart' as http;

class JoinWeeklyCampaignScreen extends StatefulWidget {
  const JoinWeeklyCampaignScreen({Key? key}) : super(key: key);

  @override
  _JoinWeeklyCampaignScreenState createState() => _JoinWeeklyCampaignScreenState();
}

class _JoinWeeklyCampaignScreenState extends State<JoinWeeklyCampaignScreen> {
  final CampaignRepository _campaignRepository = CampaignRepository();
  int countCampaign = 0;
  String farmerId = '';

  _getFarmerId() async {
    final all = await storage.readAll();
    setState(() {
      all.entries
          .map((entry) => {
        if (entry.key == 'userId')
          {
            farmerId = entry.value,
            if (farmerId != '') {getCountCampaign(farmerId)}
          }
      })
          .toList(growable: false);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFarmerId();
  }

  @override
  void dispose() {
    countCampaign = 0;
    super.dispose();
  }

  Future getCountCampaign(String farmerId) async {
    final campaigns = await _campaignRepository.getCountCampaignCanApplyByFarmer(farmerId, 'weekly');
    if (mounted) {
      setState(() {
        countCampaign = campaigns;
      });
    }
  }

  Widget listCampaign() {
    if (farmerId != '') {
      return Expanded(
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (_) => JoinWeeklyCampaignBloc(httpClient: http.Client(), farmerId: farmerId)
                ..add(WeeklyCampaignFetched()),
              child: ListWeeklyCampaigns(farmerId: farmerId,),
            ),
          ));
    }
    return Container(
      padding: EdgeInsets.only(top: 30),
      alignment: Alignment.center,
      child: Text(
        'Đã có lỗi xảy ra',
        textAlign: TextAlign.justify,
        style: TextStyle(height: 1.5, fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w400, fontSize: 11.sp, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hiện có '+ countCampaign.toString() + ' chiến dịch',
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                            color: Colors.grey),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 38,
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(curve: Curves.easeInOut,
                                  duration: const Duration(milliseconds: 400),
                                  reverseDuration: const Duration(milliseconds: 400),
                                  type: PageTransitionType.rightToLeftJoined,
                                  child: SearchJoinCampaignScreen(farmerId: farmerId,),
                                  childCurrent: const JoinCampaignScreen(initPage: 2,)));
                        },
                        child: IconWidget(
                            icon: Iconsax.search_normal,
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),

                listCampaign()
              ],
            ),
          ),
        ),
        tablet: Scaffold(
          appBar: AppBar(),
        ),
        desktop: Scaffold(
          appBar: AppBar(),
        ));
  }
}
