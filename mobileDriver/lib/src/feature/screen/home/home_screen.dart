import 'package:delivery_driver_application/src/core/authentication/authentication.dart';
import 'package:delivery_driver_application/src/core/base/base_api.dart';
import 'package:delivery_driver_application/src/core/config/responsive/app_responsive.dart';
import 'package:delivery_driver_application/src/feature/model/shipping_order.dart';
import 'package:delivery_driver_application/src/feature/repository/shipping_order_repository.dart';
import 'package:delivery_driver_application/src/feature/screen/collect_product_task/collect_product_task_screen.dart';
import 'package:delivery_driver_application/src/feature/screen/main/main_screen.dart';
import 'package:delivery_driver_application/src/feature/screen/shipping_task/shipping_task_screen.dart';
import 'package:delivery_driver_application/src/feature/screen/warehouse_deliver_task/warehouse_deliver_task_screen.dart';
import 'package:delivery_driver_application/src/share/constants/converts.dart';
import 'package:delivery_driver_application/src/share/widget/stateless/avatar_circle_button.dart';
import 'package:delivery_driver_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String typeDriver = '';
  String image = 'https://www.adler-colorshop.com/media/image/b8/f3/fa/ADLER-Pullex-Color-Holzfarben-weiss-1fFx.jpg';
  String name = '';
  String driverId = '';

  _getTypeDriver() async {
    final all = await storage.readAll();
    if(mounted){
      setState(() {
        all.entries
            .map((entry) => {
          if (entry.key == 'type')
            {
              typeDriver = entry.value,
              print("hello " + typeDriver)
            }else if (entry.key == 'userId')
            {
              driverId = entry.value,
              if(driverId != ''){
                countTask(driverId)
              }
            }
          else if (entry.key == 'avatar')
            {image = entry.value}
          else if (entry.key == 'name')
              {name = entry.value}
        })
            .toList(growable: false);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTypeDriver();
    print(_countTask.taskOfCollections);

  }
  final _shippingOrderRepository = ShippingOrderRepository();
  CountTask _countTask = CountTask(taskOfCollections: 0, taskOfShipments: 0, taskOfDeliveries: 0);

  Future<void> countTask(String driverId) async {
    var result = await _shippingOrderRepository.countTaskForDriver(driverId);
    if(mounted){
      setState(() {
        _countTask = result;
      });

    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    typeDriver = '';
    image = 'https://www.adler-colorshop.com/media/image/b8/f3/fa/ADLER-Pullex-Color-Holzfarben-weiss-1fFx.jpg';
    name = '';
    _countTask = CountTask(taskOfCollections: 0, taskOfShipments: 0, taskOfDeliveries: 0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    // _getTypeDriver();
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AvatarCircleButton(
                          onPressed: () {},
                          // height: 50,
                          // width: 50,
                          height: _size.width * 0.13,
                          width: _size.width * 0.13,
                          component: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(30)),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  image),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                convertFormatHour(DateTime.now()).toString() +
                                    ",",
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w500,
                                    // fontSize: 15.sp,
                                    fontSize: 12.sp,
                                    color: Color.fromRGBO(39, 39, 42, 1.0))),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(
                                    checkDayInWeek(DateTime.now()) != "Chủ nhật"
                                        ? "Thứ "
                                        : " ",
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w600,
                                        // fontSize: 15.sp,
                                        fontSize: 12.sp,
                                        color: Colors.black)),
                                Text(checkDayInWeek(DateTime.now()) + " ",
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w600,
                                        // fontSize: 15.sp,
                                        fontSize: 12.sp,
                                        color: Colors.black)),
                                Text(
                                    convertFormatDate(DateTime.now())
                                        .toString(),
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w600,
                                        // fontSize: 15.sp,
                                        fontSize: 12.sp,
                                        color: Colors.black)),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('Xin chào, ' + name + '!',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                              // fontSize: 15.sp,
                              fontSize: 15.sp,
                              color: Colors.black)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 52,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2))),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          IconWidget(
                              icon: Iconsax.info_circle,
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                          SizedBox(
                            width: 8,
                          ),
                          typeDriver == '1' ?
                          Text('Bạn có ${_countTask.taskOfCollections + _countTask.taskOfDeliveries} công việc cần làm',
                              style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w600,
                                  // fontSize: 15.sp,
                                  fontSize: 12.sp,
                                  color: Colors.black))
                              : Text('Bạn có ${_countTask.taskOfShipments} công việc cần làm',
                              style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w600,
                                  // fontSize: 15.sp,
                                  fontSize: 12.sp,
                                  color: Colors.black))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    typeSave != '' && typeSave == '2' ? Container() : Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromRGBO(255, 245, 199, 1.0)),
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        child: Row(
                          children: [
                            Text('Công việc thu hàng',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    // fontSize: 15.sp,
                                    fontSize: 12.sp,
                                    color: Color.fromRGBO(204, 129, 0, 1.0))),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(204, 129, 0, 1.0)),
                              child: Text(_countTask.taskOfCollections.toString(),
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      // fontSize: 15.sp,
                                      fontSize: 12.sp,
                                      color: Colors.white)),
                            ),
                            Spacer(),
                            IconWidget(
                                icon: Iconsax.arrow_right,
                                color: Color.fromRGBO(204, 129, 0, 1.0),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ],
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     PageTransition(
                          //         curve: Curves.easeInOut,
                          //         duration: const Duration(milliseconds: 400),
                          //         reverseDuration:
                          //             const Duration(milliseconds: 400),
                          //         type: PageTransitionType.rightToLeftJoined,
                          //         // settings: const RouteSettings(
                          //         //     name: "/farmdetail"),
                          //         child: const CollectProductTaskScreen(
                          //           initPage: 0,
                          //         ),
                          //         childCurrent: const MainScreen()));
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CollectProductTaskScreen(
                              initPage: 0,
                            )),
                          );
                        },
                      ),
                    ),
                    // typeSave != '' && typeSave == '2' ? Container() : SizedBox(
                    //   height: 30,
                    // ) ,
                    typeSave != '' && typeSave == '2' ? Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromRGBO(233, 245, 255, 1.0)),
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        child: Row(
                          children: [
                            Text('Luân chuyển giữa các kho',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    // fontSize: 15.sp,
                                    fontSize: 12.sp,
                                    color: Color.fromRGBO(26, 148, 255, 1.0))),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(26, 148, 255, 1.0)),
                              child: Text(_countTask.taskOfShipments.toString(),
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      // fontSize: 15.sp,
                                      fontSize: 12.sp,
                                      color: Colors.white)),
                            ),
                            Spacer(),
                            IconWidget(
                                icon: Iconsax.arrow_right,
                                color: Color.fromRGBO(26, 148, 255, 1.0),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ],
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     PageTransition(
                          //         curve: Curves.easeInOut,
                          //         duration: const Duration(milliseconds: 400),
                          //         reverseDuration:
                          //         const Duration(milliseconds: 400),
                          //         type: PageTransitionType.rightToLeftJoined,
                          //         // settings: const RouteSettings(
                          //         //     name: "/farmdetail"),
                          //         child: const WarehouseDeliverTaskScreen(
                          //           initPage: 0,
                          //         ),
                          //         childCurrent: const MainScreen()));

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const WarehouseDeliverTaskScreen(
                                      initPage: 0,
                                    )),
                          );
                        },
                      ),
                    ) : Container(),
                    typeSave != '' && typeSave == '2' ?  Container() : SizedBox(
                      height: 30,
                    ),
                    typeSave != '' && typeSave == '2' ? Container() : Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromRGBO(229, 255, 238, 1.0)),
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        child: Row(
                          children: [
                            Text('Công việc giao hàng',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    // fontSize: 15.sp,
                                    fontSize: 12.sp,
                                    color: Color.fromRGBO(0, 171, 86, 1.0))),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(0, 171, 86, 1.0)),
                              child: Text(_countTask.taskOfDeliveries.toString(),
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      // fontSize: 15.sp,
                                      fontSize: 12.sp,
                                      color: Colors.white)),
                            ),
                            Spacer(),
                            IconWidget(
                                icon: Iconsax.arrow_right,
                                color: Color.fromRGBO(0, 171, 86, 1.0),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ShippingTaskScreen(
                              initPage: 0,
                            )),
                          );

                        },
                      ),
                    ),
                  ],
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
}
