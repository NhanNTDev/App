import 'package:farmer_application/src/feature/model/campaign.dart';
import 'package:farmer_application/src/share/constants/converts.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CampaignCard extends StatelessWidget {
  final JoinedCampaign campaign;
  final void Function()? onPressed;

  const CampaignCard(
      {Key? key, required this.campaign, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      child: TextButton(
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
                      offset: Offset(2, 1.5), // changes position of shadow
                    ),
                  ],
                ),
                width: _size.width,
                height: 210,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      campaign.image1,
                      fit: BoxFit.cover,
                    )
                )),
            SizedBox(height: 10,),
            Container(
                // alignment: Alignment.centerLeft,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconWidget(icon: Iconsax.location, color: Colors.redAccent, fontSize: 12.sp, fontWeight: FontWeight.w700),
                    SizedBox(width: 3,),
                    Text(
                      campaign.campaignZoneName,
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                          color: Color.fromRGBO(78, 80, 83, 1.0)),
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment.centerRight,
                      child:

                      Text(
                        campaign.status,
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                            color:  campaign.status == "Đang diễn ra" ? const Color.fromRGBO(95, 212, 144, 1.0) : Colors.amber),
                      )
                    ),
                  ],
                )
            ),
            SizedBox(height: 4,),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                campaign.name,
                style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: Color.fromRGBO(61, 55, 55, 1.0)),
              ),
            ),
            SizedBox(height: 8,),
            Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 14.sp,),
                    SizedBox(width: 3,),
                    Text(
                      'Từ ',
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                          color: Color.fromRGBO(78, 80, 83, 1.0)),
                    ),
                    SizedBox(width: 3,),
                    Text(
                      convertFormatDate(DateTime.parse(campaign.startAt)),
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                          color: Color.fromRGBO(78, 80, 83, 1.0)),
                    ),
                    Text(
                      " - " + convertFormatDate(DateTime.parse(campaign.endAt)),
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                          color: Color.fromRGBO(78, 80, 83, 1.0)),
                    ),
                  ],
                )
            ),
            SizedBox(height: 5,),
            Container(
              // alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  IconWidget(
                      icon: Iconsax.profile_2user,
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    campaign.farmInCampaign.toString(),
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: Color.fromRGBO(78, 80, 83, 1.0)),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 5,),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
