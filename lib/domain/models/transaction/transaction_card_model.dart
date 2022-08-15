import 'package:tithe_box/domain/enums/enums.dart';

class TransactionCardModel {
  final String id;
  final double amount;
  final double tithePercentage;
  final TransactionStatus status;
  final String createdAt;

  TransactionCardModel({
    required this.id,
    required this.amount,
    required this.tithePercentage,
    required this.status,
    required this.createdAt,
  });
}
