import 'package:delivery_driver_application/src/core/authentication/authentication.dart';
import 'package:delivery_driver_application/src/core/config/responsive/app_responsive.dart';
import 'package:delivery_driver_application/src/feature/screen/collect_product_task/complete_task/components/list_complete_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'complete_task_bloc.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({Key? key}) : super(key: key);

  @override
  _CompleteTaskScreenState createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  // final FarmRepository _farmRepository = FarmRepository();
  int countFarm = 0;
  String deliveryDriverId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFarmerId();
  }

  @override
  void dispose() {
    countFarm = 0;
    super.dispose();
  }

  _getFarmerId() async {
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

  Widget listCollectOrder() {
    if (deliveryDriverId != '') {
      return Expanded(
          child: SingleChildScrollView(
              child: BlocProvider(
                create: (_) =>
                CompleteTaskBloc(httpClient: http.Client(), farmerId: deliveryDriverId)
                  ..add(CompleteFetched()),
                child: ListCompleteTask(deliveryDriverId: deliveryDriverId,),
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
                SizedBox(height: 30,),
                listCollectOrder()
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
