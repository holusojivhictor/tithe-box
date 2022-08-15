import 'package:dio/dio.dart';

abstract class PaymentService {
  Future<Response> getTransactions(String token, String userId);

  Future<Response> addPayment(
    String token,
    String userId,
    String incomeId,
    String churchId,
    String accountId,
  );
}
