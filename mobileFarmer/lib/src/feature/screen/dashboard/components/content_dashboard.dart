import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/data/dashboard_list.dart';
import 'package:farmer_application/src/share/data/management_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dashboard_card_list.dart';
import 'management_card_list.dart';

class ContentDashboard extends StatelessWidget{
  final String farmerId;
  final List<DashboardCardModel> dashboardList;
  const ContentDashboard({Key? key, required this.farmerId, required this.dashboardList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width,
      // height: 200,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
            alignment: Alignment.centerLeft,
            child: Text('Thống kê',
                style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: Color.fromRGBO(102, 105, 103, 1.0))),
          ),
          const SizedBox(height: 8,),
          DashboardCardList(farmerId: farmerId,dashboardList: dashboardList,),
          const SizedBox(height: 25,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
            alignment: Alignment.centerLeft,
            child: Text('Chiến dịch bán hàng',
                style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: Color.fromRGBO(102, 105, 103, 1.0))),
          ),
          ManagementListCard(list: listCampaignManagementButton,farmerId: farmerId,),
          const SizedBox(height: 25,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
            alignment: Alignment.centerLeft,
            child: Text('Quản lí',
                style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: Color.fromRGBO(102, 105, 103, 1.0))),
          ),
          ManagementListCard(list: listManagementButton,farmerId: farmerId,),

        ],
      ),
    );
  }

}