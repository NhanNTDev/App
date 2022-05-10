import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/widget/stateless/avatar_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardHeader extends StatelessWidget {
  final String image;
  final String name;
  const DashboardHeader({Key? key, required this.image, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: 85,
      color: kBlueDefault,
      padding: const EdgeInsets.only(left: kPaddingDefault, right: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AvatarCircleButton(
            onPressed: () {},
            height: _size.width * 0.13,
            width: _size.width * 0.13,
            component: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(30)),
              child: CircleAvatar(
                backgroundImage: NetworkImage(image.toString()),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Xin chào, ' + name + '!',
                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                      fontSize: 15.sp, color: Colors.white)),
              Text('Hãy quản lí nông trại của bạn',
                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                      fontSize: 11.sp, color: Colors.white)),
            ],
          ),
          // Spacer(),
          // Badge(
          //   badgeContent: Text(
          //     '10',
          //     style: TextStyle(color: Colors.white, fontSize: 9),
          //   ),
          //   child: IconWidget(
          //     icon: Iconsax.notification,
          //     color: Colors.white,
          //     fontWeight: FontWeight.w500,
          //     fontSize: 20.sp,
          //   ),
          // )
        ],
      ),
    );
  }
}
