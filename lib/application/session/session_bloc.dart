import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/domain/services/services.dart';

part 'session_bloc.freezed.dart';
part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final TitheBoxService _titheBoxService;
  final LoggingService _logger;

  SessionBloc(this._titheBoxService, this._logger) : super(const SessionState.unInitialized()) {
    on<_AppStarted>((event, emit) async {
      if (event.init) {
        await Future.delayed(const Duration(milliseconds: 2000));
      }
      emit(const SessionState.unAuthenticated());
    });

    on<_SelectAccountType>((event, emit) async {
      emit(const SessionState.accountTypeSelection());
    });

    on<_StartAuthState>((event, emit) async {
      emit(const SessionState.authSession());
    });

    on<_LogOut>((event, emit) async {
      await _titheBoxService.signOut();
      emit(const SessionState.unAuthenticated());
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
      await _titheBoxService.getTokenAndId();
      await _titheBoxService.init();
      final userData = _titheBoxService.getProfile();
      _logger.info(runtimeType, 'User ${userData.email} signing in...');

      emit(const SessionState.authenticated());
    });
  }

  Future<bool> checkToken() async {
    final tokenCheck = await _titheBoxService.isTokenActive();

    return tokenCheck;
  }
}