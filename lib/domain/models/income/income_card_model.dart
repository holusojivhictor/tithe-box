import 'package:tithe_box/domain/enums/enums.dart';

class IncomeCardModel {
  final String id;
  final UserAccountType type;
  final String businessName;
  final String businessAddress;
  final double amount;
  final String description;
  final SalaryType frequency;
  final String createdAt;

  IncomeCardModel({
    required this.id,
    required this.type,
    required this.businessName,
    required this.businessAddress,
    required this.amount,
    required this.description,
    required this.frequency,
    required this.createdAt,
  });
}
