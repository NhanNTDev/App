import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/repository/farm_order_repository.dart';
import 'package:farmer_application/src/feature/repository/farm_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';


import 'components/list_processing_orders.dart';
import 'processing_order_bloc.dart';
import 'package:http/http.dart' as http;

class ProcessingFarmOrderScreen extends StatefulWidget {
  const ProcessingFarmOrderScreen({Key? key}) : super(key: key);

  @override
  _ProcessingFarmOrderScreenState createState() => _ProcessingFarmOrderScreenState();
}

class _ProcessingFarmOrderScreenState extends State<ProcessingFarmOrderScreen> {
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
            if (farmerId != '') {getCountFarmOrder(farmerId, 2)}
          }
      })
          .toList(growable: false);
    });
  }

  Future getCountFarmOrder(String farmerId, int status) async {
    final farms = await _farmOrderRepository.getCountFarmOrderByStatus(farmerId, status);
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
                create: (_) =>
                ProcessingFarmOrderBloc(httpClient: http.Client(), farmerId: farmerId)
                  ..add(ProcessingFarmOrderFetched()),
                child: const ListProcessingFarmOrder(),
              )
          ));
    }
    return const Text('Đã có lỗi xảy ra');
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                const SizedBox(height: 15,),
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
                const SizedBox(height: 10,),
                listFarmOrder(),
                const SizedBox(height: 10,),
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
