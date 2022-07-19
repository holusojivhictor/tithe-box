part of 'sign_up_bloc.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.signUp({
    required String emailAddress,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) = _SignUp;
}