import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/application/result/result_state.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/domain/services/services.dart';

part 'sign_up_bloc.freezed.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, ResultState<String>> {
  final AuthService _authService;
  final SessionBloc _sessionBloc;

  SignUpBloc(this._authService, this._sessionBloc) : super(const ResultState.idle()) {
    on<_SignUp>((event, emit) async {
      emit(const ResultState.loading());
      ApiResult<String> apiResult = await _authService.signUp(event.emailAddress, event.password);
      apiResult.when(
        success: (String response) async {
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