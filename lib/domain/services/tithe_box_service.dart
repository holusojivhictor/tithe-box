import 'package:tithe_box/domain/models/models.dart';

abstract class TitheBoxService {
  Future<bool> isTokenActive();

  Future<void> getTokenAndId();
  Future<void> init();

  /// Initialize data
  Future<void> initProfile();

  /// User account
  UserProfileModel getProfile();

  Future<void> signOut();
}