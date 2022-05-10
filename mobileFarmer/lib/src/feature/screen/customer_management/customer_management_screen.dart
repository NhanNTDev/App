import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/repository/farm_repository.dart';
import 'package:farmer_application/src/feature/screen/customer_management/components/list_customers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../share/constants/app_constant.dart';
import 'components/list_customers.dart';
import 'customer_management_bloc.dart';
import 'package:http/http.dart' as http;

class CustomerManagementScreen extends StatefulWidget {
  final String farmer;
  const CustomerManagementScreen({Key? key, required this.farmer}) : super(key: key);

  @override
  _CustomerManagementScreenState createState() => _CustomerManagementScreenState();
}

class _CustomerManagementScreenState extends State<CustomerManagementScreen> {
  final FarmRepository _farmRepository = FarmRepository();
  int countFarm = 0;
  // String farmerId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getFarmerId();
  }

  @override
  void dispose() {
    countFarm = 0;
    super.dispose();
  }

  // _getFarmerId() async {
  //   final all = await storage.readAll();
  //   setState(() {
  //     all.entries
  //         .map((entry) => {
  //       if (entry.key == 'userId')
  //         {
  //           farmerId = entry.value,
  //           if (farmerId != '') {getCountFarm(farmerId)}
  //         }
  //     })
  //         .toList(growable: false);
  //   });
  // }

  // Future getCountFarm(String farmerId) async {
  //   final farms = await _farmRepository.getCountFarmByFarmer(farmerId);
  //   if (mounted) {
  //     setState(() {
  //       countFarm = farms;
  //     });
  //   }
  // }

  Widget listFarm() {
    if (widget.farmer != '') {
      return Expanded(
          child: SingleChildScrollView(
              child: BlocProvider(
                create: (_) =>
                CustomerManagementBloc(httpClient: http.Client(), farmerId: widget.farmer)
                  ..add(CustomerFetched()),
                child: const ListCustomer(),
              )));
    }
    return const Text('Đã có lỗi xảy ra');
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: 70,
              backgroundColor: kBlueDefault,
              elevation: 0.5,
              leadingWidth: 10,
              title: Center(
                child: Text('Danh sách khách hàng',
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Colors.white)),
              ),
            ),
            body: Column(
              children: [
                listFarm()
              ],
            ),
          ),
        ),
        tablet: Scaffold(appBar: AppBar(),),
        desktop: Scaffold(appBar: AppBar(),));
  }
}
