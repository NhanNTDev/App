import 'dart:async';
import 'dart:convert';
import 'package:farmer_application/src/feature/model/campaign.dart';
import 'package:farmer_application/src/feature/repository/campaign_repository.dart';
import 'package:farmer_application/src/feature/screen/join_campaign/join_campaign_detail/join_campaign_detail_screen.dart';
import 'package:farmer_application/src/feature/screen/join_campaign/join_campaign_screen.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../share/constants/app_constant.dart';

class SearchJoinCampaignScreen extends StatefulWidget {
  final String farmerId;

  const SearchJoinCampaignScreen({Key? key, required this.farmerId}) : super(key: key);

  @override
  _SearchJoinCampaignScreenState createState() => _SearchJoinCampaignScreenState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(const Duration(milliseconds: Duration.millisecondsPerSecond), action,);
  }
}

class _SearchJoinCampaignScreenState extends State<SearchJoinCampaignScreen> {
  final _campaignRepository = CampaignRepository();
  List<SearchJoinCampaign> listSearch = [];
  List<SearchJoinCampaign> listSearchCampaign = [];
  final _debouncer = Debouncer();
  bool isCall = true;

  Future<void> getListJoinCampaignByName() async {
    listSearch = await _campaignRepository.getJoinCampaignByName('', widget.farmerId);
    setState(() {
      isCall = false;
      if (listSearch.isNotEmpty) {
        listSearchCampaign = listSearch;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getListJoinCampaignByName();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listSearch = [];
    listSearchCampaign = [];
    isCall = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: Container(
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              titleSpacing: 0, toolbarHeight: 80, leadingWidth: 40,
              backgroundColor: Colors.white, elevation: 1,
              title: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 240, 240, 1.0),
                  borderRadius: BorderRadius.circular(25.0),),
                margin: EdgeInsets.only(right: 10),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Color.fromRGBO(240, 240, 240, 1.0)),),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.blue,),
                    ),
                    prefixIcon: InkWell(child: Icon(Icons.search),),
                    contentPadding: EdgeInsets.all(15.0),
                    hintText: 'Nhập tên chiến dịch tìm kiếm',
                    hintStyle: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                        fontSize: 12.sp, color: Color.fromRGBO(124, 130, 141, 1.0)),),
                  onChanged: (string) {
                    _debouncer.run(() {
                      setState(() {
                        listSearchCampaign = listSearch
                            .where((u) => (u.name.toLowerCase().contains(string.toLowerCase(),)),).toList();
                      });
                    });
                  },
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                //Search Bar to List of typed Subject
                SizedBox(
                  height: 20,
                ),
                isCall == false
                    ? Expanded(
                        child: listSearchCampaign.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                itemCount: listSearchCampaign.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(color: Colors.grey.shade300,),),
                                    child: TextButton(
                                      child: Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            listSearchCampaign[index].image1 != ''
                                                ? SizedBox(
                                                    width: 60,
                                                    height: 70,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: Image.network(
                                                        listSearchCampaign[index].image1,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                            SizedBox(width: 8,),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 252,
                                                  alignment: Alignment.centerLeft,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      IconWidget(
                                                          icon: Iconsax.location,
                                                          color: Colors.redAccent,
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.w500),
                                                      SizedBox(width: 3,),
                                                      Text(
                                                        listSearchCampaign[index].campaignZoneName,
                                                        style: TextStyle(
                                                            fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                                            fontSize: 10.sp, color: Color.fromRGBO(61, 55, 55, 0.8)),),
                                                      Spacer(),
                                                      Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                                                        decoration: BoxDecoration(
                                                            color: Color.fromRGBO(60, 190, 232, 0.8),
                                                            borderRadius: BorderRadius.circular(4)),
                                                        child: Text(
                                                          listSearchCampaign[index].status,
                                                          style: TextStyle(
                                                              fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                                              fontSize: 9.sp, color: Color.fromRGBO(255, 255, 255, 1.0)),),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 6,),
                                                Container(
                                                  width: 252,
                                                  child: Text(
                                                    listSearchCampaign[index].name,
                                                    style: TextStyle(
                                                        fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                                        fontSize: 14.sp, color: Colors.black),),),
                                                SizedBox(height: 3,),
                                                SizedBox(height: 2,),
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      IconWidget(icon: Iconsax.house_2, color: Colors.black,
                                                          fontSize: 11.sp, fontWeight: FontWeight.w500),
                                                      SizedBox(width: 4,),
                                                      Text(
                                                        'Các nông trại đủ điều kiện: ',
                                                        style: TextStyle(
                                                            fontFamily: 'BeVietnamPro',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 11.sp,
                                                            color: Colors.black),)
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 2,),
                                                Container(
                                                  width: 252,
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: listSearchCampaign[index].farms
                                                              .map((item) => Container(
                                                                      child: Text("- " + item,
                                                                    style: TextStyle(
                                                                        fontFamily: 'BeVietnamPro',
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 11.sp,
                                                                        color: Color.fromRGBO(61, 55, 55, 0.7)),
                                                                  ))).toList()),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          FocusScopeNode currentFocus = FocusScope.of(context);
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                        });
                                        Navigator.push(context, PageTransition(
                                                curve: Curves.easeInOut,
                                                duration: const Duration(milliseconds: 400),
                                                reverseDuration: const Duration(milliseconds: 400),
                                                type: PageTransitionType.rightToLeftJoined,
                                                child: JoinCampaignDetailScreen(
                                                  farmerId: widget.farmerId,
                                                  campaignId: listSearchCampaign[index].id as int,),
                                                childCurrent: const JoinCampaignScreen(initPage: 0,)));
                                      },
                                    ),
                                  );
                                },
                              )
                            : Container(
                                padding: const EdgeInsets.only(top: 30),
                                alignment: Alignment.center,
                                child: Text(
                                  'Không có kết quả tìm kiếm',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(height: 1.5, fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w400, fontSize: 11.sp, color: Colors.grey),),),
                      ) : Container(
                        padding: const EdgeInsets.only(top: 30),
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,),
                        )),
              ],
            ),
          ),
        ),
        tablet: SafeArea(child: Scaffold(appBar: AppBar(),),),
        desktop: SafeArea(child: Scaffold(appBar: AppBar(),),));
  }
}
