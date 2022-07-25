import 'package:dio/dio.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/services/services.dart';

import 'infrastructure.dart';

class IncomeServiceImpl implements IncomeService {
  @override
  Future<Response> getIncomes(String token, String userId) async {
    String url = '$baseUrl/$userId/income';

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> recordIncome(String token, String userId, String accountType, String businessName, String incomeAmount, String description, String tithePercentage, String frequency) async {
    String url = '$baseUrl/$userId/income';

    Map<String, dynamic> body = {
      "user_id": userId,
      "type": accountType,
      "businessName": businessName,
      "amount": incomeAmount,
      "description": description,
      "tithePercentage": tithePercentage,
      "frequency": frequency
    };

    Response response = await dio.post(url, data: body, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }
}