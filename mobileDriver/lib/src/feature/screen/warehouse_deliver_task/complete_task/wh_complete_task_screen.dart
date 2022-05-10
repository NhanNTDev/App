import 'package:delivery_driver_application/src/core/authentication/authentication.dart';
import 'package:delivery_driver_application/src/core/config/responsive/app_responsive.dart';
import 'package:delivery_driver_application/src/feature/screen/warehouse_deliver_task/complete_task/wh_complete_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'components/list_wh_complete_tasks.dart';

class WhCompleteTaskScreen extends StatefulWidget {
  const WhCompleteTaskScreen({Key? key}) : super(key: key);

  @override
  _WhCompleteTaskScreenState createState() => _WhCompleteTaskScreenState();
}

class _WhCompleteTaskScreenState extends State<WhCompleteTaskScreen> {
  // final FarmRepository _farmRepository = FarmRepository();
  int countFarm = 0;
  String deliveryDriverId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDriverId();
  }

  @override
  void dispose() {
    countFarm = 0;
    super.dispose();
  }

  _getDriverId() async {
    final all = await storage.readAll();
    setState(() {
      all.entries
          .map((entry) => {
        if (entry.key == 'userId')
          {
            deliveryDriverId = entry.value,
            // if (farmerId != '') {getCountFarm(farmerId)}
          }
      })
          .toList(growable: false);
    });
  }

  // Future getCountFarm(String farmerId) async {
  //   final farms = await _farmRepository.getCountFarmByFarmer(farmerId);
  //   if (mounted) {
  //     setState(() {
  //       countFarm = farms;
  //     });
  //   }
  // }

  Widget listWarehouseDeliverOrder() {
    if (deliveryDriverId != '') {
      return Expanded(
          child: SingleChildScrollView(
              child: BlocProvider(
                create: (_) =>
                WhCompleteTaskBloc(httpClient: http.Client(), driverId: deliveryDriverId)
                  ..add(WhCompleteFetched()),
                child: ListWhCompleteTask(deliveryDriverId: deliveryDriverId,),
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
                const SizedBox(height: 30,),
                listWarehouseDeliverOrder()
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
