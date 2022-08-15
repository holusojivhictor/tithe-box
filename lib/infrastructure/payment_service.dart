import 'package:dio/dio.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/services/services.dart';

import 'infrastructure.dart';

class PaymentServiceImpl implements PaymentService {
  @override
  Future<Response> getTransactions(String token, String userId) async {
    String url = '$baseUrl/$userId/transactions';

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> addPayment(String token, String userId, String incomeId, String churchId, String accountId) async {
    String url = '$baseUrl/$userId/income/$incomeId/pay/church/$churchId/accounts/$accountId';

    Response response = await dio.post(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }
}
