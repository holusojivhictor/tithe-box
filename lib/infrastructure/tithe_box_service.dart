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
  final SettingsService _settingsService;
  late String token;
  late String userId;
  late UserProfileFile _userProfileFile;
  late List<IncomeFileModel> _incomeFile = <IncomeFileModel>[];
  late List<ChurchFileModel> _churchFile = <ChurchFileModel>[];

  TitheBoxServiceImpl(this._authService, this._incomeService, this._churchService, this._settingsService);

  @override
  Future<void> init() async {
    await Future.wait([
      initProfile(),
      getIncomeData(),
      getChurchData(),
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
  IncomeFileModel getIncome(String id) {
    return _incomeFile.firstWhere((el) => el.incomeId == id);
  }

  @override
  IncomeCardModel getIncomeForCard(String id) {
    final income = _incomeFile.firstWhere((el) => el.incomeId == id);
    return _toIncomeForCard(income);
  }

  @override
  List<IncomeCardModel> getIncomesForCard() {
    return _incomeFile.map((e) => _toIncomeForCard(e)).toList();
  }

  @override
  double totalIncome() {
    final List<double> amounts = _incomeFile.map((e) => e.amount).toList();
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

  IncomeCardModel _toIncomeForCard(IncomeFileModel model) {
    return IncomeCardModel(
      id: model.incomeId,
      type: model.type,
      businessName: model.businessName,
      businessAddress: model.businessAddress,
      amount: model.amount,
      description: model.description,
      frequency: model.frequency,
      createdAt: model.createdAt,
    );
  }

  ChurchCardModel _toChurchForCard(ChurchFileModel model) {
    return ChurchCardModel(
      id: model.churchId,
      name: model.name,
      serviceDays: model.serviceDays,
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
      UserAccountType.personal.name,
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
