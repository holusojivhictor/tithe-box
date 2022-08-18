// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/services/services.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsService _settingsService;
  final DeviceInfoService _deviceInfoService;
  final MainBloc _mainBloc;

  SettingsBloc(
      this._settingsService,
      this._deviceInfoService,
      this._mainBloc,
      ) : super(const SettingsState.loading()) {
    on<_Init>(_mapInitToState);
    on<_ThemeChanged>(_mapThemeChangedToState);
    on<_LanguageChanged>(_mapLanguageChangedToState);
    on<_AccentColorChanged>(_mapAccentColorChangedToState);
    on<_UserAccountTypeChanged>(_mapUserAccountTypeChangedToState);
    on<_SalaryTypeChanged>(_mapSalaryTypeChangedToState);
    on<_DoubleBackToCloseChanged>(_mapDoubleBackToCloseToState);
    on<_UseDemoProfilePictureChanged>(_mapUseDemoPictureToState);
    on<_AutoThemeModeTypeChanged>(_mapAutoThemeModeChangedToState);
    on<_TithePercentageChanged>(_mapTithePercentageChangedToState);
  }

  _LoadedState get currentState => state as _LoadedState;

  void _mapInitToState(_Init event, Emitter<SettingsState> emit) {
    final settings = _settingsService.appSettings;

    emit(SettingsState.loaded(
      currentTheme: settings.appTheme,
      currentLanguage: settings.appLanguage,
      currentAccentColor: settings.accentColor,
      accountType: settings.accountType,
      salaryType: settings.salaryType,
      appVersion: _deviceInfoService.version,
      doubleBackToClose: settings.doubleBackToClose,
      useDemoProfilePicture: settings.useDemoImage,
      themeMode: settings.themeMode,
      tithePercentage: settings.tithePercentage,
    ));
  }

  void _mapThemeChangedToState(_ThemeChanged event, Emitter<SettingsState> emit) {
    if (event.newValue == _settingsService.appTheme) {
      emit(currentState);
    }
    _settingsService.appTheme = event.newValue;
    _mainBloc.add(MainEvent.themeChanged(newValue: event.newValue));
    emit(currentState.copyWith.call(currentTheme: event.newValue));
  }

  void _mapLanguageChangedToState(_LanguageChanged event, Emitter<SettingsState> emit) {
    if (event.newValue == _settingsService.language) {
      emit(currentState);
    }
    _settingsService.language = event.newValue;
    emit(currentState.copyWith.call(currentLanguage: event.newValue));
  }

  void _mapAccentColorChangedToState(_AccentColorChanged event, Emitter<SettingsState> emit) {
    if (event.newValue == _settingsService.accentColor) {
      emit(currentState);
    }
    _settingsService.accentColor = event.newValue;
    _mainBloc.add(MainEvent.accentColorChanged(newValue: event.newValue));
    emit(currentState.copyWith.call(currentAccentColor: event.newValue));
  }

  void _mapUserAccountTypeChangedToState(_UserAccountTypeChanged event, Emitter<SettingsState> emit) {
    if (event.newValue == _settingsService.accountType) {
      emit(currentState);
    }
    _settingsService.accountType = event.newValue;
    emit(currentState.copyWith.call(accountType: event.newValue));
  }

  void _mapSalaryTypeChangedToState(_SalaryTypeChanged event, Emitter<SettingsState> emit) {
    if (event.newValue == _settingsService.salaryType) {
      emit(currentState);
    }
    _settingsService.salaryType = event.newValue;
    emit(currentState.copyWith.call(salaryType: event.newValue));
  }

  void _mapDoubleBackToCloseToState(_DoubleBackToCloseChanged event, Emitter<SettingsState> emit) {
    _settingsService.doubleBackToClose = event.newValue;
    emit(currentState.copyWith.call(doubleBackToClose: event.newValue));
  }

  void _mapUseDemoPictureToState(_UseDemoProfilePictureChanged event, Emitter<SettingsState> emit) {
    _settingsService.useDemoImage = event.newValue;
    emit(currentState.copyWith.call(useDemoProfilePicture: event.newValue));
  }

  void _mapTithePercentageChangedToState(_TithePercentageChanged event, Emitter<SettingsState> emit) {
    _settingsService.tithePercentage = event.newValue;
    emit(currentState.copyWith.call(tithePercentage: event.newValue));
  }

  void _mapAutoThemeModeChangedToState(_AutoThemeModeTypeChanged event, Emitter<SettingsState> emit) {
    if (event.newValue == _settingsService.autoThemeMode) {
      emit(currentState);
    }
    _settingsService.autoThemeMode = event.newValue;
    _mainBloc.add(MainEvent.themeModeChanged(newValue: event.newValue));
    emit(currentState.copyWith.call(themeMode: event.newValue));
  }

  bool doubleBackToClose() => _settingsService.doubleBackToClose;
}
