import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/extensions/string_extensions.dart';

class Assets {
  static String dbPath = 'assets/db';
  static String imageBasePath = 'assets/images';
  static String svgsBasePath = 'assets/svgs';

  static String getImagePath(String name) => '$imageBasePath/$name';
  static String getSvgPath(String name) => '$svgsBasePath/$name';

  static String getDescription(String? desc) {
    if (desc.isNullEmptyOrWhitespace) {
      return 'No description';
    }
    return '$desc';
  }

  static String getBannerSvgPath(AppAccentColorType accentColor) {
    switch (accentColor) {
      case AppAccentColorType.orange:
        return getSvgPath('mask-vector-orange.svg');
      case AppAccentColorType.grey:
        return getSvgPath('mask-vector-grey.svg');
      default:
        throw Exception('Invalid accent color type = $accentColor');
    }
  }

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

  static String translateHomeContentType(HomeContentType type) {
    switch (type) {
      case HomeContentType.all:
        return 'All';
      case HomeContentType.addIncome:
        return 'Add Income';
      case HomeContentType.tithingSlider:
        return 'Tithe %';
      case HomeContentType.progress:
        return 'Progress';
      default:
        throw Exception('Invalid home content type = $type');
    }
  }

  static String translateSalaryType(SalaryType type) {
    switch (type) {
      case SalaryType.daily:
        return 'Daily';
      case SalaryType.weekly:
        return 'Weekly';
      case SalaryType.monthly:
        return 'Monthly';
      case SalaryType.yearly:
        return 'Yearly';
      case SalaryType.random:
        return 'Random';
      default:
        throw Exception('Invalid salary type = $type');
    }
  }

  static String translateTransactionStatus(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.pending:
        return 'Pending';
      case TransactionStatus.successful:
        return 'Successful';
      default:
        throw Exception('Invalid status type = $status');
    }
  }
}
