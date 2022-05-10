import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/repository/account_repository.dart';
import 'package:farmer_application/src/feature/screen/fill_account_info/fill_account_info_screen.dart';
import 'package:farmer_application/src/feature/screen/get_started/get_started_screen.dart';
import 'package:farmer_application/src/feature/screen/main/main_screen.dart';
import 'package:farmer_application/src/feature/screen/register/register_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _accountRepository = AccountRepository();
  bool _obscureText = true;
  String phoneNumber = '';
  String password = '';
  bool clickLogin = false;
  String farmerName = '';
  String farmerId = '';

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
    farmerName = '';
    farmerId = '';
    super.dispose();
  }

  void _toggle() {
    setState(() {_obscureText = !_obscureText;});
  }

  _getFarmerName() async {
    final all = await storage.readAll();
    setState(() {
      all.entries.map((entry) => {
                if (entry.key == 'name')
                  {
                    farmerName = entry.value,
                    if (farmerName != '')
                      {
                        UIData.toastMessage('Đăng nhập thành công'),
                        Navigator.pushAndRemoveUntil(context, PageTransition(
                                curve: Curves.easeInOut, duration: const Duration(milliseconds: 400),
                                reverseDuration: const Duration(milliseconds: 400),
                                type: PageTransitionType.rightToLeftJoined,
                                settings: const RouteSettings(name: "/home"), child: const MainScreen(),
                                childCurrent: const LoginScreen()),
                            (Route<dynamic> route) => false),
                      }
                    else {
                        for (var i in all.entries){
                            if (i.key == 'userId'){
                                farmerId = i.value,
                                if (farmerId != ''){
                                    UIData.toastMessage('Vui lòng điền thông tin cá nhân của bạn'),
                                    Navigator.pushAndRemoveUntil(context, PageTransition(
                                            curve: Curves.easeInOut, duration: const Duration(milliseconds: 400),
                                            reverseDuration: const Duration(
                                                milliseconds: 400), type: PageTransitionType.rightToLeftJoined,
                                            child: FillAccountInfoScreen(farmerId: farmerId, username: phoneNumber,
                                              password: password,),
                                            childCurrent: const LoginScreen()),
                                        (Route<dynamic> route) => false)}
                              }
                          }
                      }
                  }
              })
          .toList(growable: false);
    });
  }

  Future<void> login(String username, String password) async {
    var response = await _accountRepository.login(username, password);
    if (response != null) {
      if (response['status']['status code'] == 200) {
        setState(() {
          clickLogin = false;
          _getFarmerName();
        });
      } else if (response['status']['status code'] == 404) {
        setState(() {clickLogin = false;});
        UIData.toastMessage('Sai tài khoản hoặc mật khẩu');
      }
    } else {
      setState(() {clickLogin = false;});
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
              padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const GetStartedScreen()),
                        );
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: IconWidget(
                            icon: Iconsax.arrow_left,
                            color: const Color.fromRGBO(107, 114, 128, 1.0),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: _size.height * 0.022,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.hello + "!",
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w700,
                                      fontSize: 25.sp, color: const Color.fromRGBO(108, 78, 78, 1.0))),
                              const SizedBox(height: 5,),
                              Text(
                                  AppLocalizations.of(context)!.lets_login_to_continue,
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                      fontSize: 13.sp, color: const Color.fromRGBO(107, 114, 128, 1.0))),
                            ],
                          ),
                          const Spacer(),
                          IconWidget(icon: Iconsax.sun_1, color: const Color.fromRGBO(240, 192, 69, 1.0),
                              fontSize: 62.sp, fontWeight: FontWeight.w300),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 4.5),
                      child: Image.asset(UIData.loginImg),
                    ),
                    SizedBox(height: _size.height * 0.047,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {phoneNumber = value;},
                        decoration: InputDecoration(
                          isDense: _size.height < 700 ? true : false,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.orange, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue.withOpacity(0.6), width: 2.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          prefixIcon: Icon(Iconsax.call_calling, size: 16.sp,),
                          hintText: AppLocalizations.of(context)!.phone,
                          hintStyle: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                              fontSize: 11.sp, color: Colors.grey),
                        ), autovalidateMode: AutovalidateMode.disabled,
                      ),
                    ),
                    SizedBox(height: _size.height * 0.028,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {password = value;},
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          isDense: _size.height < 700 ? true : false,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.orange, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue.withOpacity(0.6), width: 2.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          prefixIcon: Icon(Iconsax.unlock, size: 16.sp,),
                          hintText: AppLocalizations.of(context)!.password,
                          hintStyle: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                              fontSize: 11.sp, color: Colors.grey),
                          suffixIcon: TextButton(
                              style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
                              onPressed: _toggle,
                              child: Icon(_obscureText ? Iconsax.eye_slash : Iconsax.eye,
                                size: 16.sp, color: Colors.grey,)),
                        ),
                        autovalidateMode: AutovalidateMode.disabled,
                      ),
                    ),
                    SizedBox(height: _size.height * 0.05,),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color.fromRGBO(95, 212, 144, 1.0),),
                        width: _size.width * 0.85,
                        height: _size.height * 0.065,
                        child: TextButton(
                          onPressed: clickLogin ? null : () {
                                  setState(() {clickLogin = true;});
                                  login(phoneNumber, password);
                                },
                          child: clickLogin ? const SizedBox(
                                  height: 20, width: 20,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,))
                              : Text(AppLocalizations.of(context)!.login,
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                      fontSize: 12.sp, color: Colors.white)),)),
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
                                    child: const RegisterScreen(isRegister: false,),
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
        tablet: SafeArea(child: Scaffold(appBar: AppBar(),),),
        desktop: SafeArea(child: Scaffold(appBar: AppBar(),),));
  }
}
