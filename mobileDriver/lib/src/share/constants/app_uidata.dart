import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIData {
  // // static const String loginImg = 'assets/images/login_image.png';

  static const String loginImg = 'assets/images/login_image.png';
  static const String notification = 'assets/icons/notification.png';
  static const String getStartedGif =
      'assets/jsons/agriculture-technology.json';
  static const String deliveryGif =
      'assets/jsons/delivery.json';
  static const String getProvinceOrCity =
      'assets/jsons/geography/province_city/tinh_tp.json';

  static toastMessage(String text) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 15.0);
  }
}
