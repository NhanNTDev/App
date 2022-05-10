import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/model/account.dart';
import 'package:farmer_application/src/feature/repository/account_repository.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/data/dashboard_list.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'components/content_dashboard.dart';
import 'components/dashboard_header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String image = 'https://www.adler-colorshop.com/media/image/b8/f3/fa/ADLER-Pullex-Color-Holzfarben-weiss-1fFx.jpg';
  String name = '';
  String farmerId = '';
  num orderConfirms = 0;
  num farms = 0;
  num harvests = 0;
  num customerOrder = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readAll();
  }

  final _accountRepository = AccountRepository();
  DashBoard dashBoard = DashBoard(farms: 0, harvests: 0, orderConfirms: 0, customerOrder: 0);
  Future<void> getDashBoard() async{
    dashBoard = await _accountRepository.getDashBoard(farmerId);
    if(mounted){
      setState(() {
        dashboardList[0].number = dashBoard.orderConfirms;
        dashboardList[1].number = dashBoard.farms;
        dashboardList[2].number = dashBoard.harvests;
        dashboardList[3].number = dashBoard.customerOrder;
      });
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    image = 'https://www.adler-colorshop.com/media/image/b8/f3/fa/ADLER-Pullex-Color-Holzfarben-weiss-1fFx.jpg';
    name = '';
    farmerId = '';
    super.dispose();
  }

  _readAll() async {
    final all = await storage.readAll();
    if(mounted){
      setState(() {
        all.entries
            .map((entry) => {
          if (entry.key == 'avatar')
            {image = entry.value}
          else if (entry.key == 'name')
            {name = entry.value}
          else if (entry.key == 'userId')
              {farmerId = entry.value,
              if(farmerId != ''){
                getDashBoard()
              }
        }
        })
            .toList(growable: false);
      });
    }
  }

  List<DashboardCardModel> dashboardList = [
    DashboardCardModel(
        color: Color.fromRGBO(253, 226, 156, 1.0),
        icon: Iconsax.note_1,
        title: 'Đơn hàng',
        number: 0,
        subtitle: 'Chờ xác nhận'),
     DashboardCardModel(
        color: Color.fromRGBO(198, 230, 255, 1.0),
        icon: Iconsax.building_3,
        title: 'Nông trại',
        number: 0,
        subtitle: 'Đang sở hữu'),
     DashboardCardModel(
        color: Color.fromRGBO(255, 218, 218, 1.0),
        icon: Iconsax.sun_1,
        title: 'Mùa vụ',
        number: 0,
        subtitle: 'Đang có'),
    DashboardCardModel(
        color: Color.fromRGBO(181, 245, 117, 1.0),
        icon: Iconsax.user,
        title: 'Khách hàng',
        number: 0,
        subtitle: 'Người'),
  ];

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    // _readAll();
    return Responsive(
        mobile: Scaffold(
          backgroundColor: kBlueDefault,
          body: RefreshIndicator(
            child: SafeArea(
              child: Column(
                children: [
                  DashboardHeader(image: image, name: name,),
                  Expanded(
                    child: Container(
                      width: _size.width,
                      decoration: const BoxDecoration(borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                          color: Colors.white),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ContentDashboard(farmerId: farmerId,dashboardList: dashboardList,),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            onRefresh: () async {
              print('hello');
              _readAll();
            },
          ),
        ),
        tablet: SafeArea(child: Scaffold(appBar: AppBar(),),),
        desktop: SafeArea(child: Scaffold(appBar: AppBar(),),));
  }
}
