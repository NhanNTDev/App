import 'package:delivery_driver_application/src/core/config/responsive/app_responsive.dart';
import 'package:delivery_driver_application/src/feature/repository/account_repository.dart';
import 'package:delivery_driver_application/src/feature/screen/forgot_password_user/forgot_password_user_screen.dart';
import 'package:delivery_driver_application/src/feature/screen/main/main_screen.dart';
import 'package:delivery_driver_application/src/share/constants/app_constant.dart';
import 'package:delivery_driver_application/src/share/constants/app_uidata.dart';
import 'package:delivery_driver_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  String phoneNumber = '';
  String password = '';
  bool clickLogin = false;
  final AccountRepository _accountRepository = AccountRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _obscureText = true;
    phoneNumber = '';
    password = '';
    clickLogin = false;
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> login(String username, String password) async {
    var response = await _accountRepository.login(username, password);
    if(response != null){
      if (response['status']['status code'] == 200) {
        setState(() {
          setState(() {
            clickLogin = false;
            print('login success');
          });
        });
        UIData.toastMessage('Đăng nhập thành công');
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 400),
                reverseDuration: const Duration(milliseconds: 400),
                type: PageTransitionType.rightToLeftJoined,
                settings: RouteSettings(
                    name: "/home"),
                child: const MainScreen(),
                childCurrent: const LoginScreen()),
                (Route<dynamic> route) => false
        );
        // Navigator.push(
        //     context,
        //     PageTransition(
        //         curve: Curves.easeInOut,
        //         duration: const Duration(milliseconds: 400),
        //         reverseDuration: const Duration(milliseconds: 400),
        //         type: PageTransitionType.rightToLeftJoined,
        //         settings: RouteSettings(
        //             name: "/home"),
        //         child: const MainScreen(),
        //         childCurrent: const LoginScreen()));
      } else if (response['status']['status code'] == 404) {
        setState(() {
          clickLogin = false;
          print('login fail');
        });
        UIData.toastMessage('Sai tài khoản hoặc mật khẩu');
      }
    }else {
      setState(() {
        clickLogin = false;
        print('login fail');
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            body: Container(
              alignment: Alignment.center,
              padding:
              const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: _size.height * 0.015,
                    ),
                    Container(
                      // color: Colors.redAccent,
                        alignment: Alignment.center,
                        height: _size.height * 0.4,
                        width: _size.width * 0.99,
                        // color: Colors.redAccent,
                        child: Lottie.asset(UIData.deliveryGif)),
                    SizedBox(
                      height: _size.height * 0.08,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text("Đăng nhập",
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                              // fontSize: 15.sp,
                              fontSize: 16.sp,
                              color: Colors.black)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      // padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                        // maxLines: maxLines,
                        decoration: InputDecoration(
                          isDense: _size.height < 700 ? true : false,
                          // contentPadding: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
                          // labelText: "Resevior Name",
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.orange, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlue.withOpacity(0.6),
                                width: 2.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // label: label,
                          // labelText: "Tên nông trại",
                          // labelStyle: TextStyle(fontSize: 18),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          prefixIcon: Icon(
                            Iconsax.user,
                            size: 16.sp,
                          ),
                          // prefixIcon: IconWidget(
                          //   fontSize: 14.sp,
                          //   color: Colors.grey,
                          //   fontWeight: FontWeight.w600,
                          //   icon: Iconsax.user,
                          // ),
                          hintText: "Tài khoản",
                          hintStyle: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
                              color: Colors.grey),
                          // suffixIcon: suffixIcon,
                        ),
                        // The validator receives the text that the user has entered.
                        autovalidateMode: AutovalidateMode.disabled,
                        // validator: validator,
                      ),
                    ),
                    SizedBox(
                      height: _size.height * 0.028,
                    ),
                    SizedBox(
                      // padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          password = value;
                        },
                        // maxLines: maxLines,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          isDense: _size.height < 700 ? true : false,
                          // contentPadding: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
                          // labelText: "Resevior Name",
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.orange, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlue.withOpacity(0.6),
                                width: 2.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // label: label,
                          // labelText: "Tên nông trại",
                          // labelStyle: TextStyle(fontSize: 18),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          prefixIcon: Icon(
                            Iconsax.unlock,
                            size: 16.sp,
                          ),
                          // prefixIcon: IconWidget(
                          //   fontSize: 14.sp,
                          //   color: Colors.grey,
                          //   fontWeight: FontWeight.w600,
                          //   icon: Iconsax.user,
                          // ),
                          hintText: "Mật khẩu",
                          hintStyle: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
                              color: Colors.grey),
                          suffixIcon: TextButton(
                              style: const ButtonStyle(
                                  splashFactory: NoSplash.splashFactory),
                              onPressed: _toggle,
                              child: Icon(
                                _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                                size: 16.sp,
                                color: Colors.grey,
                              )),
                        ),
                        // The validator receives the text that the user has entered.
                        autovalidateMode: AutovalidateMode.disabled,
                        // validator: validator,
                      ),
                    ),
                    SizedBox(
                      height: _size.height * 0.06,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color.fromRGBO(255, 174, 79, 1.0),
                        ),
                        width: _size.width * 0.85,
                        height: _size.height * 0.065,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              // clickLogin = true;
                              clickLogin = !clickLogin;
                            });
                            login(phoneNumber, password);
                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //         curve: Curves.easeInOut,
                            //         duration: const Duration(milliseconds: 500),
                            //         reverseDuration:
                            //         const Duration(milliseconds: 500),
                            //         type: PageTransitionType.rightToLeftJoined,
                            //         child: const MainScreen(),
                            //         childCurrent: const LoginScreen()));
                          },
                          child: clickLogin
                              ? Container(
                              height: 20,
                              width: 20,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ))
                              : Text("Đăng nhập",
                              style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w600,
                                  // fontSize: 15.sp,
                                  fontSize: 12.sp,
                                  color: Colors.white)),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Quên mật khẩu?',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                fontSize: 11.sp, color: Colors.black.withOpacity(0.8))),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, PageTransition(
                                curve: Curves.easeInOut, duration: const Duration(milliseconds: 500),
                                reverseDuration: const Duration(milliseconds: 500),
                                type: PageTransitionType.rightToLeftJoined,
                                child: const ForgotPasswordUserScreen(isRegister: false,),
                                childCurrent: const LoginScreen()));
                          },
                          child: Text(
                              'Lấy lại',
                              textAlign: TextAlign.center,
                              style: TextStyle(decoration: TextDecoration.underline, fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w500, fontSize: 11.sp,
                                  color: Colors.blueAccent.withOpacity(0.8))),
                        ),
                      ],
                    )
                  ],
                ),
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
