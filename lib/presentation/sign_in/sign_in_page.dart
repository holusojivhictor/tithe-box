import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/application/result/result_state.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/shared/auth_app_bar.dart';
import 'package:tithe_box/presentation/shared/custom_alert_dialog.dart';
import 'package:tithe_box/presentation/sign_in/widgets/sign_in_form.dart';
import 'package:tithe_box/theme.dart';

class SignInPage extends StatelessWidget {
  final bool hasDialog;
  const SignInPage({Key? key, required this.hasDialog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dialog = Container(
      color: Colors.black54,
      child: BlocBuilder<SignInBloc, ResultState>(
        builder: (ctx, state) => state.when(
          idle: () => const CustomAlertDialog(text: 'Idling...'),
          loading: () => const CustomAlertDialog(text: 'Signing in...'),
          data: (_) {
            return const CustomAlertDialog(text: 'Initializing data...');
          },
          error: (e) => CustomAlertDialog(title: Text('Log in failed', style: Theme.of(context).textTheme.titleMedium), text: NetworkExceptions.getErrorMessage(e), isError: true),
        ),
      ),
    );

    return Stack(
      children: [
        Scaffold(
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
                          style: textTheme.displayMedium!.copyWith(fontSize: 20, color: kPrimary),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Fill in your details to log into your account",
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
        ),
        if (hasDialog)
          dialog
      ],
    );
  }
}
