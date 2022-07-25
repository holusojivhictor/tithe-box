// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/domain/enums/enums.dart';

part 'income_file_model.freezed.dart';
part 'income_file_model.g.dart';

@freezed
class IncomeFileModel with _$IncomeFileModel {
  factory IncomeFileModel({
    @JsonKey(name: '_id') required String incomeId,
    @JsonKey(name: 'user_id') required String userId,
    required UserAccountType type,
    required String businessName,
    required double amount,
    required String description,
    required double tithePercentage,
    required SalaryType frequency,
    required String createdAt,
  }) = _IncomeFileModel;

  IncomeFileModel._();

  factory IncomeFileModel.fromJson(Map<String, dynamic> json) => _$IncomeFileModelFromJson(json);
}