import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/model/harvest_in_campaign.dart';
import 'package:farmer_application/src/feature/repository/harvest_in_campaign_repository.dart';
import 'package:farmer_application/src/feature/screen/harvest_in_campaign/update_harvest_in_campaign/update_harvest_in_campaign_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:farmer_application/src/share/widget/stateless/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../share/constants/app_uidata.dart';
import '../harvest_in_campaign_screen.dart';

class HarvestInCampaignDetailScreen extends StatefulWidget {
  final int harvestInCampaignId;
  final int campaignId;
  final int farmId;
  final String status;
  const HarvestInCampaignDetailScreen({Key? key, required this.harvestInCampaignId, required this.campaignId, required this.farmId, required this.status}) : super(key: key);

  @override
  _HarvestInCampaignDetailScreenState createState() => _HarvestInCampaignDetailScreenState();
}



class _HarvestInCampaignDetailScreenState extends State<HarvestInCampaignDetailScreen> {
  final _harvestInCampaignRepository = HarvestInCampaignRepository();
  HarvestInCampaignDetail _harvestInCampaign = HarvestInCampaignDetail(image1: '', image2: '', image3: '', image4: '',
      image5: '', harvestName: '', productName: '', productSystemName: '', productCategoryName: '', price: 0,
      unit: '', valueChangeOfUnit: 0, inventory: 0, status: '', harvestDescription: '', harvestId: 0, quantity: 0, campaignName: '', farmName: '', campaignId: 0);
  List<String> listImages = [];
bool isLoading = true;
bool isCall = false;
int statusCode = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.farmId);
    print(widget.campaignId);
    getHarvestInCampaignById(widget.harvestInCampaignId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listImages = [];
    isLoading = true;
    isCall = false;
    _harvestInCampaign = HarvestInCampaignDetail(image1: '', image2: '', image3: '', image4: '',
        image5: '', harvestName: '', productName: '', productSystemName: '', productCategoryName: '', price: 0,
        unit: '', valueChangeOfUnit: 0, inventory: 0, status: '', harvestDescription: '', harvestId: 0, quantity: 0, campaignName: '', farmName: '', campaignId: 0);
    super.dispose();
  }

  Future<void> getHarvestInCampaignById(int harvestInCampaignId) async {
    _harvestInCampaign = await _harvestInCampaignRepository.getHarvestInCampaignById(harvestInCampaignId);
    if(mounted){
      setState(() {
        if(_harvestInCampaign.productName != ''){
          isLoading = false;
        }
        if (_harvestInCampaign.image1 != '') {
          listImages.add(_harvestInCampaign.image1);
        }
        if (_harvestInCampaign.image2 != '') {
          listImages.add(_harvestInCampaign.image2);
        }
        if (_harvestInCampaign.image3 != '') {
          listImages.add(_harvestInCampaign.image3);
        }
        if (_harvestInCampaign.image4 != '') {
          listImages.add(_harvestInCampaign.image4);
        }
        if (_harvestInCampaign.image5 != '') {
          listImages.add(_harvestInCampaign.image5);
        }
      });
    }
  }


  Future<void> deleteHarvestInCampaing(int harvestInCampaignId) async{
    statusCode = await _harvestInCampaignRepository.deleteHarvestInCampaign(harvestInCampaignId);
    setState(() {
      if(statusCode == 200){
        isCall = false;
        UIData.toastMessage("Xóa thành công");
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  HarvestInCampaignScreen(campaignId: widget.campaignId, farmId: widget.farmId, farmName: _harvestInCampaign.farmName, status: "Sắp mở bán", campaignName: _harvestInCampaign.campaignName)),
        );
      }else{
        isCall = false;
        UIData.toastMessage("Xóa thất bại");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Skeleton(
              isLoading: isLoading,
              // skeleton: SkeletonListView(),
              skeleton: SkeletonItem(child: Column(
                children: [
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: double.infinity,
                      minHeight: MediaQuery.of(context).size.height / 5,
                      maxHeight: MediaQuery.of(context).size.height / 3,
                    ),
                  ),
                  SizedBox(height: 20,),
                  SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 1,
                        spacing: 8,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 2,
                        )),
                  ),
                  SizedBox(height: 6),

                  SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 1,
                        spacing: 3,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 2,
                        )),
                  ),
                  SizedBox(height: 12),
                  SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 6,
                        spacing: 8,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 2,
                        )),
                  ),
                  SizedBox(height: 8),
                  SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 1,
                        spacing: 8,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 2,
                        )),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: double.infinity,
                        minHeight: MediaQuery.of(context).size.height / 4,
                        maxHeight: MediaQuery.of(context).size.height / 3,
                      ),
                    ),
                  ),
                  SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 1,
                        spacing: 8,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 2,
                        )),
                  ),
                ],
              ),

              ),
              child: ProgressHUD(
                inAsyncCall: isCall,
                child: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      // The containers in the background
                      Column(
                        children: <Widget>[
                          Container(
                            // height: MediaQuery.of(context).size.height * .65,
                            height: MediaQuery.of(context).size.height * .45,
                            color: Colors.grey,
                            child: listImages.isNotEmpty ? ImageSlideshow(
                                width: double.infinity,
                                indicatorPosition: 10,
                                // height: 200,
                                height: 350,
                                initialPage: 0,
                                indicatorColor: Colors.blue,
                                indicatorBackgroundColor: Colors.grey,
                                onPageChanged: (value) {
                                },
                                autoPlayInterval: 5000,
                                isLoop: true,
                                children: listImages
                                    .map(
                                      (item) => Image.network(
                                    item,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    .toList()
                            ) :Container(),
                          ),

                          Container(
                            alignment: Alignment.topCenter,
                            // height: MediaQuery.of(context).size.height * .5,
                            padding: EdgeInsets.symmetric(
                                horizontal: kPaddingDefault * 2),
                            color: Colors.white,
                            child: Container(
                              // height: 100,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          _harvestInCampaign.productName,
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17.sp,
                                              color: Color.fromRGBO(78, 80, 83, 1.0)),
                                        ),
                                      ),
                                      Spacer(),
                                      checkStatus(_harvestInCampaign.status),
                                    ],
                                  ),

                                  SizedBox(height: 20,),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconWidget(
                                          icon: Iconsax.message_question,
                                          color: Color.fromRGBO(240, 192, 69, 1.0),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Thông tin chi tiết:',
                                        style: TextStyle(
                                            fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        child: Text(
                                          'Chiến dịch:',
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Color.fromRGBO(78, 80, 83, 1.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 257,
                                        child: Text(
                                          _harvestInCampaign.campaignName,
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Color.fromRGBO(78, 80, 83, 1.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        child: Text(
                                          'Nông trại:',
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Color.fromRGBO(78, 80, 83, 1.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 257,
                                        child: Text(
                                          _harvestInCampaign.farmName,
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Color.fromRGBO(78, 80, 83, 1.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        child: Text(
                                          'Mùa:',
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Color.fromRGBO(78, 80, 83, 1.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        _harvestInCampaign.harvestName,
                                        style: TextStyle(
                                            fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                            color: Color.fromRGBO(78, 80, 83, 1.0)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        child: Text(
                                          'Sản phẩm:',
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Color.fromRGBO(78, 80, 83, 1.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        _harvestInCampaign.productSystemName,
                                        style: TextStyle(
                                            fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                            color: Color.fromRGBO(78, 80, 83, 1.0)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        child: Text(
                                          'Giá:',
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Color.fromRGBO(78, 80, 83, 1.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Row(
                                        children: [

                                          Text(
                                          _harvestInCampaign.price.toString() + ' vnd/',
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Color.fromRGBO(78, 80, 83, 1.0))),
                                          Text(
                                              _harvestInCampaign.unit,
                                              style: TextStyle(
                                                  fontFamily: 'BeVietnamPro',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.sp,
                                                  color: Color.fromRGBO(78, 80, 83, 1.0))),
                                          _harvestInCampaign.valueChangeOfUnit != 1 ? Text(
                                              '~ ' + _harvestInCampaign.valueChangeOfUnit.toString() +  ' kg',
                                              style: TextStyle(
                                                  fontFamily: 'BeVietnamPro',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.sp,
                                                  color: Color.fromRGBO(78, 80, 83, 1.0))) : Container(),
                                          ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        child: Text(
                                          'Nhập kho:',
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Color.fromRGBO(78, 80, 83, 1.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        _harvestInCampaign.inventory.toString() + " " + _harvestInCampaign.unit,
                                        style: TextStyle(
                                            fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                            color: Color.fromRGBO(78, 80, 83, 1.0)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        child: Text(
                                          'Hiện có:',
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Color.fromRGBO(78, 80, 83, 1.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        _harvestInCampaign.quantity.toString() + " " + _harvestInCampaign.unit,
                                        style: TextStyle(
                                            fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                            color: Color.fromRGBO(78, 80, 83, 1.0)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconWidget(
                                          icon: Iconsax.info_circle,
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Thông tin về mùa vụ:',
                                        style: TextStyle(
                                            fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.sp,
                                            color: Color.fromRGBO(78, 80, 83, 1.0)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 3,),
                                  _harvestInCampaign.harvestDescription != '' ? Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '- ' + _harvestInCampaign.harvestDescription,
                                      style: TextStyle(
                                          height: 1.5,
                                          fontFamily: 'BeVietnamPro',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                          color: Color.fromRGBO(78, 80, 83, 1.0)),
                                    ),
                                  ): Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Chưa có thông tin về mùa vụ của sản phẩm này',
                                      style: TextStyle(
                                          height: 1.5,
                                          fontFamily: 'BeVietnamPro',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      // The card widget with top padding,
                      // incase if you wanted bottom padding to work,
                      // set the `alignment` of container to Alignment.bottomCenter
                      Container(
                        height: 60,
                        color: Colors.grey.withOpacity(0.45),
                        child: Row(
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: IconWidget(
                                  icon: Iconsax.arrow_left,
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                )),
                            Spacer(),
                            _harvestInCampaign.status == "Chờ xác nhận" ? Container(
                              padding: EdgeInsets.only(right: 10),
                              child: PopupMenuButton(
                                onSelected: (index) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text('Xác nhận'),
                                            content: const Text(
                                                'Bạn muốn xóa sản phẩm này?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context, 'Cancel'),
                                                child: const Text('Không'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isCall = true;
                                                    Navigator.pop(context, 'OK');
                                                    deleteHarvestInCampaing(widget.harvestInCampaignId);
                                                  });
                                                },
                                                child: const Text('Có'),
                                              ),
                                            ],
                                          ),
                                    );
                                },
                                onCanceled: () {},
                                initialValue: 2,
                                child: IconWidget(
                                  icon: Iconsax.more,
                                  color: Colors.white,
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                itemBuilder: (context) {
                                  return List.generate(1, (index) {
                                    return PopupMenuItem(
                                      value: index,
                                      child: Row(
                                        children: [
                                          IconWidget(
                                              icon: Iconsax.trash,
                                              color: Color.fromRGBO(
                                                  107, 114, 128, 1.0),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            'Xóa sản phẩm',
                                            style: TextStyle(
                                                fontFamily: 'BeVietnamPro',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp,
                                                color: Color.fromRGBO(
                                                    78, 80, 83, 1.0)),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                              ),
                            ) : Container(),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
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

  Widget checkStatus(String status) {
    if (status == "Đã được xác nhận") {
      return Text(
        _harvestInCampaign.status,
        style: TextStyle(
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            color: Color.fromRGBO(95, 212, 144, 1.0)),
      );
    } else if (status == "Chờ xác nhận") {
      return Text(
        _harvestInCampaign.status,
        style: TextStyle(
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            color: Colors.amber),
      );
    }
    return Text(
      _harvestInCampaign.status,
      style: TextStyle(
          fontFamily: 'BeVietnamPro',
          fontWeight: FontWeight.w600,
          fontSize: 11.sp,
          color: Colors.redAccent),
    );
  }
}
