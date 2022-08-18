part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.loading() = _LoadingState;

  const factory SettingsState.loaded({
    required AppThemeType currentTheme,
    required AppLanguageType currentLanguage,
    required AppAccentColorType currentAccentColor,
    required UserAccountType accountType,
    required SalaryType salaryType,
    required String appVersion,
    required bool doubleBackToClose,
    required bool useDemoProfilePicture,
    required AutoThemeModeType themeMode,
    required double tithePercentage,
  }) = _LoadedState;
}
