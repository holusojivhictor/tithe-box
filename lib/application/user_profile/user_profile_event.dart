part of 'user_profile_bloc.dart';

@freezed
class UserProfileEvent with _$UserProfileEvent {
  const factory UserProfileEvent.createProfile({
    required String emailAddress,
    required String firstName,
    required String lastName,
    required String occupation,
    required String churchName,
    required String city,
    required String country,
    required String phoneNumber,
    required List<String> serviceDays,
    required String password,
    required String passwordConfirmation,
  }) = _CreateProfile;
}