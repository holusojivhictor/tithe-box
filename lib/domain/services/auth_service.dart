import 'package:tithe_box/domain/models/models.dart';

abstract class AuthService {
  Future<ApiResult<String>> signUp(
    String fullName,
    String email,
    String password,
    String occupation,
    String churchName,
    String city,
    String country,
  );

  Future<ApiResult<String>> signIn(String email, String password);

  Future<ApiResult<String>> signInWithGoogle();

  Future<void> signOut();
}
