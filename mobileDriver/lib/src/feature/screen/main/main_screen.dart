import 'package:delivery_driver_application/src/core/config/responsive/app_responsive.dart';
import 'package:delivery_driver_application/src/feature/screen/home/home_screen.dart';
import 'package:delivery_driver_application/src/feature/screen/my_profile/my_profile_screen.dart';
import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
import 'package:delivery_driver_application/src/share/constants/app_uidata.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../main.dart';
import '../notification/notification_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPage = 0;
  int totalNotifications = 0;
  final _page = [
    const HomeScreen(),
    const NotificationScreen(),
    const MyProfileScreen(),
    // DashboardScreen(),
    // LoginScreen(),
    // FillAccountInfoScreen(),
    // DashboardScreen()
  ];

  DateTime? currentBackPressTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.subscribeToTopic('all');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      print(message.data);

      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
        setState(() {
          totalNotifications++;
        });
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (context) {
              return FloatingActionButton(
                  backgroundColor: Colors.white.withOpacity(0.0),
                  onPressed: () {
                    // setState(() {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (BuildContext context) => DetailCampaignPage(
                    //         id: int.parse(message.data['campaignId']),
                    //       )));
                    // });
                  },
                  child: AlertDialog(
                    title: Text(notification.title.toString()),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(notification.body.toString())],
                      ),
                    ),
                  ));
            });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: WillPopScope(child: Scaffold(
            body: _page[_selectedPage],
            bottomNavigationBar: Container(
              height: 62,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, -4),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: BottomNavigationBar(
                  currentIndex: _selectedPage,
                  unselectedItemColor: Color.fromRGBO(58, 58, 58, 100),
                  selectedItemColor: Color.fromRGBO(255, 174, 79, 1.0),
                  onTap: (int index) {
                    setState(() {
                      _selectedPage = index;
                    });
                  },
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(
                        Iconsax.house4,
                      ),
                    ),
                    BottomNavigationBarItem(
                        icon: totalNotifications == 0  ?  const Icon(Iconsax.notification) : Image.asset(
                          UIData.notification,
                          width: 25,
                        ),
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(
                        Iconsax.user,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),onWillPop: onWillPop,),
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

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      UIData.toastMessage("Nhấn một lần nữa để thoát");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
