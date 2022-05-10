import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/model/harvest_in_campaign.dart';
import 'package:farmer_application/src/feature/repository/harvest_in_campaign_repository.dart';
import 'package:farmer_application/src/feature/repository/harvest_repository.dart';
import 'package:farmer_application/src/feature/screen/my_campaign/my_campaign_detail/my_campaign_detail_screen.dart';
import 'package:farmer_application/src/feature/screen/my_campaign/my_campaign_screen.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:farmer_application/src/share/constants/converts.dart';
import 'package:farmer_application/src/share/constants/validation.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:farmer_application/src/share/widget/stateless/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

import 'components/header.dart';

class CampaignApplyRequestScreen extends StatefulWidget {
  final int? campaignId;
  final String farmerId;
  final String campaignName;
  final String startAt;
  final String recruitmentEndAt;
  final String endAt;
  final String zoneName;

  const CampaignApplyRequestScreen(
      {Key? key,
      this.campaignId,
      required this.farmerId,
      required this.campaignName,
      required this.startAt,
      required this.recruitmentEndAt,
      required this.endAt,
      required this.zoneName}) : super(key: key);

  @override
  _CampaignApplyRequestScreenState createState() => _CampaignApplyRequestScreenState();
}

class HarvestInCampaignModel {
  final int? id;
  final String image;
  final String name;
  final String productName;
  final String unitSystem;
  final String farmName;
  String? unitChange;
  num? valueChange;
  num price;
  num priceChange;
  final num minPrice;
  final num maxPrice;
  final num inventoryHarvest;
  num inventoryTotal;
  num inventoryTotalChange;
  final num capacity;

  HarvestInCampaignModel({
    this.id, required this.image, required this.name, required this.productName,
    required this.unitSystem, this.unitChange, this.valueChange, required this.farmName,
    required this.price, required this.priceChange, required this.minPrice, required this.maxPrice,
    required this.inventoryHarvest, required this.inventoryTotal, required this.inventoryTotalChange, required this.capacity,
  });

  factory HarvestInCampaignModel.fromJson(Map<String, dynamic> json) {
    return HarvestInCampaignModel(
      id: json['id'],
      name: json['name'],
      productName: json['productName'],
      price: json['price'],
      priceChange: 0,
      image: json['image1'],
      unitSystem: json['unitSystem'],
      minPrice: json['minPrice'],
      maxPrice: json['maxPrice'],
      farmName: json['farmName'],
      inventoryHarvest: json['inventoryHarvest'],
      inventoryTotal: json['inventoryTotal'],
      inventoryTotalChange: 0,
      capacity: json['capacity'],
    );
  }

  // Magic goes here. you can use this function to from json method.
  static HarvestInCampaignModel fromJsonModel(Map<String, dynamic> json) =>
      HarvestInCampaignModel.fromJson(json);
}

class _CampaignApplyRequestScreenState
    extends State<CampaignApplyRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _harvestInCampaignRepository = HarvestInCampaignRepository();
  final _harvestRepository = HarvestRepository();

  List<HarvestInCampaignModel> listProducts = [];
  List<CreateHarvestInCampaign> listRequests = [];
  int statusCode = 0;
  int loadSuccess = 0;
  bool isPress = false;
  bool isCall = true;

  Future<void> getListHarvestSuggest() async {
    listProducts = await _harvestRepository.getHarvestSuggest(widget.farmerId, widget.campaignId as int);
    setState(() {if (listProducts.isNotEmpty) {isCall = false;loadSuccess = 200;} else {isCall = false;loadSuccess = 404;}});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListHarvestSuggest();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listProducts = [];
    listRequests = [];
    statusCode = 0;
    isPress = false;
    isCall = true;
    loadSuccess = 0;
    super.dispose();
  }

  Future<void> createHarvestInCampaign() async {
    statusCode = await _harvestInCampaignRepository.createListHarvestInCampaign(listRequests);
    setState(() {
      if (statusCode == 200) {
        isCall = false;
        UIData.toastMessage("Đăng kí thành công");
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, PageTransition(curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 400), reverseDuration: const Duration(milliseconds: 400),
              type: PageTransitionType.rightToLeftJoined, child: MyCampaignDetailScreen(campaignId: widget.campaignId as int,),
              childCurrent: const MyCampaignScreen()),
        );
      } else {isCall = false;}
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Responsive(
      mobile: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: ProgressHUD(
            inAsyncCall: isCall,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CampaignApplyRequestHeader(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.campaignName,
                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                            fontSize: 17.sp, color: const Color.fromRGBO(61, 55, 55, 1.0)),),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconWidget(icon: Iconsax.location, color: Colors.redAccent,
                            fontSize: 14.sp, fontWeight: FontWeight.w600),
                        const SizedBox(width: 3,),
                        Text('Địa điểm: ', style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 12.sp, color: Colors.black),),
                        const SizedBox(width: 3,),
                        Text(widget.zoneName, style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 12.sp, color: Colors.black),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconWidget(icon: Iconsax.calendar_tick, color: const Color.fromRGBO(95, 212, 144, 1.0),
                            fontSize: 14.sp, fontWeight: FontWeight.w600),
                        const SizedBox(width: 3,),
                        Text('Được tham gia từ ', style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 12.sp, color: Colors.black),),
                        const SizedBox(width: 3,),
                        widget.startAt != '' && widget.recruitmentEndAt != '' ? Text(
                                convertFormatDate(DateTime.parse(widget.startAt)) + " - " +
                                    convertFormatDate(DateTime.parse(widget.recruitmentEndAt)),
                                style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                    fontSize: 12.sp, color: Colors.black),) : Container(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconWidget(icon: Iconsax.calendar_tick, color: const Color.fromRGBO(95, 212, 144, 1.0),
                            fontSize: 14.sp, fontWeight: FontWeight.w600),
                        const SizedBox(width: 3,),
                        Text('Bắt đầu mở bán: ', style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 12.sp, color: Colors.black),),
                        const SizedBox(width: 3,),
                        Text(convertFormatDate(DateTime.parse(widget.recruitmentEndAt)),
                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 12.sp, color: Colors.black),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconWidget(icon: Iconsax.calendar_remove, color: const Color.fromRGBO(255, 84, 84, 1.0),
                            fontSize: 14.sp, fontWeight: FontWeight.w600),
                        const SizedBox(width: 3,),
                        Text('Kết thúc: ', style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 12.sp, color: Colors.black),),
                        const SizedBox(width: 3,),
                        Text(convertFormatDate(DateTime.parse(widget.endAt)),
                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 12.sp, color: Colors.black),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Lưu ý', style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                              fontSize: 10.sp, fontStyle: FontStyle.italic, color: Colors.grey),),
                        Text('*', style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 10.sp, color: Colors.redAccent),),
                        Text(':', style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                              fontSize: 10.sp, color: Colors.grey),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.centerLeft,
                    child: Text('- Cần ít nhất 1 sản phẩm để tham gia chiến dịch.',
                      style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic, fontSize: 10.sp, color: Colors.grey),),),
                  const SizedBox(height: 5,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.centerLeft,
                    child: Text('- Hệ thống sẽ tự động đưa ra danh sách sản phẩm của bạn phù hợp với chiến dịch.',
                      style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic, fontSize: 10.sp, color: Colors.grey),),),
                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Danh sách sản phẩm', style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                              fontSize: 13.sp, color: Colors.black),),
                        Text('*', style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 13.sp, color: Colors.redAccent),),
                        Text(':', style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                              fontSize: 13.sp, color: Colors.black),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10, top: 15),
                    width: _size.width * 0.92,
                    height: 380,
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(6)),
                    child: listProducts.isEmpty && loadSuccess != 0 ? Container(
                    child: Text(
                    'Hiện tại bạn không có sản phẩm nào phù hợp cho chiến dịch này',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1.5, fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w400, fontSize: 11.sp, color: Colors.grey),
                  ),
            ) :ListView.builder(
                      itemCount: listProducts.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text((index + 1).toString() + ".", style: TextStyle(fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w500, fontSize: 13.sp, color: Colors.black),),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(listProducts[index].image, width: 50, height: 50, fit: BoxFit.cover,),
                                  ),
                                  const SizedBox(width: 5,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(listProducts[index].name, style: TextStyle(fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.w500, fontSize: 12.sp,color: Colors.black),),
                                      const SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text(listProducts[index].productName + " - ", style: TextStyle(fontFamily: 'BeVietnamPro',
                                                fontWeight: FontWeight.w500, fontSize: 10.sp, color: Colors.black),),
                                          Text("SL: ", style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                                fontSize: 10.sp, color: Colors.grey),),
                                          listProducts[index].inventoryTotalChange == 0 ? Text(
                                            listProducts[index].inventoryTotal.round().toString() + " ",
                                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                                fontSize: 10.sp, color: Colors.black),) : Text(
                                            listProducts[index].inventoryTotalChange.round().toString() + " ",
                                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                                fontSize: 10.sp, color: Colors.black),),
                                          Text(listProducts[index].unitChange != null
                                                ? listProducts[index].unitChange.toString()
                                                : listProducts[index].unitSystem.toString(),
                                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                                fontSize: 10.sp, color: Colors.black),),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        children: [listProducts[index].priceChange == 0 ? Text(
                                            "(" + listProducts[index].price.toString() + "vnd/",
                                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                                fontSize: 10.sp, color: Colors.grey),) : Text(
                                            "(" + listProducts[index].priceChange.toString() + "vnd/",
                                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                                fontSize: 10.sp, color: Colors.grey),),
                                          listProducts[index].unitChange != null &&
                                                  listProducts[index].valueChange != null
                                              ? Text(listProducts[index].unitChange.toString() + " ~ " +
                                                      listProducts[index].valueChange.toString(),
                                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                                      fontSize: 10.sp, color: Colors.grey),) : Container(),
                                          Text(listProducts[index].unitSystem + ")", style: TextStyle(fontFamily: 'BeVietnamPro',
                                                fontWeight: FontWeight.w400, fontSize: 10.sp, color: Colors.grey),),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          IconWidget(icon: Iconsax.house_2, color: Colors.grey,
                                              fontSize: 11.sp, fontWeight: FontWeight.w500),
                                          const SizedBox(width: 3,),
                                          Text(listProducts[index].farmName.toString(),
                                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                                fontSize: 10.sp, color: Colors.grey),),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: 30,
                                    child: TextButton(
                                      onPressed: () {
                                        num valueChange = 0;
                                        String unitChange = '';
                                        if(listProducts[index].unitChange != null){
                                          unitChange = listProducts[index].unitChange.toString();
                                        }
                                        if(listProducts[index].valueChange != null){
                                          valueChange = listProducts[index].valueChange as num;
                                        }
                                        num price = listProducts[index].price;
                                        num priceChange = listProducts[index].priceChange;
                                        num inventoryTotal = listProducts[index].inventoryTotal;
                                        num inventoryTotalChange = listProducts[index].inventoryTotalChange;
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                                    title: const Center(
                                                        child: Text('Chỉnh sửa thông tin')),
                                                    content: SizedBox(
                                                      height: 480, width: 700,
                                                      child: SingleChildScrollView(
                                                        child: Form(
                                                          key: _formKey,
                                                          autovalidateMode: isPress ? AutovalidateMode.always : AutovalidateMode.disabled,
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(height: 15,),
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text('Mùa vụ: ',style: TextStyle(
                                                                      fontFamily: 'BeVietnamPro',
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 13.sp,
                                                                      color: Colors.black)),
                                                                  SizedBox(
                                                                    width: 218,
                                                                    child: Text(listProducts[index].name, style: TextStyle(
                                                                        fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                                                        fontSize: 13.sp, color: const Color.fromRGBO(61, 55, 55, 1.0))),),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 2,),
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text('Nông trại: ', style: TextStyle(
                                                                      fontFamily: 'BeVietnamPro',
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 13.sp, color: Colors.black)),
                                                                  SizedBox(
                                                                    width: 201,
                                                                    child: Text(listProducts[index].farmName, style: TextStyle(
                                                                        fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                                                        fontSize: 13.sp, color: const Color.fromRGBO(61, 55, 55, 1.0))),),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 10,),
                                                              Row(
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Row(
                                                                          children: [
                                                                            IconWidget(icon: Iconsax.box_1, color: Colors.grey,
                                                                                fontSize: 13.sp, fontWeight: FontWeight.w500),
                                                                            const SizedBox(width: 5,),
                                                                            Text('Tổng kho', style: TextStyle(
                                                                                    fontFamily: 'BeVietnamPro',
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontSize: 11.sp,
                                                                                    color: const Color.fromRGBO(61, 55, 55, 1.0))),
                                                                            // const SizedBox(width: 5,),
                                                                            Text('*', style: TextStyle(
                                                                                    fontFamily: 'BeVietnamPro',
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontSize: 13.sp, color: Colors.redAccent)),
                                                                            Text(':', style: TextStyle(
                                                                                    fontFamily: 'BeVietnamPro',
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontSize: 11.sp, color: Colors.black.withOpacity(0.5))),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const SizedBox(height: 8,),
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width: 282,
                                                                            child: TextFormField(
                                                                              textInputAction: TextInputAction.next,
                                                                              keyboardType: TextInputType.number,
                                                                              initialValue: inventoryTotal.toString(),
                                                                              validator: (value) {
                                                                                if (value!.trim().isEmpty) {
                                                                                  return 'Bạn cần phải nhập tổng kho';
                                                                                } else if (isPositiveNumber(value) == false) {
                                                                                  return 'Tổng kho phải là một số';
                                                                                }  else if (inventoryTotal <= 0) {
                                                                                  return 'Tổng kho phải lớn hơn 0';
                                                                                }
                                                                                else if (inventoryTotal > listProducts[index].capacity) {
                                                                                  return 'Chiến dịch chỉ cho phép bán loại sản phẩm\nnày tối đa ${listProducts[index].capacity} ${listProducts[index].unitSystem}';
                                                                                }
                                                                                return null;
                                                                              },
                                                                              decoration: InputDecoration(
                                                                                isDense: true,
                                                                                fillColor: Colors.white,
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                          color: Colors.grey.withOpacity(0.4),
                                                                                          width: 1, style: BorderStyle.solid),
                                                                                  borderRadius: BorderRadius.circular(0.0),
                                                                                ),
                                                                                border: OutlineInputBorder(
                                                                                  borderSide: const BorderSide(color: Colors.orange, width: 1.0),
                                                                                  borderRadius: BorderRadius.circular(0.0),
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide:
                                                                                  BorderSide(color: Colors.lightBlue.withOpacity(0.6), width: 2.5),
                                                                                  borderRadius: BorderRadius.circular(0),
                                                                                ),
                                                                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                hintText: "Nhập tổng kho",
                                                                                suffix:Text(listProducts[index].unitSystem),
                                                                                hintStyle: TextStyle(
                                                                                    fontFamily: 'BeVietnamPro',
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontSize: 11.sp,
                                                                                    color: Colors.grey),
                                                                              ),
                                                                              onChanged: (value) {
                                                                                try{
                                                                                  setState((){
                                                                                    inventoryTotal = num.parse(value);
                                                                                  });
                                                                                }on Exception catch(_){}
                                                                              },
                                                                            ),
                                                                          ),
                                                                          // Container(
                                                                          //   width: 50,
                                                                          //   height: 53,
                                                                          //   decoration: const BoxDecoration(
                                                                          //     color: Color.fromRGBO(231, 221, 221, 1.0),
                                                                          //   ),
                                                                          //   alignment: Alignment.center,
                                                                          //   child: Text(listProducts[index].unitSystem),)
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  // Spacer(),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 10,),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Row(
                                                                      children: [
                                                                        IconWidget(
                                                                            icon: Iconsax.money, color: Colors.grey,
                                                                            fontSize: 13.sp, fontWeight: FontWeight.w500),
                                                                        const SizedBox(width: 5,),
                                                                        Text('Giá sản phẩm', style: TextStyle(
                                                                                fontFamily: 'BeVietnamPro',
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 11.sp,
                                                                                color: Color.fromRGBO(61, 55, 55, 1.0))),
                                                                        Text('*', style: TextStyle(
                                                                                fontFamily: 'BeVietnamPro',
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 13.sp, color: Colors.redAccent)),
                                                                        Text(':', style: TextStyle(
                                                                                fontFamily: 'BeVietnamPro',
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 11.sp, color: Colors.black.withOpacity(0.5))),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 8,),
                                                                  Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 282,
                                                                        child: TextFormField(
                                                                          textInputAction: TextInputAction.next,
                                                                          keyboardType: TextInputType.number,
                                                                          initialValue: price.toString(),
                                                                          validator: (value) {
                                                                            if(value!.trim().isEmpty){
                                                                              return 'Bạn cần phải điền giá sản phẩm';
                                                                            } else if (isPositiveNumber(value) == false) {
                                                                              return 'Giá sản phẩm phải là một số';
                                                                            }  else if (price <= 0) {
                                                                              return 'Giá sản phẩm phải lớn hơn 0';
                                                                            } else if (price < listProducts[index].minPrice || price > listProducts[index].maxPrice) {
                                                                              return 'Giá của sản phẩm này phải từ ${listProducts[index].minPrice}đ -\n${listProducts[index].maxPrice}đ';
                                                                            }
                                                                            return null;
                                                                          },
                                                                          decoration: InputDecoration(
                                                                            isDense: true,
                                                                            fillColor: Colors.white,
                                                                            enabledBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                  color: Colors.grey.withOpacity(0.4),
                                                                                  width: 1, style: BorderStyle.solid),
                                                                              borderRadius: BorderRadius.circular(0),
                                                                            ),
                                                                            border: OutlineInputBorder(
                                                                              borderSide: const BorderSide(color: Colors.orange, width: 1.0),
                                                                              borderRadius: BorderRadius.circular(0),
                                                                            ),
                                                                            focusedBorder: OutlineInputBorder(
                                                                              borderSide:
                                                                              BorderSide(color: Colors.lightBlue.withOpacity(0.6), width: 2.5),
                                                                              borderRadius: BorderRadius.circular(0),
                                                                            ),
                                                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                            hintStyle: TextStyle(
                                                                                fontFamily: 'BeVietnamPro',
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 11.sp, color: Colors.grey),
                                                                            suffix: Text("đ/" + listProducts[index].unitSystem)
                                                                          ),
                                                                          onChanged: (value) {
                                                                            try{
                                                                              setState((){
                                                                                price = num.parse(value);
                                                                              });}on Exception catch(_){}
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              const SizedBox(height: 25,),
                                                              Container(
                                                                alignment: Alignment.centerLeft,
                                                                child: Row(
                                                                  children: [
                                                                    IconWidget(
                                                                        icon: Iconsax.setting_2, color: Colors.grey,
                                                                        fontSize: 14.sp, fontWeight: FontWeight.w600),
                                                                    const SizedBox(width: 5,),
                                                                    Text('Quy đổi(không bắt buộc)', style: TextStyle(
                                                                            fontFamily: 'BeVietnamPro',
                                                                            fontWeight: FontWeight.w500, fontSize: 12.sp,
                                                                            color: const Color.fromRGBO(61, 55, 55, 1.0))),
                                                                    // const SizedBox(width: 5,),
                                                                    Text(':', style: TextStyle(
                                                                            fontFamily: 'BeVietnamPro',
                                                                            fontWeight: FontWeight.w500, fontSize: 12.sp,
                                                                            color: Colors.black.withOpacity(0.5))),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(height: 5,),
                                                              Row(
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text('Đơn vị quy đổi', style: TextStyle(
                                                                                fontFamily: 'BeVietnamPro',
                                                                                fontWeight: FontWeight.w500, fontSize: 11.sp,
                                                                                color: const Color.fromRGBO(61, 55, 55, 1.0))),),
                                                                      const SizedBox(height: 8,),
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width: 120,
                                                                            child: TextFormField(
                                                                              textInputAction: TextInputAction.next,
                                                                              controller: TextEditingController.fromValue(
                                                                                TextEditingValue(
                                                                                  text: unitChange,
                                                                                  selection: TextSelection.collapsed(offset: unitChange.length))),
                                                                              validator: (value) {
                                                                                return null;
                                                                              },
                                                                              decoration: InputDecoration(
                                                                                prefix: Text('1 ', style: TextStyle(
                                                                                    fontFamily: 'BeVietnamPro',
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontSize: 13.sp,
                                                                                    color: Colors.black),),
                                                                                isDense: true,
                                                                                // fillColor: Colors.white,
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                      color: Colors.grey.withOpacity(0.4),
                                                                                      width: 1,
                                                                                      style: BorderStyle.solid),
                                                                                  borderRadius: BorderRadius.circular(0.0),
                                                                                ),
                                                                                border: OutlineInputBorder(
                                                                                  borderSide: const BorderSide(color: Colors.orange, width: 1.0),
                                                                                  borderRadius: BorderRadius.circular(0.0),
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide:
                                                                                  BorderSide(color: Colors.lightBlue.withOpacity(0.6), width: 2.5),
                                                                                  borderRadius: BorderRadius.circular(0),
                                                                                ),
                                                                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                hintText: "Nhập đơn vị",
                                                                                hintStyle: TextStyle(
                                                                                    fontFamily: 'BeVietnamPro',
                                                                                    fontWeight: FontWeight.w400,
                                                                                    fontSize: 11.sp,
                                                                                    color: Colors.grey),
                                                                              ),
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  unitChange = value;
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const Spacer(),
                                                                  Container(
                                                                    alignment: Alignment.bottomCenter,
                                                                    child: IconWidget(
                                                                      icon: Iconsax.arrow_swap_horizontal,
                                                                      color: Colors.black, fontWeight: FontWeight.w600,
                                                                      fontSize: 15.sp,
                                                                    ),
                                                                  ),
                                                                  const Spacer(),
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text('Giá trị quy đổi',
                                                                            style: TextStyle(
                                                                                fontFamily: 'BeVietnamPro',
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 11.sp,
                                                                                color: Color.fromRGBO(61, 55, 55, 1.0))),
                                                                      ),
                                                                      const SizedBox(height: 8,),
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width: 120,
                                                                            child: TextFormField(
                                                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                                              textInputAction: TextInputAction.next,
                                                                              keyboardType: TextInputType.number,
                                                                              initialValue: valueChange.toString(),
                                                                              validator: (value) {
                                                                                try{
                                                                                  if(num.parse(value!) > inventoryTotal){
                                                                                    return 'Giá trị quy đổi\nphải nhỏ hơn\ntổng kho';
                                                                                  }else if(inventoryTotal % num.parse(value) != 0){
                                                                                    return 'Giá trị quy đổi\nphải là số được\nchia hết bởi\ntổng kho';
                                                                                  }
                                                                                }on Exception catch(_){}
                                                                                return null;
                                                                              },
                                                                              decoration: InputDecoration(
                                                                                isDense: true,
                                                                                fillColor: Colors.white,
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                      color: Colors.grey.withOpacity(0.4),
                                                                                      width: 1, style: BorderStyle.solid),
                                                                                  borderRadius: BorderRadius.circular(0.0),
                                                                                ),
                                                                                border: OutlineInputBorder(
                                                                                  borderSide: const BorderSide(color: Colors.orange, width: 1.0),
                                                                                  borderRadius: BorderRadius.circular(0.0),
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide:
                                                                                  BorderSide(color: Colors.lightBlue.withOpacity(0.6), width: 2.5),
                                                                                  borderRadius: BorderRadius.circular(0),
                                                                                ),
                                                                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                // prefixIcon: prefixIcon,
                                                                                hintText: "Nhập giá trị quy đổi",
                                                                                suffix: Text(listProducts[index].unitSystem),
                                                                                hintStyle: TextStyle(
                                                                                    fontFamily: 'BeVietnamPro',
                                                                                    fontWeight: FontWeight.w500, fontSize: 11.sp,
                                                                                    color: Colors.grey),),
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  try{
                                                                                    if(isPositiveNumber(value)){
                                                                                      valueChange = num.parse(value);
                                                                                    }
                                                                                  }on Exception catch(_){}
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                          // Container(
                                                                          //   width: 50, height: 53,
                                                                          //   decoration: const BoxDecoration(
                                                                          //     color: Color.fromRGBO(231, 221, 221, 1.0),),
                                                                          //   alignment: Alignment.center,
                                                                          //   child: Text(listProducts[index].unitSystem),),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 10,),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Row(
                                                                      children: [
                                                                        IconWidget(
                                                                            icon: Iconsax.box_1, color: Colors.grey,
                                                                            fontSize: 13.sp, fontWeight: FontWeight.w500),
                                                                        const SizedBox(width: 5,),
                                                                        Text('Kết quả quy đổi', style: TextStyle(
                                                                                fontFamily: 'BeVietnamPro',
                                                                                fontWeight: FontWeight.w500, fontSize: 11.sp,
                                                                                color: const Color.fromRGBO(61, 55, 55, 1.0))),
                                                                        Text(':', style: TextStyle(
                                                                                fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                                                                fontSize: 11.sp, color: Colors.black.withOpacity(0.5))),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 8,),
                                                                 Row(
                                                                   children: [
                                                                     unitChange != '' && valueChange != 0 ? SizedBox(width: 50,
                                                                       child: Text((inventoryTotal / valueChange).toString(),),
                                                                     ): SizedBox(width: 50,
                                                                       child: Text((0).toString(),textAlign: TextAlign.center,),
                                                                     ),
                                                                     Container(
                                                                       width: 57, height: 53,
                                                                       decoration: const BoxDecoration(
                                                                         color: Color.fromRGBO(231, 221, 221, 1.0),
                                                                       ),
                                                                       alignment: Alignment.center,
                                                                       child: Text(unitChange),
                                                                     ),
                                                                     const Spacer(),
                                                                     unitChange != '' && valueChange != 0 ? SizedBox(
                                                                       width: 80,
                                                                       child: Text((price * valueChange).toString(),),
                                                                     ) : SizedBox(width: 80,
                                                                       child: Text((0).toString(),textAlign: TextAlign.center,),
                                                                     ),
                                                                     Container(
                                                                       width: 57,
                                                                       height: 53,
                                                                       decoration: const BoxDecoration(
                                                                         color: Color.fromRGBO(231, 221, 221, 1.0),
                                                                       ),
                                                                       alignment: Alignment.center,
                                                                       child: Text("đ/" + unitChange),
                                                                     )
                                                                   ],
                                                                 )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          setState((){
                                                            isPress = false;
                                                          });
                                                          Navigator.pop(context, 'Cancel');
                                                        },
                                                        child: const Text('Không'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            isPress = true;
                                                            if (_formKey.currentState!
                                                                .validate()) {
                                                              if(unitChange != '' && valueChange != 0){
                                                                listProducts[index].price = price;
                                                                listProducts[index].inventoryTotal = inventoryTotal;
                                                                listProducts[index].unitChange = unitChange;
                                                                listProducts[index].valueChange = valueChange;
                                                                listProducts[index].priceChange = price * valueChange;
                                                                listProducts[index].inventoryTotalChange = inventoryTotal / valueChange;
                                                              }else{
                                                                listProducts[index].price = price;
                                                                listProducts[index].inventoryTotal = inventoryTotal;
                                                                listProducts[index].unitChange = null;
                                                                listProducts[index].valueChange = null;
                                                                listProducts[index].priceChange = 0;
                                                                listProducts[index].inventoryTotalChange = 0;
                                                              }
                                                              Navigator.pop(context, 'ON');
                                                            }
                                                          });
                                                        }, child: const Text('Có'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                        );
                                      },
                                      child: IconWidget(icon: Iconsax.edit, color: Colors.green,
                                        fontSize: 16.sp, fontWeight: FontWeight.w500,),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                    child: TextButton(
                                      onPressed: () {setState(() {listProducts.removeAt(index);});},
                                      child: IconWidget(icon: Iconsax.close_square, color: Colors.redAccent,
                                        fontSize: 16.sp, fontWeight: FontWeight.w500,),),
                                  )
                                ],
                              ),
                              const Divider(color: Colors.grey, indent: 40, endIndent: 40, thickness: 0.5,)
                            ],
                          ),);
                      },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.redAccent,
                          ),
                          width: _size.width * 0.4,
                          height: _size.height * 0.065,
                          child: TextButton(
                            onPressed: () {
                              FocusScopeNode currentFocus =
                              FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              Navigator.pop(context);
                            },
                            child: Text('Hủy bỏ',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: Colors.white)),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: const Color.fromRGBO(95, 212, 144, 1.0),),
                        width: _size.width * 0.45, height: _size.height * 0.065,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('Xác nhận'),
                                      content: const Text('Bạn muốn tham gia chiến dịch này?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'Cancel'),
                                          child: const Text('Không'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'ON');
                                            setState(() {
                                              isPress = true;
                                              isCall = true;
                                              for (HarvestInCampaignModel hic in listProducts) {
                                                listRequests.add(CreateHarvestInCampaign(
                                                    inventory: hic.inventoryTotalChange != 0 ?  int.parse(hic.inventoryTotalChange.round().toString()) : hic.inventoryTotal,
                                                    price: hic.priceChange != 0 ? hic.priceChange : hic.price,
                                                    unit: hic.unitChange != null ? hic.unitChange.toString() : hic.unitSystem,
                                                    valueChangeOfUnit: hic.valueChange != null ? hic.valueChange as int : 0,
                                                    harvestId: hic.id as int,
                                                    campaignId: widget.campaignId as int));
                                              }
                                              if (listRequests.isNotEmpty) {createHarvestInCampaign();} else {
                                                isCall = false;
                                                UIData.toastMessage("Danh sách sản phẩm trống");
                                              }
                                            });
                                          }, child: const Text('Có'),),
                                      ],
                                    ),
                              );
                            });
                          },
                          child: Text('Đăng kí', style: TextStyle(
                              fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                              fontSize: 12.sp, color: Colors.white)),)),],
                  )
                ],
              ),),),),),
      tablet: SafeArea(child: Scaffold(appBar: AppBar(),),),
      desktop: SafeArea(child: Scaffold(appBar: AppBar(),),),
    );
  }
}
