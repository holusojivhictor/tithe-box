part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.init() = _Init;

  const factory SettingsEvent.themeChanged({
    required AppThemeType newValue,
  }) = _ThemeChanged;

  const factory SettingsEvent.languageChanged({
    required AppLanguageType newValue,
  }) = _LanguageChanged;

  const factory SettingsEvent.accentColorChanged({
    required AppAccentColorType newValue,
  }) = _AccentColorChanged;

  const factory SettingsEvent.userAccountTypeChanged({
    required UserAccountType newValue,
  }) = _UserAccountTypeChanged;

  const factory SettingsEvent.salaryTypeChanged({
    required SalaryType newValue,
  }) = _SalaryTypeChanged;

  const factory SettingsEvent.doubleBackToCloseChanged({
    required bool newValue,
  }) = _DoubleBackToCloseChanged;

  const factory SettingsEvent.useDemoProfilePictureChanged({
    required bool newValue,
  }) = _UseDemoProfilePictureChanged;

  const factory SettingsEvent.autoThemeModeTypeChanged({
    required AutoThemeModeType newValue,
  }) = _AutoThemeModeTypeChanged;

  const factory SettingsEvent.tithePercentageChanged({
    required double newValue,
  }) = _TithePercentageChanged;
}
