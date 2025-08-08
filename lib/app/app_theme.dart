import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



abstract final class AppTheme {
  // TextTheme configurations
  static const TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: Color(0xFF004881)),
    displayMedium: TextStyle(
        fontSize: 45, fontWeight: FontWeight.w400, color: Color(0xFF004881)),
    displaySmall: TextStyle(
        fontSize: 36, fontWeight: FontWeight.w400, color: Color(0xFF004881)),
    headlineLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.w400, color: Color(0xFF004881)),
    headlineMedium: TextStyle(
        fontSize: 28, fontWeight: FontWeight.w400, color: Color(0xFF004881)),
    headlineSmall: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w400, color: Color(0xFF004881)),
    titleLarge: TextStyle(
        fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFF004881)),
    titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: Color(0xFF004881)),
    titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: Color(0xFF004881)),
    bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: Colors.black87),
    bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: Colors.black87),
    bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: Colors.black54),
    labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: Color(0xFF004881)),
    labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: Color(0xFF004881)),
    labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: Color(0xFF004881)),
  );

  static const TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: Color(0xFF9FC9FF)),
    // Using primary color
    displayMedium: TextStyle(
        fontSize: 45, fontWeight: FontWeight.w400, color: Color(0xFF9FC9FF)),
    displaySmall: TextStyle(
        fontSize: 36, fontWeight: FontWeight.w400, color: Color(0xFF9FC9FF)),
    headlineLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.w400, color: Color(0xFF9FC9FF)),
    headlineMedium: TextStyle(
        fontSize: 28, fontWeight: FontWeight.w400, color: Color(0xFF9FC9FF)),
    headlineSmall: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w400, color: Color(0xFF9FC9FF)),
    titleLarge: TextStyle(
        fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFF9FC9FF)),
    titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: Color(0xFF9FC9FF)),
    titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: Color(0xFF9FC9FF)),
    bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: Colors.white),
    bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: Colors.white),
    bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: Colors.white70),
    labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: Color(0xFF9FC9FF)),
    labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: Color(0xFF9FC9FF)),
    labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: Color(0xFF9FC9FF)),
  );

  // The FlexColorScheme defined light mode ThemeData.
  static ThemeData light = FlexThemeData.light(
    // User defined custom colors made with FlexSchemeColor() API.
    colors: const FlexSchemeColor(
      primary: Color(0xFF004881),
      primaryContainer: Color(0xFFD0E4FF),
      secondary: Color(0xFFAC3306),
      secondaryContainer: Color(0xFFFFDBCF),
      tertiary: Color(0xFF006875),
      tertiaryContainer: Color(0xFF95F0FF),
      appBarColor: Color(0xFFFFDBCF),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
    ),
    // Text theme
    textTheme: lightTextTheme,
    // Component theme configurations for light mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: false,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(
      applyThemeToAll: true,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(fontFamily: 'Noto Sans'),
      ),
    ),
  );

  // The FlexColorScheme defined dark mode ThemeData.
  static ThemeData dark = FlexThemeData.dark(
    // User defined custom colors made with FlexSchemeColor() API.
    colors: const FlexSchemeColor(
      primary: Color(0xFF9FC9FF),
      primaryContainer: Color(0xFF00325B),
      primaryLightRef: Color(0xFF004881),
      secondary: Color(0xFFFFB59D),
      secondaryContainer: Color(0xFF872100),
      secondaryLightRef: Color(0xFFAC3306),
      tertiary: Color(0xFF86D2E1),
      tertiaryContainer: Color(0xFF004E59),
      tertiaryLightRef: Color(0xFF006875),
      appBarColor: Color(0xFFFFDBCF),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
    ),
    // Text theme
    textTheme: darkTextTheme,
    // Component theme configurations for dark mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: false,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(
      applyThemeToAll: true,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(fontFamily: 'Noto Sans'),
      ),
    ),
  );
}
