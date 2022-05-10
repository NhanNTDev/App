import 'package:farmer_application/src/feature/model/campaign.dart';
import 'package:farmer_application/src/feature/model/farm.dart';
import 'package:farmer_application/src/feature/model/harvest.dart';
import 'package:farmer_application/src/feature/model/harvest_in_campaign.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/constants/converts.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class HarvestInCampaignCard extends StatelessWidget {
  final HarvestInCampaign harvest;
  final void Function()? onPressed;

  const HarvestInCampaignCard(
      {Key? key, required this.harvest, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      // height: 300,
      width: _size.width,
      child: TextButton(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                // 'https://img.freepik.com/free-vector/fruits-vegetables-circlecomposition-gardening-horticulture-market-shop-healthy-diet-vegetarian-vegan-organic-food-banner-flat-vector-illustration_65580-278.jpg?w=740',
                harvest.image1,
                width: 95,
                height: 120,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: _size.width * 0.63,
                  child: Row(
                    children: [
                      Container(
                        width: 184,
                        child: Text(
                          harvest.productName.trim(),
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              color: const Color.fromRGBO(63, 169, 108, 1.0)),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        // width: 60,
                        alignment: Alignment.center,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(95, 212, 144, 1.0),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          harvest.productCategoryName,
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 8.sp,
                              color: Color.fromRGBO(255, 255, 255, 1.0)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 247,
                  child: Text(
                    // 'Chiến dịch bán rau tại Đà Lạt',
                    harvest.harvestName.trim(),
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: Color.fromRGBO(109, 109, 109, 1.0)),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    harvest.price.toString() + " vnd/" + harvest.unit,
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Color.fromRGBO(109, 109, 109, 1.0)),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: _size.width * 0.6,
                  child: Row(
                    children: [
                      Text(
                        'Hiện có: ',
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black),
                      ),
                      Text(
                        harvest.quantity.toString() + " " + harvest.unit,
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                checkStatus(harvest.status)
              ],
            )
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget checkStatus(String status) {
    if (status == "Đã được xác nhận") {
      return Text(
        harvest.status,
        style: TextStyle(
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            color: Color.fromRGBO(95, 212, 144, 1.0)),
      );
    } else if (status == "Chờ xác nhận") {
      return Text(
        harvest.status,
        style: TextStyle(
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            color: Colors.amber),
      );
    }
    return Text(
      harvest.status,
      style: TextStyle(
          fontFamily: 'BeVietnamPro',
          fontWeight: FontWeight.w600,
          fontSize: 11.sp,
          color: Colors.redAccent),
    );
  }
}
