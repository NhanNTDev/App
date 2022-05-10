import 'package:farmer_application/src/feature/model/campaign.dart';
import 'package:farmer_application/src/share/constants/converts.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CampaignCard extends StatelessWidget {
  final CampaignCanJoin campaign;
  final void Function()? onPressed;

  const CampaignCard(
      {Key? key, required this.campaign, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width,
      child: TextButton(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                campaign.image1,
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
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconWidget(
                          icon: Iconsax.location,
                          color: Colors.redAccent,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        campaign.campaignZoneName,
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                            color: Color.fromRGBO(61, 55, 55, 0.8)),
                      ),
                      Spacer(),
                      Container(
                        width: 60,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                        decoration: BoxDecoration(
                            color: campaign.type == 'Weekly' ? Color.fromRGBO(60, 190, 232, 0.8) : Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          campaign.type,
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp,
                              color: Color.fromRGBO(255, 255, 255, 1.0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  width: 245,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    // 'Chiến dịch bán rau tại Đà Lạt',
                    campaign.name,
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                        color: Color.fromRGBO(61, 55, 55, 1.0)),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      IconWidget(
                          icon: Iconsax.calendar_1,
                          color: Colors.green,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Từ ' +
                            convertFormatDate(
                                DateTime.parse(campaign.startAt)) +
                            ' - ' +
                            convertFormatDate(DateTime.parse(campaign.endAt)),
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                            color: Color.fromRGBO(61, 55, 55, 0.7)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      IconWidget(
                          icon: Iconsax.profile_2user,
                          color: Colors.black,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        campaign.farmInCampaign.toString(),
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                            color: Color.fromRGBO(61, 55, 55, 0.7)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      IconWidget(
                          icon: Iconsax.house_2,
                          color: Colors.black,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Các nông trại đủ điều kiện: ',
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: campaign.farms
                        .map((item) => Container(
                                child: Text(
                              "- " + item,
                              style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.sp,
                                  color: Color.fromRGBO(61, 55, 55, 0.7)),
                            )))
                        .toList()),
                SizedBox(
                  height: 4,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      campaign.status,
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w600,
                          fontSize: 11.sp,
                          color: Colors.amber),
                    )),
              ],
            )
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
