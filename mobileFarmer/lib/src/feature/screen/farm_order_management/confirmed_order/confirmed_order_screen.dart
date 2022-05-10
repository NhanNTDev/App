import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/repository/farm_order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/list_confirmed_orders.dart';
import 'confirmed_order_bloc.dart';
import 'package:http/http.dart' as http;

class ConfirmedFarmOrderScreen extends StatefulWidget {
  const ConfirmedFarmOrderScreen({Key? key}) : super(key: key);

  @override
  _ConfirmedFarmOrderScreenState createState() =>
      _ConfirmedFarmOrderScreenState();
}

class _ConfirmedFarmOrderScreenState extends State<ConfirmedFarmOrderScreen> {
  final _farmOrderRepository = NeedConfirmFarmOrderRepository();
  int countFarmOrder = 0;
  String farmerId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFarmerId();
  }

  @override
  void dispose() {
    countFarmOrder = 0;
    super.dispose();
  }

  _getFarmerId() async {
    final all = await storage.readAll();
    setState(() {
      all.entries
          .map((entry) => {
                if (entry.key == 'userId')
                  {
                    farmerId = entry.value,
                    if (farmerId != '') {getCountFarmOrder(farmerId, 1)}
                  }
              })
          .toList(growable: false);
    });
  }

  Future getCountFarmOrder(String farmerId, int status) async {
    final farms =
        await _farmOrderRepository.getCountFarmOrderByStatus(farmerId, status);
    if (mounted) {
      setState(() {
        countFarmOrder = farms;
      });
    }
  }

  Widget listFarmOrder() {
    if (farmerId != '') {
      return Expanded(
          child: SingleChildScrollView(
              child: BlocProvider(
        create: (_) => ConfirmedFarmOrderBloc(
            httpClient: http.Client(), farmerId: farmerId)
          ..add(ConfirmedFarmOrderFetched()),
        child: const ListConfirmedFarmOrder(),
      )));
    }
    return const Text('Đã xảy ra lỗi');
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: Text('Số đơn hàng: ' + countFarmOrder.toString(),
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                          color: Colors.black.withOpacity(0.8))),
                ),
                SizedBox(
                  height: 10,
                ),
                listFarmOrder(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        tablet: Scaffold(
          appBar: AppBar(),
        ),
        desktop: Scaffold(
          appBar: AppBar(),
        ));
  }
}
