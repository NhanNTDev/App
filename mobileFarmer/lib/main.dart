import 'dart:io';
import 'package:farmer_application/src/app.dart';
import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/base/base_api.dart';
import 'package:farmer_application/src/core/config/setting/setting_controller.dart';
import 'package:farmer_application/src/core/config/setting/setting_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: kBlueDefault
  // ));
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var token = preferences.getString('token');
  var tokenType = preferences.getString('tokenType');
  var expires = preferences.getString('expires');
  var id = preferences.getString('userId');
  var username = preferences.getString("username");
  var name = preferences.getString('name');
  var email = preferences.getString('email');
  var avatar = preferences.getString('avatar');
  var role = preferences.getString('role');
  var address = preferences.getString('address');
  var phoneNumber = preferences.getString('phoneNumber');
  var gender = preferences.getString('gender');
  var dateOfBirth = preferences.getString('dateOfBirth');

  if(token != null && tokenType != null && expires != null && id != null && username != null
  && name != null && email != null && avatar != null && role != null && address != null && phoneNumber != null
  && gender != null && dateOfBirth != null){

    await storage.write(key: 'token', value: token);
    await storage.write(key: 'tokenType', value: tokenType);
    await storage.write(key: 'expires', value: expires);
    await storage.write(key: 'userId', value: id);
    await storage.write(key: 'username', value: username);
    await storage.write(key: 'name', value: name);
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'avatar', value: avatar);
    await storage.write(key: 'role', value: role);
    await storage.write(key: 'address', value: address);
    await storage.write(key: 'phoneNumber', value: phoneNumber);
    await storage.write(key: 'gender', value: gender);
    await storage.write(key: 'dateOfBirth', value: dateOfBirth);
    tokenSave = token;
  }

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp(settingsController: settingsController));
}
