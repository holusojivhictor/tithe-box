import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/presentation/shared/extensions/app_accent_color_type_extensions.dart';
import 'package:tithe_box/session_wrapper.dart';

import 'shared/loading.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (ctx, state) => state.map<Widget>(
        loading: (_) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppAccentColorType.orange.getLightTheme(),
            home: const Loading(),
          );
        },
        loaded: (s) {
          final autoThemeModeOn = s.autoThemeMode == AutoThemeModeType.on;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: s.appTitle,
            theme: autoThemeModeOn ? s.accentColor.getLightTheme() : s.accentColor.getThemeData(s.theme),
            darkTheme: autoThemeModeOn ? s.accentColor.getDarkTheme() : null,
            home: BlocBuilder<SessionBloc, SessionState>(
              builder: (ctx, state) => const SessionWrapper(),
            ),
          );
        },
      ),
    );
  }
}
