import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/services/services.dart';
import 'package:tithe_box/firebase_options.dart';
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
            final authService = getIt<AuthService>();
            return SessionBloc(authService)..add(const SessionEvent.appStarted(init: true));
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
            final authService = getIt<AuthService>();
            return SignUpBloc(authService, ctx.read<SessionBloc>());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final authService = getIt<AuthService>();
            return UserProfileBloc(authService, ctx.read<SessionBloc>());
          },
        ),
      ],
      child: BlocBuilder<SessionBloc, SessionState>(
        builder: (ctx, state) => const SessionWrapper(),
      ),
    );
  }
}

