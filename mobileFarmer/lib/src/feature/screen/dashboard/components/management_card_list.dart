import 'package:farmer_application/src/feature/screen/customer_management/customer_management_screen.dart';
import 'package:farmer_application/src/feature/screen/farm_management/farm_management_screen.dart';
import 'package:farmer_application/src/feature/screen/farm_order_management/order_management_screen.dart';
import 'package:farmer_application/src/feature/screen/harvest_management/harvest_management_screen.dart';
import 'package:farmer_application/src/feature/screen/join_campaign/join_campaign_screen.dart';
import 'package:farmer_application/src/feature/screen/my_campaign/my_campaign_screen.dart';
import 'package:farmer_application/src/feature/screen/revenue_management/revenue_management_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'management_card.dart';

class ManagementListCard extends StatelessWidget {
  final List? list;
  final String farmerId;
  const ManagementListCard({Key? key, required this.list, required this.farmerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.only(top: kPaddingDefault * 1, left: 5, right: 5),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisExtent: 110),
        itemCount: list!.length,
        itemBuilder: (BuildContext context, int index) {
          var card = list![index];
          if (index == list!.length) {return Container();}
          return ManagementCard(
            model: card,
            onPressed: () {
              if (list!.length > 1) {
                switch (index) {
                  case 0:
                    Navigator.of(context).push(MaterialPageRoute(
                        settings: const RouteSettings(name: "/farmscreen"),
                        builder: (context) => const FarmManagementScreen()));
                    break;
                  case 1:
                    Navigator.of(context).push(MaterialPageRoute(
                        settings: const RouteSettings(name: "/harvestscreen"),
                        builder: (context) => const HarvestManagementScreen()));
                    break;
                  case 2:
                    Navigator.of(context).push(MaterialPageRoute(
                        settings: const RouteSettings(name: "/orderscreen"),
                        builder: (context) => const OrderManagementScreen(
                              initPage: 0,)));
                    break;
                  case 3:
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CustomerManagementScreen(farmer: farmerId,)));
                    break;
                    case 4:
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RevenueManagementScreen(farmer: farmerId,)));
                    break;
                  case 5:
                    Navigator.of(context).push(MaterialPageRoute(
                        settings:
                            const RouteSettings(name: "/mycampaignscreen"),
                        builder: (context) => const MyCampaignScreen()));
                    break;
                  default:
                    Navigator.of(context).push(MaterialPageRoute(
                        settings:
                            const RouteSettings(name: "/canjoincampaignscreen"),
                        builder: (context) => const JoinCampaignScreen(initPage: 0,)));
                    break;
                }
              } else {
                switch (index) {
                  case 0:
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const JoinCampaignScreen(initPage: 0,)));
                    break;
                  default:
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const JoinCampaignScreen(initPage: 0,)));
                    break;
                }
              }
            },
          );
        });
  }
}
