import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  factory UserProfileModel({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String occupation,
    required String city,
    required String country,
  }) = _UserProfileModel;

  UserProfileModel._();

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);
}
