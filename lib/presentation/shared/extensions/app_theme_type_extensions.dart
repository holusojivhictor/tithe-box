import 'package:flutter/material.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/theme.dart';

extension AppThemeTypeExtensions on AppThemeType {
  ThemeData getThemeData(AppThemeType theme) {
    switch (theme) {
      case AppThemeType.light:
        return TitheBoxTheme.light();
      case AppThemeType.dark:
        return TitheBoxTheme.dark();
      default:
        throw Exception('Invalid theme type = $theme');
    }
  }
}