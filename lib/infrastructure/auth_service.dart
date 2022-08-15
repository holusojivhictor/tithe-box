import 'package:dio/dio.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/domain/services/services.dart';

final Dio dio = Dio();

class AuthServiceImpl implements AuthService {
  AuthServiceImpl();

  @override
  Future<ApiResult<Response>> registerAccount(
    String firstName,
    String lastName,
    String email,
    String occupation,
    String city,
    String country,
    String phoneNumber,
    String password,
    String passwordConfirmation,
  ) async {
    String url = "$baseUrl/signUp";
    Map<String, dynamic> body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "occupation": occupation,
      "city": city,
      "password": password,
      "confirmPassword": passwordConfirmation,
      "phoneNumber": phoneNumber,
      "country": country
    };

    try {
      final Response response = await dio.post(url, data: body);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<Response>> login(String email, String password) async {
    String url = "$baseUrl/signIn";
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };

    try {
      final Response response = await dio.post(url, data: body);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<Response> getProfile(String userId, String token) async {
    String url = "$baseUrl/$userId";

    final Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));
    return response;
  }
}
