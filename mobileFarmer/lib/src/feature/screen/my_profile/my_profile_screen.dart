import 'dart:async';
import 'dart:io';

import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/base/base_api.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/repository/account_repository.dart';
import 'package:farmer_application/src/feature/screen/farm_management/add_new_farm/components/dotted_border_button.dart';
import 'package:farmer_application/src/feature/screen/farm_management/add_new_farm/components/label_widget.dart';
import 'package:farmer_application/src/feature/screen/login/login_screen.dart';
import 'package:farmer_application/src/feature/screen/my_profile/change_password/change_password_screen.dart';
import 'package:farmer_application/src/feature/screen/my_profile/update_information/update_information_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:farmer_application/src/share/widget/stateless/progress_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _accountRepository = AccountRepository();
  bool isChangeImage = false;
  List<XFile>? _imageFileList;
  String pathAvatar = '';
  String farmerId = '';
  bool isPress = false;
  int statusCode = 0;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  String? _retrieveDataError;
  final ImagePicker _picker1 = ImagePicker();

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    await _displayPickImageDialog(context!,
        (double? maxWidth, double? maxHeight, int? quality) async {
      try {
        final XFile? pickedFile = await _picker1.pickImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        setState(() {
          if(pickedFile!.length() != 0){
            isCall = true;
            _imageFile = pickedFile;
            changeAvatar();
          }
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              key: UniqueKey(),
              itemBuilder: (BuildContext context, int index) {
                return Semantics(
                    label: 'Cập nhật ảnh đại diện của tài khoản',
                    child: Container(
                        alignment: Alignment.center,
                        height: 200,
                        width: 100,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(180),
                              child: Image.file(
                                File(_imageFileList![index].path),
                                fit: BoxFit.fitWidth,
                                width: 180,
                                height: 180,
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 20,
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.redAccent),
                                    child: TextButton(
                                      child: IconWidget(
                                          icon: Iconsax.camera,
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                      onPressed: () {
                                        _onImageButtonPressed(
                                            ImageSource.gallery,
                                            context: context);
                                      },
                                    )))
                          ],
                        )));
              },
              itemCount: _imageFileList!.length,
            ),
          ),
          label: 'Cập nhật ảnh đại diện của nông trại');
    } else if (_pickImageError != null) {
      return DottedBorderButton(
        color: isPress ? Colors.redAccent : Colors.blueAccent,
        onPressed: () {
          _onImageButtonPressed(ImageSource.gallery, context: context);
        },
      );
    } else {
      return DottedBorderButton(
        color: isPress ? Colors.redAccent : Colors.blueAccent,
        onPressed: () {
          _onImageButtonPressed(ImageSource.gallery, context: context);
        },
      );
    }
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    onPick(4000.0, 4000.0, 100);
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker1.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _imageFile = response.file;
          _imageFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  _getFarmerAvatar() async {
    final all = await storage.readAll();
    setState(() {
      all.entries
          .map((entry) => {
                if (entry.key == 'avatar')
                  {
                    pathAvatar = entry.value,
                  },
                if (entry.key == 'userId')
                  {
                    farmerId = entry.value,
                  }
              })
          .toList(growable: false);
    });
  }

  bool isCall = false;

  Future<dynamic> changeAvatar() async {
    var response = await _accountRepository.updateAvatar(
        farmerId,
        _imageFileList != null && _imageFileList!.isNotEmpty
            ? _imageFileList![0].path
            : '');
    setState(() {
      if (response["statusCode"] == 200) {
        isCall = false;
        UIData.toastMessage("Cập nhật thành công");
        changePathInStorage(response["pathImage"]);
        _getFarmerAvatar();
      } else {
        isCall = false;
        UIData.toastMessage("Cập nhật thất bại");
      }
    });
  }

  Future<void> changePathInStorage(String url) async {
    await storage.write(key: 'avatar', value: url);
  }

  Future<dynamic> logout() async {
    await storage.deleteAll();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
    preferences.remove('tokenType');
    preferences.remove('expires');
    preferences.remove('userId');
    preferences.remove("username");
    preferences.remove('name');
    preferences.remove('email');
    preferences.remove('avatar');
    preferences.remove('role');
    preferences.remove('address');
    preferences.remove('phoneNumber');
    preferences.remove('gender');
    preferences.remove('dateOfBirth');

    preferences.get('dateOfBirth');
    if (preferences.get('token') == null &&
        preferences.get('tokenType') == null &&
        preferences.get('expires') == null &&
        preferences.get('userId') == null &&
        preferences.get("username") == null &&
        preferences.get('name') == null &&
        preferences.get('email') == null &&
        preferences.get('avatar') == null &&
        preferences.get('role') == null &&
        preferences.get('address') == null &&
        preferences.get('phoneNumber') == null &&
        preferences.get('gender') == null &&
        preferences.get('dateOfBirth') == null) {
      setState(() {
        isCall = false;
        tokenSave = '';
        UIData.toastMessage("Đã đăng xuất");
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 400),
                reverseDuration: const Duration(milliseconds: 400),
                type: PageTransitionType.rightToLeftJoined,
                // settings: RouteSettings(name: "/home"),
                child: LoginScreen(),
                childCurrent: const MyProfileScreen()),
            (Route<dynamic> route) => false);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFarmerAvatar();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pathAvatar = '';
    statusCode = 0;
    isCall = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: SafeArea(
          child: ProgressHUD(
            inAsyncCall: isCall,
            child: Scaffold(
              // backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: kBlueDefault,
                elevation: 0,
                toolbarHeight: 250,
                title: Column(
                  children: [
                    pathAvatar != '' &&
                            (_imageFileList == null || _imageFileList == [])
                        ? Semantics(
                            child: Container(
                                alignment: Alignment.center,
                                height: 180,
                                width: 180,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        pathAvatar,
                                        fit: BoxFit.fitWidth,
                                        width: 180,
                                        height: 180,
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 20,
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white),
                                            child: TextButton(
                                              child: IconWidget(
                                                  icon: Iconsax.camera,
                                                  color: Colors.blue,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600),
                                              onPressed: () {
                                                _onImageButtonPressed(
                                                    ImageSource.gallery,
                                                    context: context);
                                              },
                                            )))
                                  ],
                                )),
                            label: 'image_picker_example_picked_images')
                        : Container(),
                    const SizedBox(
                      height: 15,
                    ),
                    (_imageFileList == null || _imageFileList == [])
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: !kIsWeb &&
                                    defaultTargetPlatform ==
                                        TargetPlatform.android
                                ? FutureBuilder<void>(
                                    future: retrieveLostData(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<void> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.waiting:
                                          return DottedBorderButton(
                                            color: Colors.blueAccent,
                                            onPressed: () {
                                              _onImageButtonPressed(
                                                  ImageSource.gallery,
                                                  context: context);
                                            },
                                          );
                                        case ConnectionState.done:
                                          return _handlePreview();
                                        default:
                                          if (snapshot.hasError) {
                                            return DottedBorderButton(
                                              color: Colors.redAccent,
                                              onPressed: () {
                                                _onImageButtonPressed(
                                                    ImageSource.gallery,
                                                    context: context);
                                              },
                                            );
                                          } else {
                                            return DottedBorderButton(
                                              color: Colors.blueAccent,
                                              onPressed: () {
                                                _onImageButtonPressed(
                                                    ImageSource.gallery,
                                                    context: context);
                                              },
                                            );
                                          }
                                      }
                                    },
                                  )
                                : _handlePreview(),
                          ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Tài khoản',
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                                color: Colors.black)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        // height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        curve: Curves.easeInOut,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        reverseDuration:
                                            const Duration(milliseconds: 400),
                                        type: PageTransitionType
                                            .rightToLeftJoined,
                                        // settings: RouteSettings(name: "/home"),
                                        child: UpdateInfoAccountScreen(
                                          farmerId: farmerId,
                                        ),
                                        childCurrent: const MyProfileScreen()));
                              },
                              child: Row(
                                children: [
                                  Container(
                                      width: 40,
                                      child: IconWidget(
                                          icon: Iconsax.note,
                                          color: Colors.grey,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500)),
                                  Text('Cập nhật thông tin',
                                      style: TextStyle(
                                          fontFamily: 'BeVietnamPro',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.sp,
                                          color: Colors.black)),
                                  Spacer(),
                                  IconWidget(
                                      icon: Iconsax.arrow_right,
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        curve: Curves.easeInOut,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        reverseDuration:
                                            const Duration(milliseconds: 400),
                                        type: PageTransitionType
                                            .rightToLeftJoined,
                                        // settings: RouteSettings(name: "/home"),
                                        child: ChangePasswordScreen(
                                          farmerId: farmerId,
                                        ),
                                        childCurrent: const MyProfileScreen()));
                              },
                              child: Row(
                                children: [
                                  Container(
                                      width: 40,
                                      child: IconWidget(
                                          icon: Iconsax.lock,
                                          color: Colors.grey,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500)),
                                  Text('Đổi mật khẩu',
                                      style: TextStyle(
                                          fontFamily: 'BeVietnamPro',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.sp,
                                          color: Colors.black)),
                                  Spacer(),
                                  IconWidget(
                                      icon: Iconsax.arrow_right,
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Xác nhận'),
                                    content: const Text('Bạn muốn đăng xuất?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Không'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isCall = true;
                                          });
                                          Navigator.pop(context, 'ON');
                                          logout();
                                        },
                                        child: const Text('Có'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                      width: 40,
                                      child: IconWidget(
                                          icon: Iconsax.logout,
                                          color: Colors.grey,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500)),
                                  Text('Đăng xuất',
                                      style: TextStyle(
                                          fontFamily: 'BeVietnamPro',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.sp,
                                          color: Colors.black)),
                                  Spacer(),
                                  IconWidget(
                                      icon: Iconsax.arrow_right,
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Liên hệ với chúng tôi',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Colors.black)),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Số điện thoại: 0965910772',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              color: Colors.black)),
                    ],
                  ),
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
