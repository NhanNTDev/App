import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/repository/harvest_in_campaign_repository.dart';
import 'package:farmer_application/src/feature/repository/harvest_repository.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import 'components/harvest_in_campaign_header.dart';
import 'components/list_harvests_in_campaign.dart';
import 'harvest_in_campaign_bloc.dart';

class HarvestInCampaignScreen extends StatefulWidget {
  final int campaignId;
  final int farmId;
  final String farmName;
  final String status;
  final String campaignName;

  const HarvestInCampaignScreen(
      {Key? key,
      required this.campaignId,
      required this.farmId,
      required this.farmName,
      required this.status,
      required this.campaignName})
      : super(key: key);

  @override
  _HarvestInCampaignScreenState createState() =>
      _HarvestInCampaignScreenState();
}

class _HarvestInCampaignScreenState extends State<HarvestInCampaignScreen> {
  final HarvestInCampaignRepository _harvestInCampaignRepository =
      HarvestInCampaignRepository();
  int countHarvests = 0;
  String farmerId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountHarvestsInCampaign();
    print(widget.campaignId);
    print(widget.farmId);
  }

  @override
  void dispose() {
    countHarvests = 0;
    super.dispose();
  }

  Future getCountHarvestsInCampaign() async {
    final harvests = await _harvestInCampaignRepository
        .getCountHarvestInCampaign(widget.campaignId, widget.farmId);
    if (mounted) {
      setState(() {
        countHarvests = harvests;
      });
    }
  }

  // _getFarmerId() async {
  //   final all = await storage.readAll();
  //   setState(() {
  //     all.entries
  //         .map((entry) => {
  //               if (entry.key == 'userId')
  //                 {
  //                   farmerId = entry.value,
  //                   if (farmerId != '') {getCountHarvests(farmerId)}
  //                 }
  //             })
  //         .toList(growable: false);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                HarvestIncampaignHeader(
                  countHarvests: countHarvests,
                  status: widget.status,
                  campaignId: widget.campaignId,
                  farmId: widget.farmId,
                  farmName: widget.farmName,
                  campaignName: widget.campaignName,
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                    child: Row(
                      children: [
                        IconWidget(
                            icon: Iconsax.house_2,
                            color: Colors.grey,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.farmName,
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ],
                    )),
                Expanded(
                    child: SingleChildScrollView(
                  child: BlocProvider(
                    create: (_) => HarvestInCampaignBloc(
                        httpClient: http.Client(),
                        farmId: widget.farmId,
                        campaignId: widget.campaignId)
                      ..add(HarvestInCampaignFetched()),
                    child: ListHarvestsInCampaign(
                      farmId: widget.farmId,
                      campaignId: widget.campaignId,
                      farmName: widget.farmName,
                      status: widget.status,
                      campaignName: widget.campaignName,
                    ),
                  ),
                )),
                SizedBox(
                  height: 10,
                )
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
