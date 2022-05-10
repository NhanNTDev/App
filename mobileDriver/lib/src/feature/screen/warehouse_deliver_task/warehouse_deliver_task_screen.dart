import 'package:delivery_driver_application/src/core/config/responsive/app_responsive.dart';
import 'package:delivery_driver_application/src/feature/screen/collect_product_task/cancel_task/cancel_task_screen.dart';
import 'package:delivery_driver_application/src/feature/screen/collect_product_task/complete_task/complete_task_screen.dart';
import 'package:delivery_driver_application/src/feature/screen/collect_product_task/processing_task/processing_task_screen.dart';
import 'package:delivery_driver_application/src/feature/screen/warehouse_deliver_task/complete_task/wh_complete_task_screen.dart';
import 'package:delivery_driver_application/src/feature/screen/warehouse_deliver_task/processing_task/wh_processing_task_screen.dart';
import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class WarehouseDeliverTaskScreen extends StatefulWidget{
  final int initPage;
  const WarehouseDeliverTaskScreen({Key? key, required this.initPage}) : super(key: key);

  @override
  _WarehouseDeliverTaskScreenState createState() => _WarehouseDeliverTaskScreenState();

}

class _WarehouseDeliverTaskScreenState extends State<WarehouseDeliverTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: DefaultTabController(
            initialIndex: widget.initPage,
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 60,
                // backgroundColor: kBlueDefault,
                backgroundColor: Color.fromRGBO(255, 174, 79, 1.0),
                elevation: 0.5,
                leading: Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: Icon(Icons.arrow_back, color: Colors.white,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                leadingWidth: 35,
                title: Center(
                  child: Text('Công việc luân chuyển',
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: Colors.white)),
                ),
                bottom:  TabBar(
                  indicatorColor: Colors.white,
                  tabs: <Widget>[
                    Tab(
                      child: Text('Đang tiến hành',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                              color: Colors.white)),
                    ),
                    Tab(
                        child: Text('Đã hoàn thành',
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: Colors.white))
                    ),
                  ],
                ),
              ),
              body: const TabBarView(

                children: <Widget>[
                  Center(
                    child: WhProcessingTaskScreen(),
                  ),
                  Center(
                    child: WhCompleteTaskScreen(),
                    // child: WhProcessingTaskScreen(),
                  ),
                ],
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


}