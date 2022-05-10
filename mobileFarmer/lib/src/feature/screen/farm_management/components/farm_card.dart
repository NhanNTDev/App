import 'package:farmer_application/src/feature/model/farm.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class FarmCard extends StatelessWidget {
  final Farm farm;
  final void Function()? onPressed;

  const FarmCard({Key? key, required this.farm, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return TextButton(
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 2.5,
                    blurRadius: 2,
                    offset: const Offset(2, 1.5), // changes position of shadow
                  ),
                ],
              ),
              width: _size.width,
              height: 210,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    farm.avatar,
                    fit: BoxFit.cover,
                  ))),
          const SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              farm.name,
              style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: const Color.fromRGBO(61, 55, 55, 1.0)),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconWidget(
                      icon: Iconsax.location,
                      color: Colors.redAccent,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700),
                  const SizedBox(
                    width: 3,
                  ),
                  Flexible(
                    child: Text(
                      farm.address,
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                          color: const Color.fromRGBO(78, 80, 83, 1.0)),
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 6,
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Color.fromRGBO(255, 210, 95, 1.0),
                    size: 14.sp,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    farm.totalStar.toString(),
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: const Color.fromRGBO(78, 80, 83, 1.0)),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    '(${farm.feedbacks} đánh giá)',
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        color: const Color.fromRGBO(78, 80, 83, 1.0)),
                  ),
                  const Spacer(),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: farm.active == true
                        ? Text(
                            'Đang mở cửa',
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color: const Color.fromRGBO(95, 212, 144, 1.0)),
                          )
                        : Text(
                            'Đang tạm đóng',
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color: Colors.redAccent),
                          ),
                  ),
                ],
              )),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
