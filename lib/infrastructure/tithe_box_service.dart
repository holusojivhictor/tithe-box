import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/domain/services/services.dart';

class TitheBoxServiceImpl implements TitheBoxService {
  final AuthService _authService;
  final IncomeService _incomeService;
  final SettingsService _settingsService;
  late String token;
  late String userId;
  late UserProfileFile _userProfileFile;
  final List<IncomeFileModel> _incomeFile = <IncomeFileModel>[];

  TitheBoxServiceImpl(this._authService, this._incomeService, this._settingsService);

  @override
  Future<void> init() async {
    await Future.wait([
      initProfile(),
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
    _incomeFile.addAll(list as List<IncomeFileModel>);
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
    final userIncomeFile = _incomeFile.where((el) => el.userId == userId);
    return userIncomeFile.map((e) => _toIncomeForCard(e)).toList();
  }

  IncomeCardModel _toIncomeForCard(IncomeFileModel model) {
    return IncomeCardModel(
      id: model.incomeId,
      type: model.type,
      businessName: model.businessName,
      amount: model.amount,
      frequency: model.frequency,
      createdAt: model.createdAt,
    );
  }

  @override
  UserProfileModel getProfile() {
    return _userProfileFile.user;
  }

  @override
  Future<Response> recordIncome(String businessName, String incomeAmount, String description, String frequency) async {
    final settings = _settingsService.appSettings;

    final response = _incomeService.recordIncome(
      token,
      userId,
      UserAccountType.personal.name,
      businessName,
      incomeAmount,
      description,
      settings.tithePercentage.toString(),
      frequency,
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