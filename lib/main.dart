import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/services/services.dart';
import 'package:tithe_box/firebase_options.dart';
import 'package:tithe_box/presentation/app_widget.dart';
import 'package:tithe_box/session_wrapper.dart';

import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Injection.init();
  runApp(const TitheBox());
}

class TitheBox extends StatelessWidget {
  const TitheBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) {
            final titheBoxService = getIt<TitheBoxService>();
            final settingsService = getIt<SettingsService>();
            final loggingService = getIt<LoggingService>();
            return SessionBloc(titheBoxService, settingsService, loggingService)..add(const SessionEvent.appStarted(init: true));
          },
        ),
        BlocProvider(
          create: (ctx) {
            final authService = getIt<AuthService>();
            return SignInBloc(authService, ctx.read<SessionBloc>());
          },
        ),
        BlocProvider(
          create: (ctx) {
            return SignUpBloc(ctx.read<SessionBloc>());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final authService = getIt<AuthService>();
            return UserProfileBloc(authService, ctx.read<SessionBloc>());
          },
        ),
        BlocProvider(create: (ctx) => MainTabBloc()),
        BlocProvider(
          create: (ctx) {
            final titheBoxService = getIt<TitheBoxService>();
            return HomeBloc(titheBoxService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final loggingService = getIt<LoggingService>();
            final settingsService = getIt<SettingsService>();
            final deviceInfoService = getIt<DeviceInfoService>();
            return MainBloc(
              loggingService,
              settingsService,
              deviceInfoService,
            )..add(const MainEvent.init());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final settingsService = getIt<SettingsService>();
            final deviceInfoService = getIt<DeviceInfoService>();
            return SettingsBloc(settingsService, deviceInfoService, ctx.read<MainBloc>());
          },
        ),
      ],
      child: BlocBuilder<MainBloc, MainState>(
        builder: (ctx, state) => const AppWidget(),
      ),
    );
  }
}

