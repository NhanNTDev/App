import 'package:delivery_driver_application/src/feature/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/base/base_api.dart';
import 'core/config/setting/setting_controller.dart';
import 'feature/screen/main/main_screen.dart';

class MyApp extends StatelessWidget {
  final SettingsController settingsController;

  const MyApp({Key? key, required this.settingsController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(325, 672),
      builder: () {
        return AnimatedBuilder(
          animation: settingsController,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              theme: ThemeData(fontFamily: 'BeVietnamPro'),
              // Providing a restorationScopeId allows the Navigator built by the
              // MaterialApp to restore the navigation stack when a user leaves and
              // returns to the app after it has been killed while running in the
              // background.
              restorationScopeId: 'app',
              debugShowCheckedModeBanner: false,
              // Provide the generated AppLocalizations to the MaterialApp. This
              // allows descendant Widgets to display the correct translations
              // depending on the user's locale.
              localizationsDelegates: const [
                // AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('vi', ''), // Vietnam, no country code
                // Locale('en', ''), // English, no country code
              ],

              // Use AppLocalizations to configure the correct application title
              // depending on the user's locale.
              //
              // The appTitle is defined in .arb files found in the localization
              // directory.
              // onGenerateTitle: (BuildContext context) =>
              //     AppLocalizations.of(context)!.appTitle,

              // Define a light and dark color theme. Then, read the user's
              // preferred ThemeMode (light, dark, or system default) from the
              // SettingsController to display the correct theme.
              // theme: ThemeData(),
              // darkTheme: ThemeData.dark(),
              // themeMode: settingsController.themeMode,
              // home: SafeArea(child: MainScreen()),
              home: tokenSave != '' ? const MainScreen(): const LoginScreen(),
            );
          },
        );
      },
    );
  }
}
