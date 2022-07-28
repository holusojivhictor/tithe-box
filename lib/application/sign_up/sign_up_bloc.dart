import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/application/result/result_state.dart';
import 'package:tithe_box/domain/models/models.dart';

part 'sign_up_bloc.freezed.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, ResultState<String>> {
  final SessionBloc _sessionBloc;

  SignUpBloc(this._sessionBloc) : super(const ResultState.idle()) {
    on<_SignUp>((e, emit) async {
      emit(const ResultState.loading());
      ApiResult<String> apiResult = const ApiResult.success(data: "Email added successfully");
      await apiResult.when(
        success: (String response) async {
          _sessionBloc.add(SessionEvent.createProfile(email: e.emailAddress, phoneNumber: e.phoneNumber, password: e.password, confirmPassword: e.confirmPassword));
          emit(ResultState.data(data: response));
        },
        failure: (NetworkExceptions error) async {
          emit(ResultState.error(error: error));
        },
      );
    });
  }
}