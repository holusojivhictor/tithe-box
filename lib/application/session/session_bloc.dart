// ignore_for_file: library_private_types_in_public_api

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/domain/services/services.dart';

part 'session_bloc.freezed.dart';
part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final TitheBoxService _titheBoxService;
  final SettingsService _settingsService;
  final LoggingService _logger;

  SessionBloc(this._titheBoxService, this._settingsService, this._logger) : super(const SessionState.unInitialized()) {
    on<_AppStarted>((event, emit) async {
      final settings = _settingsService.appSettings;
      if (event.init) {
        await Future.delayed(const Duration(milliseconds: 2000));
      }
      if (!settings.isFirstInstall) {
        emit(const SessionState.accountTypeSelection(isInitialize: false));
        return;
      }

      emit(const SessionState.unAuthenticated());
    });

    on<_SelectAccountType>((event, emit) async {
      emit(const SessionState.accountTypeSelection(isInitialize: false));
    });

    on<_StartAuthState>((event, emit) async {
      final hasToken = await checkToken();

      if (hasToken) {
        emit(const SessionState.accountTypeSelection(isInitialize: true));
        await initialize();

        emit(const SessionState.authenticated());
        return;
      }

      emit(const SessionState.authSession());
    });

    on<_LogOut>((event, emit) async {
      await _titheBoxService.signOut();
      emit(const SessionState.accountTypeSelection(isInitialize: false));
    });

    on<_SignUp>((event, emit) async {
      emit(const SessionState.signUpState());
    });

    on<_CreateProfile>((e, emit) async {
      emit(SessionState.userProfileState(email: e.email, phoneNumber: e.phoneNumber, password: e.password, confirmPassword: e.confirmPassword));
    });

    on<_SignIn>((event, emit) async {
      emit(const SessionState.signInState());
    });

    on<_InitStartup>((event, emit) async {
      final hasToken = await checkToken();

      if (!hasToken) {
        emit(const SessionState.unAuthenticated());
        return;
      }

      emit(const SessionState.authenticated());
    });
    on<_VerifyAccount>((event, emit) async {
      emit(const SessionState.verifyState());
    });
  }

  Future<bool> checkToken() async {
    final tokenCheck = await _titheBoxService.isTokenActive();

    return tokenCheck;
  }

  Future<void> initialize() async {
    await _titheBoxService.getTokenAndId();
    await _titheBoxService.init();
    final userData = _titheBoxService.getProfile();
    _logger.info(runtimeType, 'User ${userData.email} signing in...');
  }
}
