import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/repository/farm_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'add_new_farm/add_new_farm_screen.dart';
import 'components/farm_header.dart';
import 'components/list_farm.dart';
import 'farm_management_bloc.dart';
import 'package:http/http.dart' as http;

class FarmManagementScreen extends StatefulWidget {
  const FarmManagementScreen({Key? key}) : super(key: key);

  @override
  _FarmManagementScreenState createState() => _FarmManagementScreenState();
}

class _FarmManagementScreenState extends State<FarmManagementScreen> {
  final FarmRepository _farmRepository = FarmRepository();
  int countFarm = 0;
  String farmerId = '';

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
                    farmerId = entry.value,
                    if (farmerId != '') {getCountFarm(farmerId)}
                  }
              })
          .toList(growable: false);
    });
  }

  Future getCountFarm(String farmerId) async {
    final farms = await _farmRepository.getCountFarmByFarmer(farmerId);
    if (mounted) {
      setState(() {
        countFarm = farms;
      });
    }
  }

  Widget listFarm() {
    if (farmerId != '') {
      return Expanded(
          child: SingleChildScrollView(
              child: BlocProvider(
        create: (_) =>
            FarmManagementBloc(httpClient: http.Client(), farmerId: farmerId)
              ..add(FarmFetched()),
        child: const ListFarm(),
      )));
    }
    return Container(
      padding: EdgeInsets.only(top: 30),
      alignment: Alignment.center,
      child: Text(
        'Đã có lỗi xảy ra',
        textAlign: TextAlign.justify,
        style: TextStyle(height: 1.5, fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w400, fontSize: 11.sp, color: Colors.grey),
      ),
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
                FarmHeader(
                  countFarm: countFarm,
                  farmerId: farmerId,
                  onPress: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 400),
                            reverseDuration: const Duration(milliseconds: 400),
                            type: PageTransitionType.rightToLeftJoined,
                            child: AddNewFarmScreen(
                              farmerId: farmerId,
                            ),
                            childCurrent: const FarmManagementScreen()));
                  },
                ),
                listFarm()
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
