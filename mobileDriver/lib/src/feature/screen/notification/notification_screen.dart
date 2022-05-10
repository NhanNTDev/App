import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/authentication/authentication.dart';
import '../../../core/config/responsive/app_responsive.dart';
import '../../../share/constants/app_constant.dart';
import '../../../share/widget/stateless/progress_widget.dart';
import '../../model/notification.dart';
import '../../repository/notification_repository.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _notificationRepository = NotificationRepository();
  List<Notifications> list = [];
  String farmerId = '';
  bool isCall = true;


  _getFarmerId() async {
    final all = await storage.readAll();
    setState(() {
      all.entries
          .map((entry) => {
        if (entry.key == 'userId')
          {
            farmerId = entry.value,
            if(farmerId != ''){
              getListNotifications(farmerId)
            }
          }
      })
          .toList(growable: false);
    });
  }

  Future<void> getListNotifications(String farmerId) async {
    list = await _notificationRepository.getListNotifications(farmerId);
    if(mounted){
      setState(() {
        if(list.isNotEmpty){
          isCall = false;
          print('Lay thanh cong');
        }else{
          isCall = false;
        }
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
    list = [];
    farmerId = '';
    isCall = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              // backgroundColor: kBlueDefault,
              backgroundColor: Color.fromRGBO(255, 174, 79, 1.0),
              elevation: 0.5,
              leadingWidth: 10,
              title: Center(
                child: Text('Thông báo',
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Colors.white)),
              ),
            ),
            body: ProgressHUD(
              inAsyncCall: isCall,
              child: ListView.separated(
                itemCount: list.length,
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: TextButton(
                      onPressed: (){},
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    list[index].title,
                                    style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                        fontSize: 13.sp,
                                        color: Colors.black)),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    list[index].body,
                                    style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                        color: Colors.grey)),
                              ),
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  Spacer(),
                                  Text(
                                      list[index].time,
                                      style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                          fontSize: 9.sp,
                                          color: Colors.grey)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
