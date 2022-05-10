import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/repository/harvest_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'components/harvest_header.dart';
import 'components/list_harvests.dart';
import 'harvest_management_bloc.dart';

class HarvestManagementScreen extends StatefulWidget {
  const HarvestManagementScreen({Key? key}) : super(key: key);

  @override
  _HarvestManagementScreenState createState() => _HarvestManagementScreenState();
}

class _HarvestManagementScreenState extends State<HarvestManagementScreen> {
  final HarvestRepository _harvestRepository = HarvestRepository();
  int countHarvests = 0;
  String farmerId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFarmerId();
  }

  @override
  void dispose() {
    countHarvests = 0;
    super.dispose();
  }

  Future getCountHarvests(String farmerId) async {
    final harvests = await _harvestRepository.getCountHarvestByFarmer(farmerId);
    if (mounted) {
      setState(() {
        countHarvests = harvests;
      });
    }
  }

  _getFarmerId() async {
    final all = await storage.readAll();
    setState(() {
      all.entries
          .map((entry) => {
                if (entry.key == 'userId')
                  {
                    farmerId = entry.value,
                    if (farmerId != '') {getCountHarvests(farmerId)}
                  }
              })
          .toList(growable: false);
    });
  }

  Widget listHarvest() {
    if (farmerId != '') {
      return Expanded(
          child: SingleChildScrollView(
        child: BlocProvider(
          create: (_) => HarvestManagementBloc(
              httpClient: http.Client(), farmerId: farmerId)
            ..add(HarvestFetched()),
          child: const ListHarvests(),
        ),
      ));
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
                HarvestHeader(
                  countHarvests: countHarvests,
                  farmerId: farmerId,
                ),
                listHarvest()
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
