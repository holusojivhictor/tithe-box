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
  final SessionBloc _sessionBloc;

  SignInBloc(this._authService, this._sessionBloc) : super(const ResultState.idle()) {
    on<_SignIn>((event, emit) async {
      emit(const ResultState.loading());
      ApiResult<Response> apiResult = await _authService.login(event.emailAddress, event.password);
      apiResult.when(
        success: (Response response) async {
          final json = response.data as Map<String, dynamic>;
          final token = json["token"] as String;
          final userId = json["_id"] as String;
          await saveString(key: tokenStorageKey, value: token);
          await saveString(key: userIdStorageKey, value: userId);
          _sessionBloc.add(const SessionEvent.initStartup());
          emit(ResultState.data(data: response));
        },
        failure: (NetworkExceptions error) async {
          emit(ResultState.error(error: error));
        },
      );
    });
  }
}