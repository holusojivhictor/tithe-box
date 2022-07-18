import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/domain/models/models.dart';

part 'user_profile_file.freezed.dart';
part 'user_profile_file.g.dart';

@freezed
class UserProfileFile with _$UserProfileFile {
  factory UserProfileFile({
    required UserProfileModel user,
  }) = _UserProfileFile;

  UserProfileFile._();

  factory UserProfileFile.fromJson(Map<String, dynamic> json) => _$UserProfileFileFromJson(json);
}