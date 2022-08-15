import 'package:dio/dio.dart';
import 'package:tithe_box/domain/models/models.dart';

abstract class AuthService {
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
  );

  Future<ApiResult<Response>> login(String email, String password);

  Future<Response> getProfile(String userId, String token);

  Future<ApiResult<String>> signUp(String email, String password);

  Future<ApiResult<String>> createUserProfile(
    String fullName,
    String email,
    String occupation,
    String churchName,
    String city,
    String country,
  );

  Future<ApiResult<String>> signIn(String email, String password);

  Future<ApiResult<String>> signInWithGoogle();

  Future<void> signOut();
}
