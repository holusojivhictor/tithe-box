import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/domain/services/services.dart';

final Dio dio = Dio();

class AuthServiceImpl implements AuthService {
  final FirebaseService _firebaseService;
  final _firebaseAuth = FirebaseAuth.instance;

  AuthServiceImpl(this._firebaseService);

  @override
  Future<ApiResult<Response>> registerAccount(
    String firstName,
    String lastName,
    String email,
    String occupation,
    String city,
    String churchName,
    String country,
    String phoneNumber,
    List<String> serviceDays,
    String password,
    String passwordConfirmation,
  ) async {
    String url = "$baseUrl/signUp";
    Map<String, dynamic> body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "occupation": occupation,
      "city": city,
      "church": churchName,
      "password": password,
      "confirmPassword": passwordConfirmation,
      "phoneNumber": phoneNumber,
      "serviceDays": serviceDays,
      "country": country
    };

    try {
      final Response response = await dio.post(url, data: body);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<Response>> login(String email, String password) async {
    String url = "$baseUrl/signIn";
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };

    try {
      final Response response = await dio.post(url, data: body);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<Response> getProfile(String userId, String token) async {
    String url = "$baseUrl/$userId";

    final Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));
    return response;
  }

  @override
  Future<ApiResult<String>> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return const ApiResult.success(data: "Sign up successful");
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<String>> createUserProfile(
      String fullName,
      String email,
      String occupation,
      String churchName,
      String city,
      String country,
      ) async {
    final email = _firebaseAuth.currentUser!.email;
    final uid = _firebaseAuth.currentUser!.uid;
    final user = UserModel(uid: uid, fullName: fullName, emailAddress: email!, occupation: occupation, churchName: churchName, city: city, country: country);
    try {
      await _firebaseService.saveUserCredentials(user);
      return const ApiResult.success(data: "User profile created successfully");
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<String>> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return const ApiResult.success(data: "Sign in successful");
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ApiResult<String>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      return const ApiResult.success(data: "Sign in with Google successful");
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
