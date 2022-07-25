import 'package:dio/dio.dart';

abstract class IncomeService {
  Future<Response> getIncomes(String token, String userId);

  Future<Response> recordIncome(
    String token,
    String userId,
    String accountType,
    String businessName,
    String incomeAmount,
    String description,
    String tithePercentage,
    String frequency,
  );
}
