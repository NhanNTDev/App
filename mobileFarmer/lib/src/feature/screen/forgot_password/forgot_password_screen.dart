import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/repository/account_repository.dart';
import 'package:farmer_application/src/feature/screen/fill_account_info/fill_account_info_screen.dart';
import 'package:farmer_application/src/feature/screen/login/login_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:farmer_application/src/share/constants/validation.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:farmer_application/src/share/widget/stateless/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String? phoneNumber;

  const ForgotPasswordScreen({Key? key, this.phoneNumber}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool isPress = false;
  String password = '';
  String confirmPassword = '';
  final _accountRepository = AccountRepository();
  int statusCode = 0;
  bool isCall = false;

  Future<dynamic> forgotPassword(String phoneNumber, String password) async {
    statusCode = await _accountRepository.forgotPassword(phoneNumber, password);
    setState(() {
      if (statusCode == 200) {
        isCall = false;
        UIData.toastMessage('Cập nhật thành công');
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 400),
                reverseDuration: const Duration(milliseconds: 400),
                type: PageTransitionType.rightToLeftJoined,
                child: const LoginScreen(),
                childCurrent: const ForgotPasswordScreen()),
            (Route<dynamic> route) => false);
      } else {
        isCall = false;
        UIData.toastMessage("Đã có lỗi xảy ra");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _obscureText = true;
    isPress = false;
    password = '';
    confirmPassword = '';
    statusCode = 0;
    isCall = false;
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
                    horizontal: kPaddingDefault * 1,
                    vertical: kPaddingDefault * 3),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: isPress
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
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
                            Text('Tạo mật khẩu mới',
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
                        SizedBox(
                          // padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Bạn cần phải điền mật khẩu';
                              } else if (isPassword(value) == false) {
                                return 'Mật khẩu phải theo các quy tắc: \n - Từ 8 kí tự trở lên \n - Không chứa kí tự đặc biệt \n - Phải chứa ít nhất 1 kí tự in hoa \n - Phải chứa ít nhât 1 số';
                              }
                            },
                            textInputAction: TextInputAction.next,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                              hintText: AppLocalizations.of(context)!.password +
                                  " mới",
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
                                    _obscureText
                                        ? Iconsax.eye_slash
                                        : Iconsax.eye,
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
                          height: _size.height * 0.028,
                        ),
                        SizedBox(
                          // padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Bạn cần phải xác nhận mật khẩu';
                              }
                              if (value != password) {
                                return 'Xác nhận không khớp với mật khẩu';
                              }
                            },
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {
                              confirmPassword = value;
                            },
                            // maxLines: maxLines,
                            obscureText: true,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                              hintText: AppLocalizations.of(context)!
                                  .confirm_password,
                              hintStyle: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp,
                                  color: Colors.grey),
                            ),
                            // The validator receives the text that the user has entered.
                            autovalidateMode: AutovalidateMode.disabled,
                            // validator: validator,
                          ),
                        ),
                        SizedBox(
                          height: _size.height * 0.055,
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
                                FocusScope.of(context).unfocus(); //dismiss key
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Xác nhận'),
                                    content: const Text('Xác nhận mật khẩu?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Không'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'ON');
                                          setState(() {
                                            isPress = true;
                                            isCall = true;
                                            // Validate returns true if the form is valid, or false otherwise.
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // If the form is valid, display a snackbar. In the real world,
                                              // you'd often call a server or save the information in a database.
                                              // ScaffoldMessenger.of(context).showSnackBar(
                                              //   const SnackBar(
                                              //       content: Text('Processing Data')),
                                              // );
                                              // registerFarmer(widget.phoneNumber.toString(), password);
                                              forgotPassword(widget.phoneNumber.toString(), password);
                                            } else {
                                              isCall = false;
                                            }
                                          });
                                        },
                                        child: const Text('Có'),
                                      ),
                                    ],
                                  ),
                                ); // board when click button

                                // Navigator.push(
                                //     context,
                                //     PageTransition(
                                //         curve: Curves.easeInOut,
                                //         duration: const Duration(milliseconds: 500),
                                //         reverseDuration:
                                //         const Duration(milliseconds: 500),
                                //         type: PageTransitionType.rightToLeftJoined,
                                //         child: const LoginScreen(),
                                //         childCurrent: const GetStartedScreen()));
                              },
                              child:
                                  Text('Xác nhận',
                                      style: TextStyle(
                                          fontFamily: 'BeVietnamPro',
                                          fontWeight: FontWeight.w600,
                                          // fontSize: 15.sp,
                                          fontSize: 12.sp,
                                          color: Colors.white)),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              inAsyncCall: isCall,
            ),
          ),
        ),
        tablet: SafeArea(
            child: Scaffold(
          appBar: AppBar(),
        )),
        desktop: SafeArea(
          child: Scaffold(
            appBar: AppBar(),
          ),
        ));
  }
}
