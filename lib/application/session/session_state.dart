part of 'session_bloc.dart';

@freezed
class SessionState with _$SessionState {
  const factory SessionState.unInitialized() = _UnInitializedState;

  const factory SessionState.unAuthenticated() = _UnAuthenticatedState;

  const factory SessionState.accountTypeSelection({
    required bool isInitialize,
  }) = _AccountTypeSelectionState;

  const factory SessionState.authSession() = _AuthSessionState;

  const factory SessionState.signUpState() = _SignUpState;

  const factory SessionState.userProfileState({
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) = _UserProfileState;

  const factory SessionState.signInState() = _SignInState;

  const factory SessionState.authenticated() = _AuthenticatedState;

  const factory SessionState.verifyState() = _VerifyAccountState;
}
