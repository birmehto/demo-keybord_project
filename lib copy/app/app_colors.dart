import 'package:demo/utility/preference_utils.dart';
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const lightGradient = [
    Color(0xFF004881),
    Color(0xFFD0E4FF),
  ];
  static const darkGradient = [
    Color(0xFF9FC9FF),
    Color(0xFF00325B),
  ];

  static const MaterialColor indigoSwatch = MaterialColor(
    _indigoPrimaryValue,
    <int, Color>{
      50: Color(0xFFE8EAF6),
      100: Color(0xFFC5CAE9),
      200: Color(0xFF9FA8DA),
      300: Color(0xFF7986CB),
      400: Color(0xFF5C6BC0),
      500: Color(0xFF3F51B5),
      600: Color(0xFF3949AB),
      700: Color(0xFF303F9F),
      800: Color(0xFF283593),
      900: Color(_indigoPrimaryValue),
    },
  );

  static const operatorcolor = Color(0xff272727);
  static const buttonColor = Color(0xff191919);
  static const orangecolor = Color(0xffD9802E);

  static const int _indigoPrimaryValue = 0xFF004881;

  static const Color colorIndigo = Colors.indigo;
  static const Color colorDarkBlue = Color(0xFF1C1F37);
  static const Color colorDarkGray = Color(0xFF6B6D7A);
  static const Color colorGradientStart = Color(0xFF161F59);
  static const Color colorGradientEnd = Color(0xFF631983);
  static const Color lightBackground = Color(0xFFF7F8FC);
  static const Color lightPrimary = colorIndigo;
  static const Color lightAccent = colorDarkBlue;

  static const Color darkBackground = Color(0xFF121212);
  static const Color darkPrimary = colorIndigo;
  static const Color darkAccent = colorDarkGray;
  static Color themeBgColor = PreferenceUtils.getIsTheme()
      ? AppColors.darkAccent
      : AppColors.colorWhite;
  static Color themeBlackWhiteColor = PreferenceUtils.getIsTheme()
      ? AppColors.colorBlack
      : AppColors.colorWhite;

  static LinearGradient gradientBackground = const LinearGradient(
    colors: [colorGradientStart, colorGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Other colors
  static const Color colorAppBar = Color(0XFFF9F6FC);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorBlack = Color(0xFF000000);
  static const Color colorGreen = Colors.green;
  static const Color colorRed = Colors.red;
  static const Color colorUnderline = Color(_indigoPrimaryValue);
  static const Color colorCBCBCB = Color(0xFFCBCBCB);
  static const Color colorF4F4F4 = Color(0xFFF4F4F4);
  static const Color colorGray300 = Color(0xFFE0E0E0);
  static const Color colorGray800 = Color(0xFF424242);
  static const Color colorBoxShadow = Color(0x14000000);

  // Primary colors
  static const Color primary = Color(0xFF004881);
  static const Color primaryContainer = Color(0xFFD0E4FF);
  static const Color primaryDark = Color(0xFF00325B);
  static const Color primaryLight = Color(0xFF9FC9FF);

  // Secondary colors
  static const Color secondary = Color(0xFFAC3306);
  static const Color secondaryContainer = Color(0xFFFFDBCF);
  static const Color secondaryDark = Color(0xFF872100);
  static const Color secondaryLight = Color(0xFFFFB59D);

  // Tertiary colors
  static const Color tertiary = Color(0xFF006875);
  static const Color tertiaryContainer = Color(0xFF95F0FF);
  static const Color tertiaryDark = Color(0xFF004E59);
  static const Color tertiaryLight = Color(0xFF86D2E1);

  // AppBar
  static const Color appBarColor = Color(0xFFFFDBCF);

  // Error colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color errorDark = Color(0xFF93000A);
  static const Color errorLight = Color(0xFFFFB4AB);
}
