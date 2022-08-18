import 'package:flutter/material.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/theme.dart';

extension AppAccentColorTypeExtensions on AppAccentColorType {
  Color getAccentColor() {
    switch (this) {
      case AppAccentColorType.orange:
        return const Color(0xFFDF4903);
      case AppAccentColorType.grey:
        return const Color(0xFF505050);
      default:
        throw Exception('Invalid accent color type = $this');
    }
  }

  ThemeData getLightTheme() {
    final color = getAccentColor();
    final colorScheme = ColorScheme.light(primary: color, secondary: color);
    return ThemeData(
      dividerColor: const Color(0xFFF9F9F9),
      bottomAppBarColor: const Color(0xFFF1F1F1),
      canvasColor: Colors.grey[50],
      cardColor: Colors.white,
      shadowColor: Colors.black,
      indicatorColor: Colors.black,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF1F1F1),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      typography: TitheBoxTheme.textTypography,
      textTheme: TitheBoxTheme.lightTextTheme,
      primaryColor: color,
      colorScheme: colorScheme,
      extensions: const <ThemeExtension<dynamic>>[
        CustomTheme(
          formBorder: Color(0x8A000000),
          categoryOverlay: Color(0xFFE0E0E0),
          altTextColor: Colors.black54,
          baseTextColor: Colors.black,
        ),
      ],
    );
  }

  ThemeData getDarkTheme() {
    final color = getAccentColor();
    final colorScheme = ColorScheme.dark(primary: color, secondary: color);
    return ThemeData(
      dividerColor: Colors.black,
      bottomAppBarColor: const Color(0xFF272C2F),
      canvasColor: Colors.black54,
      cardColor: Colors.grey.shade900,
      shadowColor: Colors.white,
      indicatorColor: Colors.white,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF000000),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      typography: TitheBoxTheme.textTypography,
      textTheme: TitheBoxTheme.darkTextTheme,
      primaryColor: color,
      colorScheme: colorScheme,
      extensions: const <ThemeExtension<dynamic>>[
        CustomTheme(
          formBorder: Color(0xFFBDBDBD),
          categoryOverlay: Color(0xFF616161),
          altTextColor: Colors.white54,
          baseTextColor: Colors.white,
        ),
      ],
    );
  }

  ThemeData getThemeData(AppThemeType theme) {
    switch (theme) {
      case AppThemeType.light:
        return getLightTheme();
      case AppThemeType.dark:
        return getDarkTheme();
      default:
        throw Exception('Invalid app theme type provided = $theme');
    }
  }
}
