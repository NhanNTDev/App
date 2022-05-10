import 'package:farmer_application/src/share/constants/converts.dart';
import 'package:farmer_application/src/share/widget/stateless/avatar_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../model/feedback.dart';

class FeedbackCard extends StatelessWidget {
  final FeedbackInFarm feedback;

  const FeedbackCard({Key? key, required this.feedback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 40,
                    height: 40,
                    child: AvatarCircleButton(
                      onPressed: () {},
                      height: _size.width * 0.06,
                      width: _size.width * 0.08,
                      component: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(30)),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(feedback.image),
                        ),
                      ),
                    ),
                  ),
                  Text(feedback.customerName,
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: Colors.black))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  RatingBarIndicator(
                    rating: double.parse(feedback.star.toString()),
                    itemCount: 5,
                    itemSize: 15.sp,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                      convertFormatHour(
                              DateTime.parse(feedback.feedBackCreateAt)) +
                          " " +
                          convertFormatDate(
                              DateTime.parse(feedback.feedBackCreateAt)),
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          fontSize: 9.sp,
                          color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: Text(feedback.content,
                  style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.w500,
                      fontSize: 11.sp,
                      color: Colors.black)),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
