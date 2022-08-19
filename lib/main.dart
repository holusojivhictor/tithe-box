import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/services/services.dart';
import 'package:tithe_box/presentation/app_widget.dart';

import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
            return SignUpBloc(ctx.read<SessionBloc>());
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
            final titheBoxService = getIt<TitheBoxService>();
            return TransactionsBloc(titheBoxService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final titheBoxService = getIt<TitheBoxService>();
            final settingsService = getIt<SettingsService>();
            return IncomesBloc(titheBoxService, settingsService, ctx.read<TransactionsBloc>());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final titheBoxService = getIt<TitheBoxService>();
            return ChurchesBloc(titheBoxService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final titheBoxService = getIt<TitheBoxService>();
            return DataBloc(
              titheBoxService,
              ctx.read<IncomesBloc>(),
              ctx.read<ChurchesBloc>(),
              ctx.read<TransactionsBloc>(),
            );
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
            return SettingsBloc(settingsService, deviceInfoService, ctx.read<MainBloc>())..add(const SettingsEvent.init());
          },
        ),
      ],
      child: BlocBuilder<MainBloc, MainState>(
        builder: (ctx, state) => const AppWidget(),
      ),
    );
  }
}

