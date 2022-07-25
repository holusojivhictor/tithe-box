import 'package:dio/dio.dart';
import 'package:tithe_box/domain/models/models.dart';

abstract class TitheBoxService {
  Future<bool> isTokenActive();

  Future<void> getTokenAndId();
  Future<void> init();

  /// Initialize data
  Future<void> initProfile();
  Future<void> getIncomeData();

  /// User account
  UserProfileModel getProfile();

  /// Income
  List<IncomeCardModel> getIncomesForCard();
  IncomeFileModel getIncome(String id);
  IncomeCardModel getIncomeForCard(String id);

  Future<Response> recordIncome(
    String businessName,
    String incomeAmount,
    String description,
    String frequency,
  );

  Future<void> signOut();
}
