import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/presentation/shared/auth_app_bar.dart';
import 'package:tithe_box/presentation/sign_in/widgets/sign_in_form.dart';
import 'package:tithe_box/theme.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AuthAppBar(
        title: "Sign In",
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
                      'Log In',
                      style: theme.textTheme.displayMedium!.copyWith(fontSize: 20, color: theme.primaryColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Fill in your details to log into your account",
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 90,
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      SignInForm(),
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
