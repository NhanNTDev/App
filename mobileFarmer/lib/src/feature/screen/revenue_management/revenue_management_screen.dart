import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/model/account.dart';
import 'package:farmer_application/src/feature/repository/account_repository.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:farmer_application/src/share/widget/stateless/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class RevenueManagementScreen extends StatefulWidget {
  final String farmer;

  const RevenueManagementScreen({Key? key, required this.farmer})
      : super(key: key);

  @override
  _RevenueManagementScreenState createState() =>
      _RevenueManagementScreenState();
}

class _RevenueManagementScreenState extends State<RevenueManagementScreen> {
  num revenues = 0;
  num customers = 0;
  num completeOrders = 0;
  bool isCall = true;

  final _accountRepository = AccountRepository();
  Revenue revenue = Revenue(totalRevenues: 0, customers: 0, farmOrders: 0);

  Future<void> getRevenue() async {
    revenue = await _accountRepository.getRevenue(widget.farmer);
    if (mounted) {
      setState(() {
        isCall = false;
        revenues = revenue.totalRevenues;
        customers = revenue.customers;
        completeOrders = revenue.farmOrders;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRevenue();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    revenues = 0;
    customers = 0;
    completeOrders = 0;
    isCall = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              backgroundColor: kBlueDefault,
              elevation: 0.5,
              leading: Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              leadingWidth: 10,
              title: Center(
                child: Text('Quản lí doanh thu',
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Colors.white)),
              ),
            ),
            body: ProgressHUD(
              inAsyncCall: isCall,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      revenueCard(
                          _size.width * 0.8,
                          Iconsax.money_recive,
                          'Quản lí doanh thu',
                          revenues.toString() + " vnđ",
                          Color.fromRGBO(180, 240, 174, 1.0)),
                      SizedBox(
                        height: 20,
                      ),
                      revenueCard(
                          _size.width * 0.8,
                          Iconsax.people,
                          'số khách hàng',
                          customers.toString() + " người",
                          Color.fromRGBO(255, 173, 196, 1.0)),
                      SizedBox(
                        height: 20,
                      ),
                      revenueCard(
                          _size.width * 0.8,
                          Iconsax.note_1,
                          'Số đơn hàng hoàn thành',
                          completeOrders.toString() + " đơn",
                          Color.fromRGBO(105, 219, 255, 1.0)),
                    ],
                  ),
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

  Widget revenueCard(double width, IconData icon, String title,
      String information, Color color) {
    return Container(
      height: 160,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: IconWidget(
                  icon: icon,
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  height: 1.5,
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              information,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  height: 1.5,
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
