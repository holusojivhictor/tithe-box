import 'package:tithe_box/domain/models/models.dart';

abstract class AuthService {
  Future<ApiResult<String>> signUp(String email, String password);

  Future<ApiResult<String>> signIn(String email, String password);

  Future<ApiResult<String>> signInWithGoogle();

  Future<void> signOut();
}