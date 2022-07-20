import 'package:shared_preferences/shared_preferences.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/domain/services/services.dart';

class TitheBoxServiceImpl implements TitheBoxService {
  final AuthService _authService;
  late String token;
  late String userId;
  late UserProfileFile _userProfileFile;

  TitheBoxServiceImpl(this._authService);

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
  UserProfileModel getProfile() {
    return _userProfileFile.user;
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