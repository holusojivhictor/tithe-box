import 'package:dio/dio.dart';

abstract class ChurchService {
  Future<Response> getChurches(String token, String userId);

  Future<Response> saveChurch(
    String token,
    String userId,
    String address,
    String churchName,
    String accountName,
    String accountNumber,
    String countryCode,
    String bankName,
    String bankCode,
    List<String> serviceDays,
  );
}
