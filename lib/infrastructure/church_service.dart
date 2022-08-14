import 'package:dio/dio.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/services/services.dart';

import 'infrastructure.dart';

class ChurchServiceImpl implements ChurchService {
  @override
  Future<Response> getChurches(String token, String userId) async {
    String url = '$baseUrl/$userId/churches';

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
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
  ) async {
    String url = '$baseUrl/$userId/churches';

    Map<String, dynamic> body = {
      "address": address,
      "name": churchName,
      "serviceDays": serviceDays,
      "accountName": accountName,
      "accountNumber": accountNumber,
      "country": countryCode,
      "bank": {
        "code": bankCode,
        "name": bankName
      }
    };

    Response response = await dio.post(url, data: body, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }
}
