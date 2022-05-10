import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/repository/account_repository.dart';
import 'package:farmer_application/src/feature/screen/otp_verify_account/otp_verify_account.dart';
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
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatefulWidget {
  final bool isRegister;
  const RegisterScreen({Key? key, required this.isRegister}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _accountRepository = AccountRepository();
  final _formKey = GlobalKey<FormState>();
  bool isPress = false;
  String phoneNumber = '';
  String verificationId = '';
  int statusCode = 0;
  bool isCall = false;
  int? _resendToken;

  Future<dynamic> checkDuplicatePhoneNumber() async {
    statusCode = await _accountRepository.checkDuplicatePhone(phoneNumber);
    if (statusCode == 200) {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+84" + phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (verificationFailed) async {
          setState(() {isCall = false;});
          UIData.toastMessage("Số điện thoại này không tồn tại");
        },
        codeSent: (verificationId, resendingToken) async {
          setState(() {
            this.verificationId = verificationId;
            _resendToken = resendingToken;
            print("hello   " + _resendToken.toString());
            if (verificationId != '') {
              isCall = false;
              Navigator.push(context, PageTransition(curve: Curves.easeInOut, duration: const Duration(milliseconds: 500),
                      reverseDuration: const Duration(milliseconds: 500), type: PageTransitionType.rightToLeftJoined,
                      child: VerifyOTPAccountScreen(phoneNumber: phoneNumber, verificationId: verificationId,isRegister: widget.isRegister,resendToken: _resendToken,),
                      childCurrent: RegisterScreen(isRegister: widget.isRegister,)));
            }
          });
        },forceResendingToken: _resendToken,
        codeAutoRetrievalTimeout: (verificationId) async {},
      );
    } else if (statusCode == 400) {
      setState(() {isCall = false;});
      UIData.toastMessage("Số điện thoại đã liên kết với một tài khoản khác");
    }
  }

  Future<dynamic> forgotPassword() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+84" + phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {},
      verificationFailed: (verificationFailed) async {
        setState(() {isCall = false;});
        UIData.toastMessage("Số điện thoại này không tồn tại");
      },
      codeSent: (verificationId, resendingToken) async {
        setState(() {
          this.verificationId = verificationId;
          if (verificationId != '') {
            isCall = false;
            Navigator.push(context, PageTransition(curve: Curves.easeInOut, duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 500), type: PageTransitionType.rightToLeftJoined,
                child: VerifyOTPAccountScreen(phoneNumber: phoneNumber, verificationId: verificationId,isRegister: widget.isRegister,resendToken: _resendToken,),
                childCurrent: RegisterScreen(isRegister: widget.isRegister,)));
          }
        });
      }, codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isPress = false;
    phoneNumber = '';
    verificationId = '';
    statusCode = 0;
    isCall = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            body: ProgressHUD(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2,
                    vertical: kPaddingDefault * 3),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: isPress ? AutovalidateMode.always : AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {Navigator.pop(context);},
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: IconWidget(icon: Iconsax.arrow_left, color: const Color.fromRGBO(107, 114, 128, 1.0),
                                fontSize: 20.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: _size.height * 0.022,),
                        widget.isRegister == true ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: _size.width * 0.568,
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .start_your_journey,
                                        style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                            fontSize: 18.sp, color: const Color.fromRGBO(108, 78, 78, 1.0))),
                                  ),
                                  const SizedBox(height: 10,),
                                  Text(
                                      AppLocalizations.of(context)!.di_cho_nao + "!",
                                      style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic, fontSize: 27.sp,
                                          color: const Color.fromRGBO(240, 192, 69, 1.0))),
                                ],
                              ),
                              const Spacer(),
                              IconWidget(icon: Iconsax.sun_1, color: const Color.fromRGBO(240, 192, 69, 1.0),
                                  fontSize: 70.sp, fontWeight: FontWeight.w100),
                            ],
                          ),
                        ) : Text(
                            'Lấy lại mật khẩu',
                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                fontSize: 18.sp, color: Colors.black)),

                        SizedBox(height: _size.height * 0.045,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextFormField(
                            // inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {return 'Vui lòng điền vào chỗ này';}
                            },
                            textInputAction: TextInputAction.next,
                            onChanged: (value) {phoneNumber = value;},
                            decoration: InputDecoration(
                              isDense: _size.height < 700 ? true : false,
                              fillColor: Colors.white,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.3), width: 2),
                              ),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange, width: 1.0),
                                // borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlue.withOpacity(0.6), width: 3),),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              prefixIcon: Icon(Iconsax.call_calling, size: 16.sp,),
                              hintText: AppLocalizations.of(context)!.phone,
                              hintStyle: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                  fontSize: 11.sp, color: Colors.grey),
                            ),
                            autovalidateMode: AutovalidateMode.disabled,
                          ),
                        ),
                        SizedBox(height: _size.height * 0.028,),
                        SizedBox(height: _size.height * 0.01,),
                        Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                              color: const Color.fromRGBO(95, 212, 144, 1.0),),
                            width: _size.width * 0.85, height: _size.height * 0.065,
                            child: TextButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus(); //dismiss keyboard when click button
                                setState(() {
                                  isPress = true;
                                  isCall = true;
                                  if (_formKey.currentState!.validate()) {
                                    widget.isRegister ? checkDuplicatePhoneNumber() : forgotPassword();
                                  } else {isCall = false;}
                                });
                              },
                              child:
                                  Text(widget.isRegister ? AppLocalizations.of(context)!.register : 'Tiếp tục',
                                      style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                          fontSize: 12.sp, color: Colors.white)),)),
                      ],
                    ),
                  ),
                ),
              ),
              inAsyncCall: isCall,
            ),
          ),
        ),
        tablet: SafeArea(child: Scaffold(appBar: AppBar(),),),
        desktop: SafeArea(child: Scaffold(appBar: AppBar(),),));
  }
}
