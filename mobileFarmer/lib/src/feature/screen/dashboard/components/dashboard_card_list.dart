import 'package:farmer_application/src/feature/model/account.dart';
import 'package:farmer_application/src/feature/repository/account_repository.dart';
import 'package:farmer_application/src/share/data/dashboard_list.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'dashboard_card.dart';

class DashboardCardList extends StatelessWidget {
    final String farmerId;
    final List<DashboardCardModel> dashboardList;
   DashboardCardList({Key? key, required this.farmerId, required this.dashboardList}) : super(key: key);

  EdgeInsets checkPadding(int index) {
    if (index == 0) {
      return const EdgeInsets.only(left: 15);
    } else if (index == 3) {
      return const EdgeInsets.only(right: 15, left: 5);
    }
    return const EdgeInsets.only(left: 5);
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        itemCount: dashboardList.length,
        itemBuilder: (context, index) {
          DashboardCardModel card = dashboardList[index];
          return Container(
            padding: checkPadding(index),
            child: DashboardCard(model: card,),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }


}
