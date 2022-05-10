import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/screen/farm_order_management/cancel_order/cancel_order_screen.dart';
import 'package:farmer_application/src/feature/screen/farm_order_management/complete_order/complete_order_screen.dart';
import 'package:farmer_application/src/feature/screen/farm_order_management/confirmed_order/confirmed_order_screen.dart';
import 'package:farmer_application/src/feature/screen/farm_order_management/processing_order/processing_order_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'need_confirm_order/need_confirm_order_screen.dart';

class OrderManagementScreen extends StatefulWidget {
  final int initPage;

  const OrderManagementScreen({Key? key, required this.initPage}) : super(key: key);

  @override
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: DefaultTabController(
            initialIndex: widget.initPage,
            length: 5,
            child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 70,
                  backgroundColor: kBlueDefault,
                  elevation: 0,
                  leading: Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Icon(Icons.arrow_back, color: Colors.white,),
                      onPressed: () {Navigator.pop(context);},
                    ),
                  ),
                  leadingWidth: 10,
                  title: Center(
                    child: Text('Danh sách đơn hàng',
                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                            fontSize: 15.sp, color: Colors.white)),),
                ),
                body: Column(
                  children: [
                    Container(
                      color: kBlueDefault,
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3.0,
                        isScrollable: true,
                        labelColor: Colors.black87,
                        unselectedLabelColor: Colors.black45,
                        tabs: <Widget>[
                          Tab(
                            child: Text('Chờ xác nhận',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                    fontSize: 10.sp, color: Colors.white)),),
                          Tab(
                              child: Text('Chờ xử lí',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                      fontSize: 10.sp, color: Colors.white))),
                          Tab(
                              child: Text('Chờ giao hàng',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                      fontSize: 10.sp, color: Colors.white))),
                          Tab(
                              child: Text('Đã hoàn thành',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                      fontSize: 10.sp, color: Colors.white))),
                          Tab(
                              child: Text('Đã hủy',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                      fontSize: 10.sp, color: Colors.white))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: const <Widget>[
                          Center(child: NeedConfirmFarmOrderScreen(),),
                          Center(child: ConfirmedFarmOrderScreen(),),
                          Center(child: ProcessingFarmOrderScreen(),),
                          Center(child: CompleteFarmOrderScreen(),),
                          Center(child: CancelFarmOrderScreen(),),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
        tablet: SafeArea(child: Scaffold(appBar: AppBar(),),),
        desktop: SafeArea(child: Scaffold(appBar: AppBar(),),));
  }
}
