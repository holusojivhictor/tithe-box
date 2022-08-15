import 'package:dio/dio.dart';
import 'package:tithe_box/domain/models/models.dart';

abstract class TitheBoxService {
  Future<bool> isTokenActive();

  Future<void> getTokenAndId();
  Future<void> init();

  /// Initialize data
  Future<void> initProfile();
  Future<void> getIncomeData();
  Future<void> getChurchData();
  Future<void> getTransactionData();

  /// User account
  UserProfileModel getProfile();

  /// Income
  List<IncomeCardModel> getIncomesForCard();
  IncomeFileModel getIncome(String id);
  IncomeCardModel getIncomeForCard(String id);
  double totalIncome();

  /// Church
  List<ChurchCardModel> getChurchesForCard();
  ChurchFileModel getChurch(String id);
  ChurchCardModel getChurchForCard(String id);

  /// Transactions
  List<TransactionCardModel> getTransactionsForCard();
  TransactionFileModel getTransaction(String id);
  TransactionCardModel getTransactionForCard(String id);

  Future<Response> recordIncome(
    String currency,
    String businessName,
    String businessAddress,
    String incomeAmount,
    String? description,
    String frequency,
  );

  Future<Response> saveChurch(
    String address,
    String churchName,
    String accountName,
    String accountNumber,
    String countryCode,
    String bankName,
    String bankCode,
    List<String> serviceDays,
  );

  Future<Response> addPayment(
    String incomeId,
    String churchId,
    String accountId,
  );

  Future<void> signOut();
}
