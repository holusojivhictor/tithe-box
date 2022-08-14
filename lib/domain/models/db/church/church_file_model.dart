// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/domain/enums/enums.dart';

part 'church_file_model.freezed.dart';
part 'church_file_model.g.dart';

@freezed
class ChurchFileModel with _$ChurchFileModel {
  factory ChurchFileModel({
    @JsonKey(name: '_id') required String churchId,
    @JsonKey(name: 'user_id') required String userId,
    required String name,
    required List<ChurchServiceDay> serviceDays,
    required String address,
    required List<String> subAccountIds,
  }) = _ChurchFileModel;

  ChurchFileModel._();

  factory ChurchFileModel.fromJson(Map<String, dynamic> json) => _$ChurchFileModelFromJson(json);
}
