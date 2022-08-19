import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/domain/services/services.dart';

class TitheBoxServiceImpl implements TitheBoxService {
  final AuthService _authService;
  final IncomeService _incomeService;
  final ChurchService _churchService;
  final PaymentService _paymentService;
  final SettingsService _settingsService;
  late String token;
  late String userId;
  late UserProfileFile _userProfileFile;
  late List<IncomeFileModel> _incomeFile = <IncomeFileModel>[];
  late List<ChurchFileModel> _churchFile = <ChurchFileModel>[];
  late List<TransactionFileModel> _transactionFile = <TransactionFileModel>[];

  TitheBoxServiceImpl(this._authService, this._incomeService, this._churchService, this._paymentService, this._settingsService);

  @override
  Future<void> init() async {
    await Future.wait([
      initProfile(),
      getIncomeData(),
      getChurchData(),
      getTransactionData(),
    ]);
  }

  @override
  Future<void> getTokenAndId() async {
    final savedToken = await getSavedString(key: tokenStorageKey);
    final savedId = await getSavedString(key: userIdStorageKey);
    token = savedToken;
    userId = savedId;
  }

  @override
  Future<void> initProfile() async {
    final response = await _authService.getProfile(userId, token);
    final json = response.data as Map<String, dynamic>;
    _userProfileFile = UserProfileFile.fromJson(json);
  }

  @override
  Future<void> getIncomeData() async {
    final response = await _incomeService.getIncomes(token, userId);
    final list = response.data as List;
    _incomeFile = list.map((e) => IncomeFileModel.fromJson(e)).toList();
  }

  @override
  Future<void> getChurchData() async {
    final response = await _churchService.getChurches(token, userId);
    final list = response.data as List;
    _churchFile = list.map((e) => ChurchFileModel.fromJson(e)).toList();
  }

  @override
  Future<void> getTransactionData() async {
    final response = await _paymentService.getTransactions(token, userId);
    final list = response.data as List;
    _transactionFile = list.map((e) => TransactionFileModel.fromJson(e)).toList();
  }

  @override
  IncomeFileModel getIncome(String id) {
    return _incomeFile.firstWhere((el) => el.incomeId == id);
  }

  @override
  IncomeCardModel getIncomeForCard(String id) {
    final income = _incomeFile.firstWhere((el) => el.incomeId == id);
    return _toIncomeForCard(income);
  }

  List<IncomeFileModel> _incomesByAccountType() {
    final accountType = _settingsService.accountType;
    return _incomeFile.where((el) => el.type == accountType).toList();
  }

  @override
  List<IncomeCardModel> getIncomesForCard() {
    return _incomesByAccountType().map((e) => _toIncomeForCard(e)).toList();
  }

  @override
  double totalIncome() {
    final List<double> amounts = _incomesByAccountType().map((e) => e.amount).toList();
    return amounts.fold(0, (previous, element) => previous + element);
  }

  @override
  ChurchFileModel getChurch(String id) {
    return _churchFile.firstWhere((el) => el.churchId == id);
  }

  @override
  ChurchCardModel getChurchForCard(String id) {
    final church = _churchFile.firstWhere((el) => el.churchId == id);
    return _toChurchForCard(church);
  }

  @override
  List<ChurchCardModel> getChurchesForCard() {
    return _churchFile.map((e) => _toChurchForCard(e)).toList();
  }

  @override
  TransactionFileModel getTransaction(String id) {
    return _transactionFile.firstWhere((el) => el.transactionId == id);
  }

  @override
  TransactionCardModel getTransactionForCard(String id) {
    final transaction = _transactionFile.firstWhere((el) => el.transactionId == id);
    return _toTransactionForCard(transaction);
  }

  @override
  List<TransactionCardModel> getTransactionsForCard() {
    final incomeIds = _incomesByAccountType().map((e) => e.incomeId).toList();
    final transactionFile = _transactionFile.where((el) => incomeIds.contains(el.incomeId)).toList();
    return transactionFile.map((e) => _toTransactionForCard(e)).toList();
  }

  TransactionCardModel _toTransactionForCard(TransactionFileModel model) {
    return TransactionCardModel(
      id: model.transactionId,
      amount: model.amount,
      tithePercentage: model.tithePercentage,
      status: model.status,
      createdAt: model.createdAt,
    );
  }

  IncomeCardModel _toIncomeForCard(IncomeFileModel model) {
    final transactions = _transactionFile.where((el) => el.incomeId == model.incomeId).toList();
    final mapped = transactions.map((e) => e.status).toList();
    return IncomeCardModel(
      id: model.incomeId,
      type: model.type,
      businessName: model.businessName,
      businessAddress: model.businessAddress,
      amount: model.amount,
      description: model.description,
      tithePercentage: model.tithePercentage,
      frequency: model.frequency,
      createdAt: model.createdAt,
      isPaid: mapped.contains(TransactionStatus.successful),
    );
  }

  ChurchCardModel _toChurchForCard(ChurchFileModel model) {
    final accountId = model.subAccountIds.first;
    return ChurchCardModel(
      id: model.churchId,
      name: model.name,
      serviceDays: model.serviceDays,
      accountId: accountId,
      address: model.address,
    );
  }

  @override
  UserProfileModel getProfile() {
    return _userProfileFile.user;
  }

  @override
  Future<Response> recordIncome(String currency, String businessName, String businessAddress, String incomeAmount, String? description, String frequency) async {
    final settings = _settingsService.appSettings;

    final response = await _incomeService.recordIncome(
      token,
      userId,
      settings.accountType.name,
      currency,
      businessName,
      businessAddress,
      incomeAmount,
      description,
      settings.tithePercentage.toString(),
      frequency,
    );

    return response;
  }

  @override
  Future<Response> saveChurch(String address, String churchName, String accountName, String accountNumber, String countryCode, String bankName, String bankCode, List<String> serviceDays) async {
    final response = await _churchService.saveChurch(
      token,
      userId,
      address,
      churchName,
      accountName,
      accountNumber,
      countryCode,
      bankName,
      bankCode,
      serviceDays,
    );

    return response;
  }

  @override
  Future<Response> addPayment(String incomeId, String churchId, String accountId) async {
    final response = await _paymentService.addPayment(token, userId, incomeId, churchId, accountId);

    return response;
  }

  @override
  Future<bool> isTokenActive() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(tokenStorageKey);

    if (value != null) {
      return true;
    }
    return false;
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenStorageKey);
    await prefs.remove(userIdStorageKey);
  }
}
