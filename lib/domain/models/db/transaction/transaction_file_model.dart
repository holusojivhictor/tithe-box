// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tithe_box/domain/enums/enums.dart';

part 'transaction_file_model.freezed.dart';
part 'transaction_file_model.g.dart';

@freezed
class TransactionFileModel with _$TransactionFileModel {
  factory TransactionFileModel({
    @JsonKey(name: '_id') required String transactionId,
    @JsonKey(name: 'income_id') required String incomeId,
    required double amount,
    required double tithePercentage,
    required TransactionStatus status,
    required String createdAt,
  }) = _TransactionFileModel;

  TransactionFileModel._();

  factory TransactionFileModel.fromJson(Map<String, dynamic> json) => _$TransactionFileModelFromJson(json);
}
