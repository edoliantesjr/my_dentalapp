import 'package:dentalapp/constants/font_name/font_name.dart';
import 'package:dentalapp/constants/styles/button_style.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'palette_color.dart';

class ThemeStyles {
  ThemeStyles._();

  static ThemeData themeLight = ThemeData(
      fontFamily: FontNames.sfPro,
      backgroundColor: Color(0xcb4987f5),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: Palettes.kcBlueMain1,
        primarySwatch: primaryColorSwatch,
        primaryColorDark: primaryColorSwatch[900],
      ),
      splashColor: Palettes.kcBlueMain1.withOpacity(0.2),
      hintColor: Palettes.kcHintColor,
      dividerColor: Palettes.kcHintColor,
      textTheme: TextTheme(
        bodyText2: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: kfsBody2.sp,
          letterSpacing: 0.5,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ButtonStyles.elevatedButtonThemeDataLight,
      outlinedButtonTheme: ButtonStyles.outlinedButtonThemeDataLight,
      shadowColor: Palettes.kcBlueMain1);
}

final mainColor = 0xff0065FF;
final MaterialColor primaryColorSwatch = MaterialColor(mainColor, <int, Color>{
  50: Color(0xFF80b2ff),
  100: Color(0xFF66a3ff),
  200: Color(0xFF4d93ff),
  300: Color(0xFF3384ff),
  400: Color(0xFF1a74ff),
  500: Color(mainColor),
  600: Color(0xFF005be6),
  700: Color(0xFF0051cc),
  800: Color(0xFF0047b3),
  900: Color(0xff0F3D91),
});
