import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/theme.dart';

class SessionWrapper extends StatelessWidget {
  const SessionWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp(Widget? home) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: TitheBoxTheme.light(),
        darkTheme: TitheBoxTheme.light(),
        home: home,
      );
    }
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) => state.map(
        unInitialized: (_) => materialApp(Container()),
        unAuthenticated: (_) => materialApp(Container()),
        signUpState: (_) => materialApp(Container()),
        signInState: (_) => materialApp(Container()),
        authenticated: (_) => Container(),
      ),
    );
  }
}
