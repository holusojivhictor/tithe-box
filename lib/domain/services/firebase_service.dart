import 'package:tithe_box/domain/models/models.dart';

abstract class FirebaseService {
  Future<void> saveUserCredentials(UserModel userModel);

  Future<UserModel> getUserCredentials();
}