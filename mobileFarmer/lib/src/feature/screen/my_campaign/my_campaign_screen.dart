import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/repository/campaign_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/my_campaign_header.dart';
import 'components/list_campaigns.dart';
import 'my_campaign_bloc.dart';
import 'package:http/http.dart' as http;

class MyCampaignScreen extends StatefulWidget {
  const MyCampaignScreen({Key? key}) : super(key: key);

  @override
  _MyCampaignScreenState createState() => _MyCampaignScreenState();
}

class _MyCampaignScreenState extends State<MyCampaignScreen> {
  final CampaignRepository _campaignRepository = CampaignRepository();
  int countCampaign = 0;
  String farmerId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFarmerId();
  }

  @override
  void dispose() {
    countCampaign = 0;
    farmerId = '';
    super.dispose();
  }

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

  Future getCountCampaign(String farmerId) async{
    final campaigns = await _campaignRepository.getCountJoinedCampaignByFarmer(farmerId);
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
              create: (_) => MyCampaignBloc(httpClient: http.Client(), farmerId: farmerId)
                ..add(CampaignFetched()),
              child: const ListCampaigns(),
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
                MyCampaignHeader(countCampaigns: countCampaign,farmerId: farmerId,),
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
