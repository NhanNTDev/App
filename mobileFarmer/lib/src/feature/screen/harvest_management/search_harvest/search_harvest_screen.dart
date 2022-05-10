import 'dart:async';
import 'package:farmer_application/src/feature/model/harvest.dart';
import 'package:farmer_application/src/feature/repository/harvest_repository.dart';
import 'package:farmer_application/src/feature/screen/harvest_management/harvest_detail/harvest_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../share/constants/app_constant.dart';

class SearchHarvestScreen extends StatefulWidget {
  final String farmerId;

  const SearchHarvestScreen({Key? key, required this.farmerId}) : super(key: key);

  @override
  _SearchHarvestScreenState createState() => _SearchHarvestScreenState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {timer!.cancel();}
    timer = Timer(const Duration(milliseconds: Duration.millisecondsPerSecond), action,);
  }
}

class _SearchHarvestScreenState extends State<SearchHarvestScreen> {
  final _harvestRepository = HarvestRepository();
  final _debouncer = Debouncer();

  List<SearchHarvest> listSearch = [];
  List<SearchHarvest> listSearchHarvest = [];
  bool isCall = true;
  bool isLoading = false;

  Future<void> getListHarvestByName() async {
    listSearch = await _harvestRepository.getHarvestByName('', widget.farmerId);
    setState(() {
      isCall = false;
      if (listSearch.isNotEmpty) {listSearchHarvest = listSearch;}
    });
  }

  @override
  void initState() {
    super.initState();
    getListHarvestByName();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listSearch = [];
    listSearchHarvest = [];
    isCall = true;
    isLoading = false;
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
              ), titleSpacing: 0, toolbarHeight: 80, leadingWidth: 40,
              backgroundColor: Colors.white, elevation: 1,
              title: Container(
                decoration: BoxDecoration(color: Color.fromRGBO(240, 240, 240, 1.0), borderRadius: BorderRadius.circular(25.0),),
                margin: EdgeInsets.only(right: 10),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Color.fromRGBO(240, 240, 240, 1.0)),),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.blue,),),
                    prefixIcon: InkWell(child: Icon(Icons.search),),
                    contentPadding: EdgeInsets.all(15.0),
                    hintText: 'Nhập tên mùa vụ tìm kiếm',
                    hintStyle: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                        fontSize: 12.sp, color: Color.fromRGBO(124, 130, 141, 1.0)),),
                  onChanged: (string) {
                    _debouncer.run(() {
                      setState(() {
                        listSearchHarvest = listSearch.where(
                              (u) => (u.name.toLowerCase().contains(string.toLowerCase(),)),).toList();
                      });
                    });
                  },
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                isCall == false ? Expanded(
                        child: listSearchHarvest.isNotEmpty ? ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                itemCount: listSearchHarvest.length,
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
                                            listSearchHarvest[index].image1 != '' ? Container(
                                                    width: 40, height: 40,
                                                    child: Image.network(listSearchHarvest[index].image1),) : Container(),
                                            SizedBox(width: 8,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 270,
                                                  child: Text(listSearchHarvest[index].name,
                                                    style: TextStyle(
                                                        fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                                        fontSize: 14.sp, color: Colors.black),),
                                                ),
                                                SizedBox(height: 3,),
                                                Container(
                                                  width: 270,
                                                  child: Text(listSearchHarvest[index].farmName,
                                                    style: TextStyle(
                                                        fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                                        fontSize: 12.sp, color: Color.fromRGBO(124, 130, 141, 1.0)),),
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
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                curve: Curves.easeInOut,
                                                duration: const Duration(milliseconds: 400),
                                                reverseDuration: const Duration(milliseconds: 400),
                                                type: PageTransitionType.rightToLeftJoined,
                                                settings: const RouteSettings(name: "/farmdetail"),
                                                child: HarvestDetailScreen(harvestId: listSearchHarvest[index].id as int,),
                                                childCurrent: SearchHarvestScreen(farmerId: widget.farmerId,)));
                                      },
                                    ),
                                  );
                                },
                              )
                            : Container(
                                padding: const EdgeInsets.only(top: 30),
                                alignment: Alignment.center,
                                child: Text('Không có kết quả tìm kiếm',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(height: 1.5, fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w400, fontSize: 11.sp, color: Colors.grey),),
                              ),
                      ) : Container(
                        padding: const EdgeInsets.only(top: 30),
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                            width: 30, height: 30,
                            child: SpinKitHourGlass(color: kBlueDefault, size: 30.sp,)),
                      ),
              ],
            ),
          ),
        ),
        tablet: SafeArea(child: Scaffold(appBar: AppBar(),),),
        desktop: SafeArea(child: Scaffold(appBar: AppBar(),),));
  }
}
