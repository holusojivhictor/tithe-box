import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/presentation/create_profile/create_profile_page.dart';
import 'package:tithe_box/presentation/main_tab_page.dart';
import 'package:tithe_box/presentation/sign_in/sign_in_page.dart';
import 'package:tithe_box/presentation/sign_up/sign_up_page.dart';
import 'package:tithe_box/presentation/verify/verify_page.dart';

import 'presentation/account_selection/account_selection_page.dart';
import 'presentation/animated_splash/animated_splash.dart';
import 'presentation/auth/auth_screen.dart';
import 'presentation/onboarding/onboarding_page.dart';

class SessionWrapper extends StatelessWidget {
  const SessionWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) => state.map(
        unInitialized: (_) => const AnimatedSplash(),
        unAuthenticated: (_) => const OnboardingPage(),
        accountTypeSelection: (s) => AccountSelectionPage(isInitialize: s.isInitialize),
        authSession: (_) => const AuthScreen(),
        signUpState: (_) => const SignUpPage(),
        userProfileState: (s) => CreateProfilePage(email: s.email, phoneNumber: s.phoneNumber, password: s.password, confirmPassword: s.confirmPassword),
        signInState: (s) => const SignInPage(),
        authenticated: (_) => const MainTabPage(),
        verifyState: (_) => const VerifyPage(),
      ),
    );
  }
}
