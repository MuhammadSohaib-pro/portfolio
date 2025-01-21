import 'package:flutter/material.dart';
import 'package:portfolio/res/app_text_theme.dart';

class AppColors {
  static const mainColor = Color(0xFF55E5A4);
  static const mainColorLight = Color(0xFF151c26);
  static const whiteff = Color(0xffFFFFFF);
  static const black00 = Color(0xff000000);
  static const black1 = Color(0xff1c1b1f);
  static const grey1 = Color(0xFF79747e);
  static const grey2 = Color(0xFF49454f);
  static const grey3 = Color(0xFFc2c2c2);
  static const grey4 = Color(0xFFe5e5e5);
  static const grey5 = Color(0xff6d6972);
  static const grey6 = Color(0xFF6750A4);
  static const grey7 = Color(0xFFd9d9d9);
  static const darkGrey = Color(0xFF363340);
  static const yellow = Color(0xFFF0A215);
  static const green = Color(0xFF27B43E);
  static const green1 = Color(0xFF49bb3f);
  static const red = Color(0xFFE61010);
  static const scaffoolBgColorDark = Color(0xFF151C25);
  static const scaffoolBgColorLight = Color(0xFFF0F0F4);
  static const fillColor = Color(0xFFf7f2fa);
}

class Palette {
  static const MaterialColor palette1 = MaterialColor(
    _palette1PrimaryValue,
    <int, Color>{
      50: Color(0xFFE3FBF3),
      100: Color(0xFFB8F5E0),
      200: Color(0xFF8AEDCB),
      300: Color(0xFF5CE5B6),
      400: Color(0xFF37DFA6),
      500: Color(_palette1PrimaryValue),
      600: Color(0xFF4EDD9C),
      700: Color(0xFF44D491),
      800: Color(0xFF3BCC86),
      900: Color(0xFF2ABC72),
    },
  );

  static const int _palette1PrimaryValue = 0xFF55E5A4;
}

class AppTheme {
  AppTheme._();

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.mainColor,
    scaffoldBackgroundColor: AppColors.scaffoolBgColorDark,
    textTheme: AppTextTheme.darkTextTheme,
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.mainColorLight,
    scaffoldBackgroundColor: AppColors.scaffoolBgColorLight,
    textTheme: AppTextTheme.lightTextTheme,
  );
}
