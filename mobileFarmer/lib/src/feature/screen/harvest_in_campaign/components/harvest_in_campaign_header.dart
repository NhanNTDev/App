import 'package:farmer_application/src/feature/screen/harvest_in_campaign/add_single_harvest_in_campaign/add_single_harvest_in_campaign_screen.dart';
import 'package:farmer_application/src/feature/screen/harvest_in_campaign/harvest_in_campaign_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

class HarvestIncampaignHeader extends StatelessWidget {
  final int countHarvests;
  final String status;
  final int campaignId;
  final int farmId;
  final String farmName;
  final String campaignName;

  const HarvestIncampaignHeader({Key? key, required this.countHarvests, required this.status, required this.campaignId, required this.farmId,required this.farmName, required this.campaignName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: _size.height * 0.13,
          width: _size.width,
          color: const Color.fromRGBO(95, 212, 144, 1.0),
        ),
        Positioned(
          top: 0,
          child: Container(
            height: _size.height * (843 / 10150),
            width: _size.width,
            padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 45,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const IconWidget(
                        icon: Iconsax.arrow_left,
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                Text('Danh sách sản phẩm trong \nchiến dịch',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: Colors.white)),
                const Spacer(),
                SizedBox(
                  width: 45,
                  child: status == 'Sắp mở bán' ? TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              curve: Curves.easeInOut,
                              duration: const Duration(milliseconds: 500),
                              reverseDuration:
                              const Duration(milliseconds: 500),
                              type: PageTransitionType.rightToLeftJoined,
                              child: AddSingleHarvestInCampaignScreen(farmId: farmId,campaignId: campaignId,farmName: farmName,campaignName: campaignName,),
                              childCurrent: HarvestInCampaignScreen(campaignId: campaignId, farmId: farmId, farmName: farmName, status: status,campaignName: campaignName,)
                              ));
                    },
                    child: const IconWidget(
                        icon: Iconsax.add,
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600),
                  ) : Container(),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: _size.height * 0.05,
            width: _size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            padding:
            const EdgeInsets.symmetric(horizontal: kPaddingDefault * 1.2),
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  child: IconWidget(
                      icon: Icons.campaign,
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  child: Text(
                    'Hiện có ' + countHarvests.toString() + ' mùa vụ',
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: Colors.black.withOpacity(0.8)),
                  ),
                ),
                // Spacer(),
                // Container(
                //   width: 38,
                //   // margin: EdgeInsets.only(right: 5),
                //   alignment: Alignment.center,
                //   child: TextButton(
                //     onPressed: () {},
                //     child: IconWidget(
                //         icon: Iconsax.search_normal,
                //         color: Colors.black.withOpacity(0.5),
                //         fontSize: 17.sp,
                //         fontWeight: FontWeight.w700),
                //   ),
                // ),
                // Container(
                //   width: 38,
                //   alignment: Alignment.center,
                //   child: TextButton(
                //     onPressed: () {},
                //     child: IconWidget(
                //         icon: Iconsax.sort,
                //         color: Colors.black.withOpacity(0.5),
                //         fontSize: 19.sp,
                //         fontWeight: FontWeight.w800),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
