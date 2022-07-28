import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/application/result/result_state.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/domain/services/services.dart';

part 'sign_in_bloc.freezed.dart';
part 'sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, ResultState<Response>> {
  final AuthService _authService;
  final TitheBoxService _titheBoxService;
  final LoggingService _logger;
  final SessionBloc _sessionBloc;

  SignInBloc(this._authService, this._titheBoxService, this._logger, this._sessionBloc) : super(const ResultState.idle()) {
    on<_SignIn>((event, emit) async {
      emit(const ResultState.loading());
      ApiResult<Response> apiResult = await _authService.login(event.emailAddress, event.password);
      await apiResult.when(
        success: (Response response) async {
          final json = response.data as Map<String, dynamic>;
          await _saveData(json);
          emit(ResultState.data(data: response));
          await _titheBoxService.getTokenAndId();
          await _titheBoxService.init().whenComplete(() => emit(const ResultState.done()));
          final userData = _titheBoxService.getProfile();
          _logger.info(runtimeType, 'User ${userData.email} signing in...');
          _sessionBloc.add(const SessionEvent.initStartup());
        },
        failure: (NetworkExceptions error) async {
          emit(ResultState.error(error: error));
        },
      );
    });
  }

  Future<void> _saveData(Map<String, dynamic> json) async {
    final token = json["token"] as String;
    final userId = json["_id"] as String;
    await saveString(key: tokenStorageKey, value: token);
    await saveString(key: userIdStorageKey, value: userId);
  }
}