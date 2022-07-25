import 'package:tithe_box/domain/enums/enums.dart';

class IncomeCardModel {
  final String id;
  final UserAccountType type;
  final String businessName;
  final double amount;
  final SalaryType frequency;
  final String createdAt;

  IncomeCardModel({
    required this.id,
    required this.type,
    required this.businessName,
    required this.amount,
    required this.frequency,
    required this.createdAt,
  });
}