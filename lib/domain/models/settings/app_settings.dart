import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/domain/enums/enums.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

@freezed
class AppSettings with _$AppSettings {
  factory AppSettings({
    required AppThemeType appTheme,
    required AppLanguageType appLanguage,
    required AppAccentColorType accentColor,
    required UserAccountType accountType,
    required SalaryType salaryType,
    required bool useDarkMode,
    required bool isFirstInstall,
    required bool doubleBackToClose,
    required bool useDemoImage,
    required AutoThemeModeType themeMode,
    required double tithePercentage,
  }) = _AppSettings;

  const AppSettings._();

  factory AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);
}
