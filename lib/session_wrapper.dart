import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/application/result/result_state.dart';
import 'package:tithe_box/presentation/create_profile/create_profile_page.dart';
import 'package:tithe_box/presentation/sign_in/sign_in_page.dart';
import 'package:tithe_box/presentation/sign_up/sign_up_page.dart';
import 'package:tithe_box/theme.dart';

import 'presentation/account_selection/account_selection_page.dart';
import 'presentation/animated_splash/animated_splash.dart';
import 'presentation/auth/auth_screen.dart';
import 'presentation/onboarding/onboarding_page.dart';

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
        unInitialized: (_) => materialApp(const AnimatedSplash()),
        unAuthenticated: (_) => materialApp(const OnboardingPage()),
        accountTypeSelection: (_) => materialApp(const AccountSelectionPage()),
        authSession: (_) => materialApp(const AuthScreen()),
        signUpState: (_) => materialApp(const SignUpPage()),
        userProfileState: (s) {
          return BlocBuilder<UserProfileBloc, ResultState>(
            builder: (ctx, state) => materialApp(CreateProfilePage(email: s.email, phoneNumber: s.phoneNumber, password: s.password, confirmPassword: s.confirmPassword)),
          );
        },
        signInState: (_) => materialApp(const SignInPage()),
        authenticated: (_) => Container(),
      ),
    );
  }
}
