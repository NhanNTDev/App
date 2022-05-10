import 'package:delivery_driver_application/src/core/authentication/authentication.dart';
import 'package:delivery_driver_application/src/core/config/responsive/app_responsive.dart';
import 'package:delivery_driver_application/src/feature/screen/shipping_task/complete_task/shipping_complete_task_bloc.dart';
import 'package:delivery_driver_application/src/feature/screen/shipping_task/processing_task/shipping_processing_task_bloc.dart';
import 'package:delivery_driver_application/src/feature/screen/warehouse_deliver_task/processing_task/components/list_wh_processing_tasks.dart';
import 'package:delivery_driver_application/src/feature/screen/warehouse_deliver_task/processing_task/wh_processing_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'components/list_shipping_complete_tasks.dart';

class ShippingCompleteTaskScreen extends StatefulWidget {
  const ShippingCompleteTaskScreen({Key? key}) : super(key: key);

  @override
  _ShippingCompleteTaskScreenState createState() => _ShippingCompleteTaskScreenState();
}

class _ShippingCompleteTaskScreenState extends State<ShippingCompleteTaskScreen> {
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

  Widget listShippingOrder() {
    if (deliveryDriverId != '') {
      return Expanded(
          child: SingleChildScrollView(
              child: BlocProvider(
                create: (_) =>
                ShippingCompleteTaskBloc(httpClient: http.Client(), driverId: deliveryDriverId)
                  ..add(ShippingCompleteFetched()),
                child: ListShippingCompleteTask(deliveryDriverId: deliveryDriverId,),
              )
          ));
    }
    return Container(
      child: Text('hello'),
    );
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
                listShippingOrder()
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
