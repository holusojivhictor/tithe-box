import 'package:get_it/get_it.dart';
import 'domain/services/services.dart';
import 'infrastructure/infrastructure.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  static Future<void> init() async {
    final deviceInfoService = DeviceInfoServiceImpl();
    getIt.registerSingleton<DeviceInfoService>(deviceInfoService);
    await deviceInfoService.init();

    final loggingService = LoggingServiceImpl();
    getIt.registerSingleton<LoggingService>(loggingService);

    final firebaseService = FirebaseServiceImpl();
    getIt.registerSingleton<FirebaseService>(firebaseService);

    final authService = AuthServiceImpl(firebaseService);
    getIt.registerSingleton<AuthService>(authService);

    final settingsService = SettingsServiceImpl(loggingService);
    await settingsService.init();
    getIt.registerSingleton<SettingsService>(settingsService);
    
    getIt.registerSingleton<TitheBoxService>(TitheBoxServiceImpl(authService));
  }
}