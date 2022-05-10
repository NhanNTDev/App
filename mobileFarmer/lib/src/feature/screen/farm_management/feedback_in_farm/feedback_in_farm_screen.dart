import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/repository/farm_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../share/constants/app_constant.dart';
import 'components/list_feedbacks.dart';
import 'feedback_in_farm_bloc.dart';
import 'package:http/http.dart' as http;

class FeedbackInFarmScreen extends StatefulWidget {
  final int farmId;

  const FeedbackInFarmScreen({Key? key, required this.farmId}) : super(key: key);

  @override
  _FeedbackInFarmScreenState createState() => _FeedbackInFarmScreenState();
}

class _FeedbackInFarmScreenState extends State<FeedbackInFarmScreen> {
  final FarmRepository _farmRepository = FarmRepository();
  int countFarm = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    countFarm = 0;
    super.dispose();
  }

  Widget listFeedbacks() {
    if (widget.farmId != 0) {
      return Expanded(
          child: SingleChildScrollView(
              child: BlocProvider(
        create: (_) =>
            FeedbackInFarmBloc(httpClient: http.Client(), farmId: widget.farmId)
              ..add(FeedbackInFarmFetched()),
        child: const ListFeedback(),
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
                child: Text('Đánh giá',
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Colors.white)),
              ),
            ),
            body: Column(
              children: [listFeedbacks()],
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
