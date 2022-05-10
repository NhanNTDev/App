import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/model/farm.dart';
import 'package:farmer_application/src/feature/repository/farm_repository.dart';
import 'package:farmer_application/src/feature/screen/farm_management/feedback_in_farm/feedback_in_farm_screen.dart';
import 'package:farmer_application/src/feature/screen/farm_management/update_farm/update_farm_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:farmer_application/src/share/widget/stateless/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:skeletons/skeletons.dart';
import '../farm_management_screen.dart';
import 'components/list_harvests_in_farm.dart';
import 'harvest_in_farm_bloc.dart';

class FarmDetailScreen extends StatefulWidget {
  final int? farmId;
  const FarmDetailScreen({Key? key, required this.farmId}) : super(key: key);

  @override
  _FarmDetailScreenState createState() => _FarmDetailScreenState();
}

class _FarmDetailScreenState extends State<FarmDetailScreen> {
  final FarmRepository _farmRepository = FarmRepository();
  List<String> listImages = [];
  bool isLoading = true;
  int statusCode = 0;
  Farm _farm = Farm(name: '', avatar: '', image1: '', image2: '', image3: '',
      image4: '', image5: '', description: '', address: '', active: false, totalStar: 0, feedbacks: 0);
  bool isCall = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFarmById(widget.farmId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listImages = [];
    isLoading = true;
    _farm = Farm(name: '', avatar: '', image1: '', image2: '', image3: '',
        image4: '', image5: '', description: '', address: '', active: false, feedbacks: 0, totalStar: 0);
    statusCode = 0;
    isCall = false;
    super.dispose();
  }

  Future<void> getFarmById(int? farmId) async {
    _farm = await _farmRepository.getFarmById(farmId!);
    if(mounted){
      setState(() {
        if (_farm.name != '') {isLoading = false;}
        if (_farm.image1 != '') {listImages.add(_farm.image1);}
        if (_farm.image2 != '') {listImages.add(_farm.image2);}
        if (_farm.image3 != '') {listImages.add(_farm.image3);}
        if (_farm.image4 != '') {listImages.add(_farm.image4);}
        if (_farm.image5 != '') {listImages.add(_farm.image5);}
      });
    }
  }

  Future<void> deleteFarm() async {
    statusCode = await _farmRepository.deleteFarm(widget.farmId as int);
    setState(() {
      if (statusCode == 200) {
        isCall = false;
        UIData.toastMessage('Xóa thành công');
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const FarmManagementScreen()),);
      } else if(statusCode == 400){
        isCall = false;
        UIData.toastMessage("Nông trại đang có sản phẩm được bày bán. Không thể xóa!");
      }
      else {isCall = false;UIData.toastMessage('Đã có lỗi xảy ra');}
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
                      style: SkeletonAvatarStyle(
                        width: double.infinity,
                        minHeight: MediaQuery.of(context).size.height / 5,
                        maxHeight: MediaQuery.of(context).size.height / 3,
                      ),
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
                      style: SkeletonParagraphStyle(
                          lines: 2, spacing: 3,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                    const SizedBox(height: 12),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 6, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                    const SizedBox(height: 8),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 2, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: false, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                    const SizedBox(height: 10,),
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
                          lines: 1, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),),
                  ],
                ),
              ), child: ProgressHUD(child:  SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * .3,
                        color: Colors.grey,
                        child: listImages.isNotEmpty ? ImageSlideshow(
                            width: double.infinity, indicatorPosition: 70,
                            height: 250, initialPage: 0,
                            indicatorColor: Colors.blue, indicatorBackgroundColor: Colors.white,
                            onPageChanged: (value) {}, autoPlayInterval: 5000, isLoop: true,
                            children: listImages
                                .map((item) => Image.network(item, fit: BoxFit.cover,),).toList()) : Container(),
                      ),
                      Container(color: Colors.white, height: MediaQuery.of(context).size.height * .1,),
                      Container(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
                        color: Colors.white,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.star, color: const Color.fromRGBO(255, 210, 95, 1.0), size: 18.sp,),
                                  const SizedBox(width: 3,),
                                  Text(_farm.totalStar.toString(), style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                      fontSize: 13.sp, color: const Color.fromRGBO(78, 80, 83, 1.0)),),
                                  const SizedBox(width: 3,),
                                  Text('(${_farm.feedbacks} đánh giá)', style: TextStyle(
                                      fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400, fontSize: 11.sp,
                                      color: const Color.fromRGBO(78, 80, 83, 1.0)),
                                  ),
                                  const SizedBox(width: 5,),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              curve: Curves.easeInOut,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              reverseDuration: const Duration(
                                                  milliseconds: 400),
                                              type: PageTransitionType
                                                  .rightToLeftJoined,
                                              child: FeedbackInFarmScreen(farmId: _farm.id as int,),
                                              childCurrent: FarmDetailScreen(farmId: _farm.id as int,)));
                                    },
                                    child: Text('Xem đánh giá',
                                      style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                          fontSize: 10.sp, color: const Color.fromRGBO(95, 212, 144, 1.0)),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  IconWidget(icon: Iconsax.message_question, color: const Color.fromRGBO(255, 210, 95, 1.0),
                                      fontSize: 16.sp, fontWeight: FontWeight.w700),
                                  const SizedBox(width: 5,),
                                  Text(
                                    'Mô tả:', style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                      fontSize: 13.sp, color: const Color.fromRGBO(78, 80, 83, 1.0)),
                                  ),
                                ],
                              ),
                              _farm.description != '' ? Container(
                                alignment: Alignment.centerLeft,
                                child: Text('- ' + _farm.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(height: 1.5, fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w400, fontSize: 12.sp,
                                      color: const Color.fromRGBO(78, 80, 83, 1.0)),
                                ),
                              ) : Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Chưa có mô tả chi tiết về nông trại này',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(height: 1.5, fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w400, fontSize: 11.sp, color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                children: [
                                  IconWidget(icon: Iconsax.box, color: const Color.fromRGBO(157, 196, 244, 1.0),
                                      fontSize: 16.sp, fontWeight: FontWeight.w700),
                                  const SizedBox(width: 5,),
                                  Text(
                                    'Danh sách mùa vụ hiện có:',
                                    style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                        fontSize: 13.sp, color: const Color.fromRGBO(78, 80, 83, 1.0)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              SizedBox(
                                  height: 230,
                                  child: SingleChildScrollView(
                                    child: BlocProvider(
                                      create: (_) => HarvestInFarmBloc(httpClient: http.Client(), farmId: widget.farmId as int)
                                        ..add(HarvestInFarmFetched()),
                                      child: ListHarvestsInFarm(farmId: widget.farmId as int,),),
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 60,
                    color: Colors.grey.withOpacity(0.45),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              // Navigator.popUntil(context, ModalRoute.withName('/home'));
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const FarmManagementScreen()),
                              );
                            },
                            child: IconWidget(icon: Iconsax.arrow_left, color: Colors.white,
                              fontSize: 18.sp, fontWeight: FontWeight.w700,)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: PopupMenuButton(
                            onSelected: (index) {
                              if (index == 0) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    UpdateFarmScreen(farmId: widget.farmId as int)),);
                              } else {
                                showDialog<String>(
                                  context: context, builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('Xác nhận'),
                                      content: const Text(
                                          'Bạn muốn xóa nông trại này?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'Cancel'),
                                          child: const Text('Không'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {isCall = true;});
                                            Navigator.pop(context, 'ON');
                                            deleteFarm();
                                          }, child: const Text('Có'),
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
                                        IconWidget(icon: Iconsax.edit, color: const Color.fromRGBO(107, 114, 128, 1.0),
                                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                                        const SizedBox(width: 6,),
                                        Text(
                                          'Chỉnh sửa thông tin',
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                              fontSize: 11.sp, color: const Color.fromRGBO(78, 80, 83, 1.0)),),
                                      ],
                                    ),
                                  );
                                }
                                return PopupMenuItem(
                                  value: index,
                                  child: Row(
                                    children: [
                                      IconWidget(icon: Iconsax.trash, color: const Color.fromRGBO(107, 114, 128, 1.0),
                                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                                      const SizedBox(width: 6,),
                                      Text(
                                        'Xóa nông trại',
                                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                            fontSize: 11.sp, color: const Color.fromRGBO(78, 80, 83, 1.0)),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .23, right: 20.0, left: 20.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 170.0, width: MediaQuery.of(context).size.width * 0.95,
                      child: Card(
                        color: Colors.white,
                        elevation: 4.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 15),
                              alignment: Alignment.center,
                              width: 300,
                              child: Text(
                                _farm.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w700,
                                    fontSize: 15.sp, color: const Color.fromRGBO(61, 55, 55, 1.0)),),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              alignment: Alignment.center,
                              width: 300,
                              child: Text(
                                _farm.address,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                    fontSize: 12.sp, color: const Color.fromRGBO(61, 55, 55, 1.0)),),
                            ),
                            const Spacer(),
                            Container(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                                      color: const Color.fromRGBO(95, 212, 144, 1.0)),
                                  width: 100,
                                  child: Text(
                                    'Đang mở cửa',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                        fontSize: 10.sp, color: Colors.white),),
                                )),
                            const SizedBox(height: 15,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),inAsyncCall: isCall,)
            )),
      ),
      tablet: SafeArea(child: Scaffold(appBar: AppBar(),),),
      desktop: SafeArea(child: Scaffold(appBar: AppBar(),),),
    );
  }
}
