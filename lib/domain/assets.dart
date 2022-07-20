import 'package:tithe_box/domain/enums/enums.dart';

class Assets {
  static String dbPath = 'assets/db';
  static String imageBasePath = 'assets/images';
  static String svgsBasePath = 'assets/svgs';

  static String getImagePath(String name) => '$imageBasePath/$name';
  static String getSvgPath(String name) => '$svgsBasePath/$name';

  static String translateAppLanguageType(AppLanguageType language) {
    switch (language) {
      case AppLanguageType.english:
        return 'English';
      default:
        throw Exception('The provided app language type = $language is not valid');
    }
  }

  static String translateAutoThemeModeType(AutoThemeModeType type) {
    switch (type) {
      case AutoThemeModeType.on:
        return 'Follow OS setting';
      case AutoThemeModeType.off:
        return 'Off';
      default:
        throw Exception('Invalid auto theme mode type = $type');
    }
  }

  static AppThemeType translateThemeTypeBool(bool value) {
    switch (value) {
      case false:
        return AppThemeType.light;
      case true:
        return AppThemeType.dark;
      default:
        throw Exception('Unknown error occurred');
    }
  }
}