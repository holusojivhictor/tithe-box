import 'package:get_it/get_it.dart';
import 'domain/services/services.dart';
import 'infrastructure/infrastructure.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  static Future<void> init() async {
    final firebaseService = FirebaseServiceImpl();
    getIt.registerSingleton<FirebaseService>(firebaseService);

    final authService = AuthServiceImpl(firebaseService);
    getIt.registerSingleton<AuthService>(authService);
  }
}