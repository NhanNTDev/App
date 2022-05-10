import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/model/campaign.dart';
import 'package:farmer_application/src/feature/repository/campaign_repository.dart';
import 'package:farmer_application/src/feature/screen/harvest_in_campaign/harvest_in_campaign_screen.dart';
import 'package:farmer_application/src/share/constants/converts.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skeletons/skeletons.dart';

import 'components/header.dart';

class MyCampaignDetailScreen extends StatefulWidget {
  final int campaignId;

  const MyCampaignDetailScreen({Key? key, required this.campaignId}) : super(key: key);

  @override
  _MyCampaignDetailScreenState createState() => _MyCampaignDetailScreenState();
}

class _MyCampaignDetailScreenState extends State<MyCampaignDetailScreen> {
  final CampaignRepository _campaignRepository = CampaignRepository();
  CampaignJoinedDetail _campaign = CampaignJoinedDetail(name: '', image1: '', image2: '', image3: '', image4: '', image5: '',
      type: '', description: '', startAt: '', endAt: '', status: '', farmInCampaign: 0, farms: [], campaignDeliveryZones: [],
      endRecruitmentAt: '', productSalesCampaigns: [], campaignZoneId: 0, campaignZoneName: '');

  List<String> listImages = [];
  bool isLoading = true;
  String farmerId = '';

  _getFarmerId() async {
    final all = await storage.readAll();
    setState(() {
      all.entries.map((entry) => {
                if (entry.key == 'userId')
                  {
                    farmerId = entry.value,
                    if (farmerId != '')
                      {getCampaignJoinedById(widget.campaignId, farmerId)}
                  }
              }).toList(growable: false);
    });
  }

  Future<void> getCampaignJoinedById(int campaignId, String farmerId) async {
    _campaign = await _campaignRepository.getCampaignJoinedById(campaignId, farmerId);
    if (mounted) {
      setState(() {
        if (_campaign.name != '') {isLoading = false;}
        if (_campaign.image1 != '') {listImages.add(_campaign.image1);}
        if (_campaign.image2 != '') {listImages.add(_campaign.image2);}
        if (_campaign.image3 != '') {listImages.add(_campaign.image3);}
        if (_campaign.image4 != '') {listImages.add(_campaign.image4);}
        if (_campaign.image5 != '') {listImages.add(_campaign.image5);}
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFarmerId();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _campaign = CampaignJoinedDetail(name: '', image1: '', image2: '', image3: '', image4: '', image5: '', type: '',
        description: '', startAt: '', endAt: '', status: '', farmInCampaign: 0, farms: [], campaignDeliveryZones: [],
        endRecruitmentAt: '', productSalesCampaigns: [], campaignZoneName: '', campaignZoneId: 0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Skeleton(
              isLoading: isLoading,
              skeleton: SkeletonItem(
                child: Column(
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(width: double.infinity,
                        minHeight: MediaQuery.of(context).size.height / 5,
                        maxHeight: MediaQuery.of(context).size.height / 3,),),
                    const SizedBox(height: 20,),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(lines: 1, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,)),),
                    const SizedBox(height: 6),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(lines: 2, spacing: 3,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,)),),
                    const SizedBox(height: 12),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(lines: 6, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,)),),
                    const SizedBox(height: 8),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(lines: 2, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: false, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,)),),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: double.infinity,
                          minHeight: MediaQuery.of(context).size.height / 4,
                          maxHeight: MediaQuery.of(context).size.height / 3,),),),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(lines: 1, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,)),),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const JoinCampaignDetailHeader(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(_campaign.name,
                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 16.sp, color: Color.fromRGBO(61, 55, 55, 1.0)),),),),
                    SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: _campaign.status == "Đang diễn ra"
                                    ? const Color.fromRGBO(95, 212, 144, 1.0) : Colors.amber),
                            child: Text(_campaign.status,
                              style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                  fontSize: 11.sp, color: Colors.white),),),
                          const Spacer(),
                          IconWidget(icon: Iconsax.profile_2user, color: Colors.black,
                              fontSize: 13.sp, fontWeight: FontWeight.w600),
                          SizedBox(width: 4,),
                          Text(_campaign.farmInCampaign.toString(),
                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                fontSize: 14.sp, color: Color.fromRGBO(61, 55, 55, 1)),)
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconWidget(icon: Iconsax.location, color: Colors.redAccent,
                              fontSize: 14.sp, fontWeight: FontWeight.w600),
                          SizedBox(width: 3,),
                          Text('Địa điểm: ',
                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                fontSize: 12.sp, color: Colors.black),),
                          SizedBox(width: 3,),
                          Text(_campaign.campaignZoneName,
                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                fontSize: 12.sp, color: Color.fromRGBO(61, 55, 55, 0.8)),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconWidget(icon: Iconsax.calendar_tick, color: Color.fromRGBO(95, 212, 144, 1.0),
                              fontSize: 14.sp, fontWeight: FontWeight.w600),
                          SizedBox(width: 3,),
                          Text('Được tham gia từ ',
                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                fontSize: 12.sp, color: Colors.black),),
                          SizedBox(width: 3,),
                          _campaign.startAt != '' && _campaign.endRecruitmentAt != ''
                              ? Text(convertFormatDate(DateTime.parse(_campaign.startAt)) +
                                      " - " + convertFormatDate(DateTime.parse(_campaign.endRecruitmentAt)),
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                      fontSize: 12.sp, color: Color.fromRGBO(61, 55, 55, 0.8)),) : Container(),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconWidget(icon: Iconsax.calendar_tick, color: Color.fromRGBO(95, 212, 144, 1.0),
                              fontSize: 14.sp, fontWeight: FontWeight.w600),
                          SizedBox(width: 3,),
                          Text('Bắt đầu mở bán: ',
                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                fontSize: 12.sp, color: Colors.black),),
                          SizedBox(width: 3,),
                          Text(_campaign.endRecruitmentAt != ''
                              ? convertFormatDate(DateTime.parse(_campaign.endRecruitmentAt)) : '',
                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                fontSize: 12.sp, color: Color.fromRGBO(61, 55, 55, 0.8)),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconWidget(icon: Iconsax.calendar_remove, color: Color.fromRGBO(255, 84, 84, 1.0),
                              fontSize: 14.sp, fontWeight: FontWeight.w600),
                          SizedBox(width: 3,),
                          Text('Kết thúc chiến dịch: ',
                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                fontSize: 12.sp, color: Colors.black),),
                          SizedBox(width: 3,),
                          Text(
                            _campaign.endAt != '' ? convertFormatDate(DateTime.parse(_campaign.endAt)) : '',
                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                fontSize: 12.sp, color: Color.fromRGBO(61, 55, 55, 0.8)),),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: MediaQuery.of(context).size.height * .25,
                      child: listImages.isNotEmpty ? ImageSlideshow(
                              width: double.infinity,
                              indicatorPosition: 10, height: 250, initialPage: 0,
                              indicatorColor: Colors.blue,
                              indicatorBackgroundColor: Colors.white,
                              onPageChanged: (value) {},
                              autoPlayInterval: 5000,
                              isLoop: true,
                              children: listImages.map(
                                    (item) => ClipRRect(
                                      child: Image.network(item, fit: BoxFit.cover,),
                                      borderRadius: BorderRadius.circular(10),
                                    ),).toList()) : Container(),),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          IconWidget(icon: Iconsax.message_question, color: Color.fromRGBO(255, 210, 95, 1.0),
                              fontSize: 16.sp, fontWeight: FontWeight.w700),
                          SizedBox(width: 5,),
                          Text('Mô tả:', style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                fontSize: 13.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Text('- ' + _campaign.description,
                        style: TextStyle(height: 1.5, fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w400, fontSize: 12.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          IconWidget(icon: Iconsax.box_1, color: Colors.grey,
                              fontSize: 16.sp, fontWeight: FontWeight.w700),
                          SizedBox(width: 5,),
                          Text('Các mặt hàng được bán:',
                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                fontSize: 13.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _campaign.productSalesCampaigns.map((item) =>
                            Text('- ${item.productName} (tối đa ${item.capacity} ${item.unit})',
                                  style: TextStyle(height: 1.5, fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w400, fontSize: 12.sp,
                                      color: Color.fromRGBO(78, 80, 83, 1.0)),)).toList(),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Image.asset('assets/icons/group.png', width: 20,),
                          SizedBox(width: 5,),
                          Text('Khu vực bán hàng:',
                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                fontSize: 13.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _campaign.campaignDeliveryZones.map((item) => Text(
                                  '- Khu vực ${_campaign.campaignDeliveryZones.indexOf(item) + 1}: ' + item,
                                  style: TextStyle(height: 1.5, fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w400, fontSize: 12.sp,
                                      color: Color.fromRGBO(78, 80, 83, 1.0)),)).toList(),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          IconWidget(icon: Iconsax.house_2, color: Color.fromRGBO(95, 212, 144, 1.0),
                              fontSize: 16.sp, fontWeight: FontWeight.w700),
                          SizedBox(width: 5,),
                          Text('Nông trại đã tham gia: ',
                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                fontSize: 13.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _campaign.farms.map((item) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Text('- ' + item.farmName,
                                        style: TextStyle(height: 1.5, fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.w400, fontSize: 12.sp,
                                            color: Color.fromRGBO(78, 80, 83, 1.0)),),
                                      Spacer(),
                                      Container(
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.amber),
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(context,
                                                  PageTransition(curve: Curves.easeInOut,
                                                      duration: const Duration(milliseconds: 400),
                                                      reverseDuration: const Duration(milliseconds: 400),
                                                      type: PageTransitionType.rightToLeftJoined,
                                                      child: HarvestInCampaignScreen(
                                                        campaignId: widget.campaignId,
                                                        farmId: item.farmId,
                                                        farmName: item.farmName,
                                                        status: _campaign.status,
                                                        campaignName: _campaign.name,),
                                                      childCurrent:
                                                          MyCampaignDetailScreen(campaignId: widget.campaignId)));
                                            },
                                            child: Text(
                                              'Cập nhật',
                                              style: TextStyle(
                                                  fontFamily: 'BeVietnamPro',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11.sp,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ],
                                  ),)).toList(),
                      ),
                    ),
                    SizedBox(height: 30,),
                  ],
                ),
              ),
            ),
          ),
        ),
        tablet: SafeArea(child: Scaffold(appBar: AppBar(),),),
        desktop: SafeArea(child: Scaffold(appBar: AppBar(),),));
  }
}
