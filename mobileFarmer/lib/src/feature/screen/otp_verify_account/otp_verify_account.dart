import 'dart:async';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/screen/create_password_account/create_password_account.dart';
import 'package:farmer_application/src/feature/screen/forgot_password/forgot_password_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:farmer_application/src/share/widget/stateless/progress_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOTPAccountScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? verificationId;
  final int? resendToken;
  final bool isRegister;

  const VerifyOTPAccountScreen(
      {Key? key, this.phoneNumber, this.verificationId, required this.isRegister, required this.resendToken})
      : super(key: key);

  @override
  _VerifyOTPAccountScreenState createState() => _VerifyOTPAccountScreenState();
}

class _VerifyOTPAccountScreenState extends State<VerifyOTPAccountScreen> {
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController textEditingController = TextEditingController();
  String otp = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isPress = false;
  bool checkOTP = true;
  bool isCall = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.clear();
    otp = '';
    isPress = false;
    checkOTP = true;
    isCall = false;
    super.dispose();
  }

  Future resendOTP() async{
    await _auth.verifyPhoneNumber(
      phoneNumber: "+84" + widget.phoneNumber.toString(),
      verificationCompleted: (phoneAuthCredential) async {},
      verificationFailed: (verificationFailed) async {
        // setState(() {isCall = false;});
        // UIData.toastMessage("Số điện thoại này không tồn tại");
      },
      codeSent: (verificationId, resendingToken) async {
        setState(() {
          verificationId = verificationId;
          if (verificationId != null) {
            // UIData.toastMessage('hello');
            // isCall = false;
            // Navigator.push(context, PageTransition(curve: Curves.easeInOut, duration: const Duration(milliseconds: 500),
            //     reverseDuration: const Duration(milliseconds: 500), type: PageTransitionType.rightToLeftJoined,
            //     child: VerifyOTPAccountScreen(phoneNumber: phoneNumber, verificationId: verificationId,),
            //     childCurrent: const RegisterScreen()));
          }
        });
      },forceResendingToken: widget.resendToken,
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }


  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential).catchError((e){
            setState(() {
              checkOTP = false;
              isCall = false;
              print(checkOTP);
            });
          });
      setState(() {
        if (authCredential.user != null) {
          isCall = false;
          widget.isRegister ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreatePasswordAccountScreen(
                    phoneNumber: widget.phoneNumber,
                    isRegister: widget.isRegister,
                  ))) : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ForgotPasswordScreen(
                    phoneNumber: widget.phoneNumber,
                  )));
        } else {
          isCall = false;
          checkOTP = false;
        }
      });
    } on FirebaseAuthException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Responsive(
        mobile: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.white,
          body: ProgressHUD(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPaddingDefault * 1, vertical: kPaddingDefault * 3),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: IconWidget(
                                icon: Iconsax.arrow_left,
                                color: Color.fromRGBO(107, 114, 128, 1.0),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text('Nhập mã xác minh',
                              style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w600,
                                  // fontSize: 15.sp,
                                  fontSize: 16.sp,
                                  color: Color.fromRGBO(0, 0, 0, 1.0))),
                        ],
                      ),
                      SizedBox(
                        height: _size.height * 0.05,
                      ),
                      Text('Mã xác minh của bạn đã được gửi tới số',
                          style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500,
                            // fontSize: 15.sp,
                            fontSize: 11.5.sp,
                            color: const Color.fromRGBO(107, 114, 128, 1.0),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(widget.phoneNumber.toString(),
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                              // fontSize: 15.sp,
                              fontSize: 14.sp,
                              color: Color.fromRGBO(0, 0, 0, 1.0))),
                      SizedBox(
                        height: _size.height * 0.05,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingDefault * 2),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          errorTextSpace: 20,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          length: 6,
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: _size.height * 0.055,
                              fieldWidth: _size.width * 0.095,
                              activeColor: Colors.green.shade600,
                              errorBorderColor: Colors.green.shade600,
                              inactiveColor: Colors.green.shade600,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              selectedFillColor: Colors.white),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          // inputFormatters: <TextInputFormatter>[
                          //   WhitelistingTextInputFormatter.digitsOnly
                          // ],
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {},
                          onChanged: (value) {
                            setState(() {
                              otp = value;
                              // currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                      isPress && checkOTP == false
                          ? Container(
                        // width: _size.width * 0.45,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        alignment: Alignment.center,
                        child: Text('Mã OTP chưa đúng',
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                                color: Colors.red[700])),
                      )
                          : Container(),
                      SizedBox(
                        height: _size.height * 0.02,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color.fromRGBO(95, 212, 144, 1.0),
                          ),
                          width: _size.width * 0.85,
                          height: _size.height * 0.065,
                          child: TextButton(
                            onPressed: () {
                              // controller.forward();
                              FocusScope.of(context)
                                  .unfocus(); //dismiss keyboard when click button
                              setState(() {
                                isPress = true;
                                isCall = true;
                                PhoneAuthCredential phoneAuthCredential =
                                PhoneAuthProvider.credential(
                                    verificationId:
                                    widget.verificationId.toString(),
                                    smsCode: otp);

                                signInWithPhoneAuthCredential(
                                    phoneAuthCredential);
                                // print(phoneAuthCredential.token);
                              });
                            },
                            child: Text(AppLocalizations.of(context)!.continues,
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    // fontSize: 15.sp,
                                    fontSize: 12.sp,
                                    color: Colors.white)),
                          )),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Không nhận được OTP?',
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w500,
                                // fontSize: 15.sp,
                                fontSize: 11.5.sp,
                                color: Colors.black,
                              )),
                          Container(
                            width: 60,
                            child: TextButton(
                              onPressed: () {
                                resendOTP();
                              },
                              child: Text('Gửi lại',
                                  style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                    fontSize: 11.5.sp,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            inAsyncCall: isCall,
          ),
        )),
        tablet: SafeArea(
            child: Scaffold(
          appBar: AppBar(),
        )),
        desktop: SafeArea(
            child: Scaffold(
          appBar: AppBar(),
        )));
  }
}
