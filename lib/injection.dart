import 'package:get_it/get_it.dart';
import 'package:tithe_box/application/bloc.dart';
import 'domain/services/services.dart';
import 'infrastructure/infrastructure.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  static SignInBloc getSignInBloc(SessionBloc bloc) {
    final authService = getIt<AuthService>();
    final titheBoxService = getIt<TitheBoxService>();
    final logger = getIt<LoggingService>();
    return SignInBloc(authService, titheBoxService, logger, bloc);
  }

  static UserProfileBloc getUserProfileBloc(SessionBloc bloc) {
    final authService = getIt<AuthService>();
    final titheBoxService = getIt<TitheBoxService>();
    final logger = getIt<LoggingService>();
    return UserProfileBloc(authService, titheBoxService, logger, bloc);
  }

  static Future<void> init() async {
    final deviceInfoService = DeviceInfoServiceImpl();
    getIt.registerSingleton<DeviceInfoService>(deviceInfoService);
    await deviceInfoService.init();

    final loggingService = LoggingServiceImpl();
    getIt.registerSingleton<LoggingService>(loggingService);

    final authService = AuthServiceImpl();
    getIt.registerSingleton<AuthService>(authService);

    final incomeService = IncomeServiceImpl();
    getIt.registerSingleton<IncomeService>(incomeService);

    final churchService = ChurchServiceImpl();
    getIt.registerSingleton<ChurchService>(churchService);

    final paymentService = PaymentServiceImpl();
    getIt.registerSingleton<PaymentService>(paymentService);

    final settingsService = SettingsServiceImpl(loggingService);
    await settingsService.init();
    getIt.registerSingleton<SettingsService>(settingsService);

    getIt.registerSingleton<TitheBoxService>(TitheBoxServiceImpl(
      authService,
      incomeService,
      churchService,
      paymentService,
      settingsService,
    ));
  }
}
