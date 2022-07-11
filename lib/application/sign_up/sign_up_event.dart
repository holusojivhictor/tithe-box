part of 'sign_up_bloc.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.signUp({
    required String fullName,
    required String emailAddress,
    required String password,
    required String occupation,
    required String churchName,
    required String city,
    required String country,
  }) = _SignUp;
}