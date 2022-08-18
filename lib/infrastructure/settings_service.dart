// ignore_for_file: depend_on_referenced_packages

import 'package:collection/collection.dart' show IterableExtension;
import 'package:devicelocale/devicelocale.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/domain/services/services.dart';

class SettingsServiceImpl extends SettingsService {
  final _appThemeKey = 'AppTheme';
  final _appLanguageKey = 'AppLanguageKey';
  final _appAccentColorKey = 'AppAccentColorKey';
  final _userAccountKey = 'UserAccountKey';
  final _salaryKey = 'SalaryKey';
  final _isFirstInstallKey = 'FirstInstall';
  final _doubleBackToCloseKey = 'DoubleBackToCloseKey';
  final _useDemoImageKey = 'UseDemoImageKey';
  final _autoThemeModeKey = 'AutoThemeModeKey';
  final _tithePercentageKey = 'TithePercentageKey';

  bool _initialized = false;

  late SharedPreferences _prefs;
  final LoggingService _logger;

  SettingsServiceImpl(this._logger);

  @override
  AppThemeType get appTheme => AppThemeType.values[_prefs.getInt(_appThemeKey)!];

  @override
  set appTheme(AppThemeType theme) => _prefs.setInt(_appThemeKey, theme.index);

  @override
  AppLanguageType get language => AppLanguageType.values[_prefs.getInt(_appLanguageKey)!];

  @override
  set language(AppLanguageType lang) => _prefs.setInt(_appLanguageKey, lang.index);

  @override
  AppAccentColorType get accentColor => AppAccentColorType.values[_prefs.getInt(_appAccentColorKey)!];

  @override
  set accentColor(AppAccentColorType accentColor) => _prefs.setInt(_appAccentColorKey, accentColor.index);

  @override
  UserAccountType get accountType => UserAccountType.values[_prefs.getInt(_userAccountKey)!];

  @override
  set accountType(UserAccountType accountType) => _prefs.setInt(_userAccountKey, accountType.index);

  @override
  SalaryType get salaryType => SalaryType.values[_prefs.getInt(_salaryKey)!];

  @override
  set salaryType(SalaryType salaryType) => _prefs.setInt(_salaryKey, salaryType.index);

  @override
  bool get isFirstInstall => _prefs.getBool(_isFirstInstallKey)!;

  @override
  set isFirstInstall(bool itIs) => _prefs.setBool(_isFirstInstallKey, itIs);

  @override
  bool get doubleBackToClose => _prefs.getBool(_doubleBackToCloseKey)!;

  @override
  set doubleBackToClose(bool value) => _prefs.setBool(_doubleBackToCloseKey, value);

  @override
  bool get useDemoImage => _prefs.getBool(_useDemoImageKey)!;

  @override
  set useDemoImage(bool value) => _prefs.setBool(_useDemoImageKey, value);

  @override
  AutoThemeModeType get autoThemeMode => AutoThemeModeType.values[_prefs.getInt(_autoThemeModeKey)!];

  @override
  set autoThemeMode(AutoThemeModeType themeMode) => _prefs.setInt(_autoThemeModeKey, themeMode.index);

  @override
  double get tithePercentage => _prefs.getDouble(_tithePercentageKey)!;

  @override
  set tithePercentage(double value) => _prefs.setDouble(_tithePercentageKey, value);

  @override
  AppSettings get appSettings => AppSettings(
    appTheme: appTheme,
    appLanguage: language,
    accentColor: accentColor,
    accountType: accountType,
    salaryType: salaryType,
    useDarkMode: false,
    isFirstInstall: isFirstInstall,
    doubleBackToClose: doubleBackToClose,
    useDemoImage: useDemoImage,
    themeMode: autoThemeMode,
    tithePercentage: tithePercentage,
  );

  @override
  Future<void> init() async {
    if (_initialized) {
      _logger.info(runtimeType, 'Settings are already initialized!');
      return;
    }

    _logger.info(runtimeType, 'Initializing settings...Getting shared preferences instance...');

    _prefs = await SharedPreferences.getInstance();

    if (_prefs.get(_isFirstInstallKey) == null) {
      _logger.info(runtimeType, 'This is the first install of the app');
      isFirstInstall = true;
    } else {
      isFirstInstall = false;
    }

    if (_prefs.get(_appThemeKey) == null) {
      _logger.info(runtimeType, 'Setting light as the default theme');
      appTheme = AppThemeType.light;
    }

    if (_prefs.get(_appLanguageKey) == null) {
      language = await _getDefaultLangToUse();
    }

    if (_prefs.get(_appAccentColorKey) == null) {
      _logger.info(runtimeType, 'Setting orange as the default accent color');
      accentColor = AppAccentColorType.orange;
    }

    if (_prefs.get(_userAccountKey) == null) {
      _logger.info(runtimeType, 'Setting personal as the default account type');
      accountType = UserAccountType.personal;
    }

    if (_prefs.get(_salaryKey) == null) {
      _logger.info(runtimeType, 'Salary type will be set to monthly');
      salaryType = SalaryType.monthly;
    }

    if (_prefs.get(_doubleBackToCloseKey) == null) {
      _logger.info(runtimeType, 'Double back to close will be set to its default (true)');
      doubleBackToClose = true;
    }

    if (_prefs.get(_useDemoImageKey) == null) {
      _logger.info(runtimeType, 'Use demo image will be set to its default (false)');
      useDemoImage = false;
    }

    if (_prefs.get(_autoThemeModeKey) == null) {
      _logger.info(runtimeType, 'Auto theme mode set to true as default');
      autoThemeMode = AutoThemeModeType.off;
    }

    if (_prefs.getDouble(_tithePercentageKey) == null) {
      _logger.info(runtimeType, 'Tithe percentage set to 10 as default');
      tithePercentage = 10.0;
    }

    _initialized = true;
    _logger.info(runtimeType, 'Settings were initialized successfully');
  }

  Future<AppLanguageType> _getDefaultLangToUse() async {
    try {
      _logger.info(runtimeType, '_getDefaultLangToUse: Trying to retrieve device lang...');
      final deviceLocale = await Devicelocale.currentAsLocale;
      if (deviceLocale == null) {
        _logger.warning(
          runtimeType,
          "_getDefaultLangToUse: Couldn't retrieve the device locale, defaulting to english",
        );
        return AppLanguageType.english;
      }

      final appLang = languagesMap.entries.firstWhereOrNull((val) => val.value.code == deviceLocale.languageCode);
      if (appLang == null) {
        _logger.info(
          runtimeType,
          "_getDefaultLangToUse: Couldn't find an appropriate app language for = ${deviceLocale.languageCode}_${deviceLocale.countryCode}, defaulting to english",
        );
        return AppLanguageType.english;
      }

      _logger.info(
        runtimeType,
        '_getDefaultLangToUse: Found an appropriate language to use for = ${deviceLocale.languageCode}_${deviceLocale.countryCode}, that is = ${appLang.key}',
      );
      return appLang.key;
    } catch (e, s) {
      _logger.error(runtimeType, '_getDefaultLangToUse: Unknown error occurred', e, s);
      return AppLanguageType.english;
    }
  }
}
