import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/presentation/shared/auth_app_bar.dart';
import 'package:tithe_box/presentation/sign_up/widgets/sign_up_form.dart';
import 'package:tithe_box/theme.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AuthAppBar(
        title: "Sign Up",
        onTap: () => context.read<SessionBloc>().add(const SessionEvent.startAuthState()),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: Styles.edgeInsetAll10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    Text(
                      'Sign Up',
                      style: theme.textTheme.displayMedium!.copyWith(fontSize: 20, color: theme.primaryColor),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Fill in your details to create a free account",
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 90,
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      SignUpForm(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
