import 'package:farmer_application/src/feature/model/harvest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HarvestInFarmCard extends StatelessWidget {
  final Harvest harvest;
  final void Function()? onPressed;

  const HarvestInFarmCard(
      {Key? key, required this.harvest, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SizedBox(
      width: _size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              harvest.image1,
              width: 60,
              height: 60,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                child: Text(
                  harvest.name,
                  style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp,
                      color: const Color.fromRGBO(61, 55, 55, 1.0)),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(95, 212, 144, 1.0),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      harvest.productName,
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          fontSize: 9.sp,
                          color: const Color.fromRGBO(255, 255, 255, 1.0)),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    // width: 60,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(95, 212, 144, 1.0),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      harvest.categoryName,
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          fontSize: 9.sp,
                          color: const Color.fromRGBO(255, 255, 255, 1.0)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: onPressed,
            child: Text(
              'Xem',
              style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  fontSize: 11.sp,
                  color: const Color.fromRGBO(95, 212, 144, 1.0)),
            ),
          )
        ],
      ),
    );
  }
}
