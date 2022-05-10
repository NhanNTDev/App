import 'package:farmer_application/src/feature/screen/harvest_management/add_new_harvest/add_new_harvest_screen.dart';
import 'package:farmer_application/src/feature/screen/harvest_management/search_harvest/search_harvest_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

import '../harvest_management_screen.dart';

class HarvestHeader extends StatelessWidget {
  final int countHarvests;
  final String farmerId;
  const HarvestHeader({Key? key, required this.countHarvests, required this.farmerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(height: _size.height * 0.13, width: _size.width, color: const Color.fromRGBO(95, 212, 144, 1.0),),
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
                    onPressed: () {Navigator.pop(context);},
                    child: const IconWidget(icon: Iconsax.arrow_left, color: Colors.white,
                        fontSize: 25, fontWeight: FontWeight.w600),),
                ),
                const Spacer(),
                Text('Danh sách mùa vụ',
                    style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                        fontSize: 15.sp, color: Colors.white)),
                const Spacer(),
                 SizedBox(
                  width: 45,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(curve: Curves.easeInOut, duration: const Duration(milliseconds: 500),
                              reverseDuration: const Duration(milliseconds: 500),
                              type: PageTransitionType.rightToLeftJoined,
                              child: AddNewHarvestScreen(farmerId: farmerId,),
                              childCurrent: const HarvestManagementScreen()));
                    },
                    child: const IconWidget(icon: Iconsax.add, color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),
                  ),
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
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  child: IconWidget(icon: Icons.campaign, color: Colors.black.withOpacity(0.5),
                      fontSize: 19.sp, fontWeight: FontWeight.w500),),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  child: Text(
                    'Hiện có ' + countHarvests.toString() + ' mùa vụ',
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                        fontSize: 12.sp, color: Colors.black.withOpacity(0.8)),),
                ),
                Spacer(),
                Container(
                  width: 38,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, PageTransition(curve: Curves.easeInOut,
                              duration: const Duration(milliseconds: 400), reverseDuration: const Duration(milliseconds: 400),
                              type: PageTransitionType.rightToLeftJoined, child: SearchHarvestScreen(farmerId: farmerId,),
                              childCurrent: const HarvestManagementScreen()));
                    },
                    child: IconWidget(icon: Iconsax.search_normal, color: Colors.black.withOpacity(0.5),
                        fontSize: 17.sp, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
