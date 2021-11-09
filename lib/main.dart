import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/constants/styles/theme_style.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/app.router.dart';
import 'constants/styles/palette_color.dart';

final navigationService = locator<NavigationService>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: Palettes.kcBlueMain1,
  ));
  setupLocator();
  await Firebase.initializeApp();
  runApp(DentalApp());
}

class DentalApp extends StatelessWidget {
  const DentalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        builder: () => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigationService.navigatorKey,
              title: 'Dental App',
              onGenerateRoute: StackedRouter().onGenerateRoute,
              themeMode: ThemeMode.light,
              theme: ThemeStyles.themeLight,
              //theme: ThemeData(),
            ));
  }
}
