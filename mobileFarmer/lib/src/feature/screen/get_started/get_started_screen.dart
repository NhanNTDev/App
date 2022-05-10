import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/screen/login/login_screen.dart';
import 'package:farmer_application/src/feature/screen/register/register_screen.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              // alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      // color: Colors.redAccent,
                      alignment: Alignment.center,
                      height: _size.height * 0.5,
                      width: _size.width * 0.99,
                      // color: Colors.redAccent,
                      child: Lottie.asset(UIData.getStartedGif)),
                  Text(AppLocalizations.of(context)!.di_cho_nao + "!",
                      style: TextStyle(
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w700,
                          // fontSize: 15.sp,
                          fontSize: 28.sp,
                          fontStyle: FontStyle.italic,
                          color: Color.fromRGBO(240, 192, 69, 1.0))),
                  SizedBox(
                    height: _size.height * 0.045,
                  ),
                  SizedBox(
                    width: _size.width * 0.8,
                    child: Text('"' + AppLocalizations.of(context)!.quote + '"',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500,
                            // fontSize: 15.sp,
                            fontSize: 12.sp,
                            fontStyle: FontStyle.italic,
                            color: Color.fromRGBO(115, 113, 113, 1.0))),
                  ),
                  SizedBox(
                    height: _size.height * 0.02,
                  ),
                  SizedBox(
                    height: _size.height * 0.1,
                    width: _size.width * 0.8,
                    // color: Colors.redAccent,
                    child: Row(children: <Widget>[
                      const Expanded(
                          child: Divider(
                        thickness: 2,
                        endIndent: 10,
                      )),
                      Text(AppLocalizations.of(context)!.start,
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                              // fontSize: 15.sp,
                              fontSize: 14.sp,
                              color: Color.fromRGBO(108, 78, 78, 0.7))),
                      const Expanded(
                          child: Divider(
                        thickness: 2,
                        indent: 10,
                      )),
                    ]),
                  ),
                  SizedBox(
                    height: _size.height * 0.02,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color.fromRGBO(95, 212, 144, 1.0),
                      ),
                      width: _size.width * 0.8,
                      height: _size.height * 0.065,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  curve: Curves.easeInOut,
                                  duration: const Duration(milliseconds: 500),
                                  reverseDuration:
                                      const Duration(milliseconds: 500),
                                  type: PageTransitionType.rightToLeftJoined,
                                  child: const LoginScreen(),
                                  childCurrent: const GetStartedScreen()));
                        },
                        child: Text(AppLocalizations.of(context)!.login,
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w600,
                                // fontSize: 15.sp,
                                fontSize: 12.sp,
                                color: Colors.white)),
                      )),
                  SizedBox(
                    width: _size.width * 0.9,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.not_member,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w500,
                                // fontSize: 15.sp,
                                fontSize: 11.sp,
                                color: Colors.black.withOpacity(0.8))),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    curve: Curves.easeInOut,
                                    duration: const Duration(milliseconds: 500),
                                    reverseDuration:
                                        const Duration(milliseconds: 500),
                                    type: PageTransitionType.rightToLeftJoined,
                                    child: RegisterScreen(isRegister: true,),
                                    childCurrent: const GetStartedScreen()));
                          },
                          child: Text(
                              AppLocalizations.of(context)!.register_now,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w500,
                                  // fontSize: 15.sp,
                                  fontSize: 11.sp,
                                  color: Colors.blueAccent.withOpacity(0.8))),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _size.height * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ),
        tablet: SafeArea(
          child: Scaffold(
            appBar: AppBar(),
          ),
        ),
        desktop: SafeArea(
          child: Scaffold(
            appBar: AppBar(),
          ),
        ));
  }
}
