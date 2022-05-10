import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/model/harvest.dart';
import 'package:farmer_application/src/feature/repository/harvest_repository.dart';
import 'package:farmer_application/src/feature/screen/harvest_management/harvest_management_screen.dart';
import 'package:farmer_application/src/feature/screen/harvest_management/update_harvest/update_harvest_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:farmer_application/src/share/constants/converts.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:farmer_application/src/share/widget/stateless/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletons/skeletons.dart';

class HarvestDetailScreen extends StatefulWidget {
  final int harvestId;

  const HarvestDetailScreen({Key? key, required this.harvestId}) : super(key: key);

  @override
  _HarvestDetailScreenState createState() => _HarvestDetailScreenState();
}

class _HarvestDetailScreenState extends State<HarvestDetailScreen> {
  final HarvestRepository _harvestRepository = HarvestRepository();
  List<String> listImages = [];
  int statusCode = 0;
  bool isCall = false;
  bool isLoading = true;

  Future<void> deleteHarvest() async {
    statusCode = await _harvestRepository.deleteHarvest(widget.harvestId);
    if(mounted){
      setState(() {
        if (statusCode == 200) {
          isCall = false;
          UIData.toastMessage('Xóa thành công');
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HarvestManagementScreen()),);
        } else {
          isCall = false;
          UIData.toastMessage('Mùa vụ đang có sản phẩm được bày bán. Không thể xóa!');
        }
      });
    }
  }

  Harvest _harvest = Harvest(image1: '', image2: '', image3: '', image4: '', image5: '', name: '', farmName: '', productName: '',
    startAt: '', estimatedTime: '', estimatedProduction:0, actualProduction: 0, unit: '', categoryName: '',
    inventoryTotal: 0, description: '', maxPrice: 0, minPrice: 0, productSystemName: '', productNameChange: '',);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHarvestById(widget.harvestId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isCall = false;
    isLoading = true;
    _harvest = Harvest(image1: '', image2: '', image3: '', image4: '', image5: '', name: '', farmName: '', productName: '',
      startAt: '', estimatedTime: '', estimatedProduction: 0, unit: '', categoryName: '', inventoryTotal: 0, description: '',
      maxPrice: 0, minPrice: 0, productSystemName: '', productNameChange: '', actualProduction: 0,);
    super.dispose();
  }

  Future<void> getHarvestById(int? harvestId) async {
    _harvest = await _harvestRepository.getHarvestById(harvestId!);
    setState(() {
      if (_harvest.name != '') {isLoading = false;}
      if (_harvest.image1 != '') {listImages.add(_harvest.image1);}
      if (_harvest.image2 != '') {listImages.add(_harvest.image2);}
      if (_harvest.image3 != '') {listImages.add(_harvest.image3);}
      if (_harvest.image4 != '') {listImages.add(_harvest.image4);}
      if (_harvest.image5 != '') {listImages.add(_harvest.image5);}
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
              skeleton: SkeletonItem(
                child: Column(
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(width: double.infinity,
                        minHeight: MediaQuery.of(context).size.height / 5,
                        maxHeight: MediaQuery.of(context).size.height / 3,),
                    ),
                    const SizedBox(height: 20,),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                    const SizedBox(height: 6),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(lines: 2, spacing: 3,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),),
                    const SizedBox(height: 12),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 6, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),),
                    const SizedBox(height: 8),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 2, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: false, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: double.infinity,
                          minHeight: MediaQuery.of(context).size.height / 4,
                          maxHeight: MediaQuery.of(context).size.height / 3,
                        ),),),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),),
                  ],
                ),
              ),
              child: ProgressHUD(
                inAsyncCall: isCall,
                child: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * .45,
                            color: Colors.grey,
                            child: listImages.isNotEmpty ? ImageSlideshow(
                                    width: double.infinity, indicatorPosition: 10,
                                    height: 350, initialPage: 0, indicatorColor: Colors.blue,
                                    indicatorBackgroundColor: Colors.grey, onPageChanged: (value) {},
                                    autoPlayInterval: 5000, isLoop: true,
                                    children: listImages.map((item) => Image.network(item, fit: BoxFit.cover,),).toList()) : Container(),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
                            color: Colors.white,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 260,
                                        child: Text(_harvest.name,
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                              fontSize: 17.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),
                                      ),
                                      const Spacer(),
                                      _harvest.inventoryTotal != 0 ? Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Đang mở bán',
                                                style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                                    fontSize: 11.sp, color: Color.fromRGBO(95, 212, 144, 1.0)),))
                                          : Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Đã hết hàng',
                                                style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                                    fontSize: 11.sp, color: Colors.redAccent),)),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      IconWidget(icon: Iconsax.house_2, color: Colors.grey,
                                          fontSize: 13.sp, fontWeight: FontWeight.w700),
                                      SizedBox(width: 5,),
                                      Text('Nông trại:',
                                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                            fontSize: 12.sp, color: Colors.black),),
                                      SizedBox(width: 5,),
                                      Container(
                                        width: 230,
                                        child: Text(_harvest.farmName,
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                              fontSize: 12.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),)),
                                      SizedBox(width: 5,),
                                      Image.asset('assets/icons/tick-circle.png'),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      IconWidget(icon: Iconsax.box_1, color: Colors.grey,
                                          fontSize: 12.sp, fontWeight: FontWeight.w700),
                                      SizedBox(width: 5,),
                                      Text('Sản phẩm:',
                                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                            fontSize: 12.sp, color: Colors.black),),
                                      SizedBox(width: 5,),
                                      Container(
                                        width: 251,
                                        child: Text(_harvest.productName,
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                              fontSize: 12.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      IconWidget(icon: Iconsax.edit, color: Colors.grey,
                                          fontSize: 12.sp, fontWeight: FontWeight.w700),
                                      SizedBox(width: 5,),
                                      Text('Tên hiển thị:',
                                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                            fontSize: 12.sp, color: Colors.black),),
                                      SizedBox(width: 5,),
                                      Container(
                                        width: 241,
                                        child: Text(_harvest.productNameChange,
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                              fontSize: 12.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      IconWidget(icon: Iconsax.calendar_tick, color: Color.fromRGBO(95, 212, 144, 1.0),
                                          fontSize: 12.sp, fontWeight: FontWeight.w700),
                                      SizedBox(width: 5,),
                                      Text('Ngày bắt đầu mùa vụ:',
                                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                            fontSize: 12.sp, color: Colors.black),),
                                      SizedBox(width: 5,),
                                      Text(_harvest.startAt != '' ? convertFormatDate(DateTime.parse(_harvest.startAt)) : '',
                                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                            fontSize: 12.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      IconWidget(icon: Iconsax.sun_1, color: Colors.amber,
                                          fontSize: 12.sp, fontWeight: FontWeight.w700),
                                      SizedBox(width: 5,),
                                      Text('Ngày thu hoạch dự kiến:',
                                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                            fontSize: 12.sp, color: Colors.black),),
                                      SizedBox(width: 5,),
                                      Text(
                                        _harvest.estimatedTime != '' ? convertFormatDate(DateTime.parse(_harvest.estimatedTime)) : '',
                                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                            fontSize: 12.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      IconWidget(icon: Iconsax.box, color: Color.fromRGBO(157, 196, 244, 1.0),
                                          fontSize: 12.sp, fontWeight: FontWeight.w700),
                                      SizedBox(width: 5,),
                                      Text('Sản lượng thu hoạch dự kiến:',
                                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                            fontSize: 12.sp, color: Colors.black),),
                                      SizedBox(width: 5,),
                                      Container(
                                        width: 120,
                                        child: Text(_harvest.estimatedProduction.toString() + " " + _harvest.unit,
                                          style: TextStyle(fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w500, fontSize: 12.sp,
                                              color: Color.fromRGBO(78, 80, 83, 1.0)),),),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      IconWidget(icon: Iconsax.box, color: Color.fromRGBO(157, 196, 244, 1.0),
                                          fontSize: 12.sp, fontWeight: FontWeight.w700),
                                      SizedBox(width: 5,),
                                      Text('Sản lượng thu hoạch thực tế:',
                                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                            fontSize: 12.sp, color: Colors.black),),
                                      SizedBox(width: 5,),
                                      Container(
                                        width: 120,
                                        child: _harvest.actualProduction != 0
                                            ? Text(_harvest.actualProduction.toString() + " " + _harvest.unit,
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                              fontSize: 12.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),
                                        ) : Text('Chưa có',
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                              fontSize: 12.sp, color: Colors.grey),),),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      IconWidget(icon: Iconsax.box, color: Color.fromRGBO(157, 196, 244, 1.0),
                                          fontSize: 12.sp, fontWeight: FontWeight.w700),
                                      SizedBox(width: 5,),
                                      Text('Sản lượng hiện có:',
                                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                            fontSize: 12.sp, color: Colors.black),),
                                      SizedBox(width: 5,),
                                      Container(
                                        width: 120,
                                        child: Text(_harvest.inventoryTotal.toString() + " " + _harvest.unit,
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                              fontSize: 12.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      IconWidget(icon: Iconsax.message_question, color: Color.fromRGBO(255, 210, 95, 1.0),
                                          fontSize: 16.sp, fontWeight: FontWeight.w700),
                                      SizedBox(width: 5,),
                                      Text('Mô tả:',
                                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                            fontSize: 13.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),
                                    ],
                                  ),
                                  SizedBox(height: 3,),
                                  _harvest.description != '' ? Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text('- ' + _harvest.description,
                                            style: TextStyle(height: 1.5, fontFamily: 'BeVietnamPro',
                                                fontWeight: FontWeight.w400, fontSize: 12.sp,
                                                color: Color.fromRGBO(78, 80, 83, 1.0)),),
                                        ) : Container(
                                          alignment: Alignment.center,
                                          child: Text('Chưa có mô tả chi tiết về nông trại này',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(height: 1.5, fontFamily: 'BeVietnamPro',
                                                fontWeight: FontWeight.w400, fontSize: 11.sp, color: Colors.grey),)),
                                ],
                              ),),)
                        ],
                      ),
                      Container(
                        height: 60,
                        color: Colors.grey.withOpacity(0.45),
                        child: Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HarvestManagementScreen()),);
                                },
                                child: IconWidget(icon: Iconsax.arrow_left, color: Colors.white,
                                  fontSize: 18.sp, fontWeight: FontWeight.w700,)),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: PopupMenuButton(
                                onSelected: (index) {
                                  if (index == 0) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                              UpdateHarvestScreen(harvestId: widget.harvestId)),);
                                  } else {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                            title: const Text('Xác nhận'),
                                        content: const Text('Bạn muốn xóa mùa vụ này?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'Cancel'),
                                            child: const Text('Không'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isCall = true;
                                                Navigator.pop(context, 'OK');
                                                deleteHarvest();
                                              });
                                            },
                                            child: const Text('Có'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                onCanceled: () {},
                                initialValue: 2,
                                child: IconWidget(icon: Iconsax.more, color: Colors.white,
                                  fontSize: 26.sp, fontWeight: FontWeight.w400,),
                                itemBuilder: (context) {
                                  return List.generate(2, (index) {
                                    if (index == 0) {
                                      return PopupMenuItem(
                                        value: index,
                                        child: Row(
                                          children: [
                                            IconWidget(icon: Iconsax.edit, color: Color.fromRGBO(107, 114, 128, 1.0),
                                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                                            SizedBox(width: 6,),
                                            Text('Chỉnh sửa thông tin',
                                              style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                                  fontSize: 11.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),
                                          ],
                                        ),
                                      );
                                    }
                                    return PopupMenuItem(
                                      value: index,
                                      child: Row(
                                        children: [
                                          IconWidget(icon: Iconsax.trash, color: Color.fromRGBO(107, 114, 128, 1.0),
                                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                                          SizedBox(width: 6,),
                                          Text('Xóa mùa vụ',
                                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                                fontSize: 11.sp, color: Color.fromRGBO(78, 80, 83, 1.0)),),
                                        ],
                                      ),);
                                  });
                                },
                              ),),
                          ],
                        ),),
                    ],
                  ),),),),),
        ),
        tablet: SafeArea(child: Scaffold(appBar: AppBar(),),),
        desktop: SafeArea(child: Scaffold(appBar: AppBar(),),));
  }
}
