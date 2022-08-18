part of 'session_bloc.dart';

@freezed
class SessionEvent with _$SessionEvent {
  const factory SessionEvent.appStarted({required bool init}) = _AppStarted;

  const factory SessionEvent.logOutRequested() = _LogOut;

  const factory SessionEvent.selectAccountType() = _SelectAccountType;

  const factory SessionEvent.startAuthState() = _StartAuthState;

  const factory SessionEvent.signUpRequested() = _SignUp;

  const factory SessionEvent.createProfile({
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) = _CreateProfile;

  const factory SessionEvent.signInRequested() = _SignIn;

  const factory SessionEvent.initStartup() = _InitStartup;

  const factory SessionEvent.verify() = _VerifyAccount;
}
