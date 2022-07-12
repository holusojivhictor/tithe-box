part of 'user_profile_bloc.dart';

@freezed
class UserProfileEvent with _$UserProfileEvent {
  const factory UserProfileEvent.createProfile({
    required String fullName,
    required String emailAddress,
    required String occupation,
    required String churchName,
    required String city,
    required String country,
  }) = _CreateProfile;
}