import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/application/result/result_state.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/create_profile/widgets/profile_form.dart';
import 'package:tithe_box/presentation/shared/auth_app_bar.dart';
import 'package:tithe_box/presentation/shared/custom_alert_dialog.dart';
import 'package:tithe_box/theme.dart';

class CreateProfilePage extends StatelessWidget {
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final bool hasDialog;

  const CreateProfilePage({
    Key? key,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.hasDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final dialog = Container(
      color: Colors.black54,
      child: BlocBuilder<UserProfileBloc, ResultState>(
        builder: (ctx, state) => state.when(
          idle: () => const CustomAlertDialog(text: 'Idling...'),
          loading: () => const CustomAlertDialog(text: 'Creating account...'),
          data: (_) {
            return const CustomAlertDialog(text: 'Initializing data...');
          },
          error: (e) => CustomAlertDialog(title: Text('Account creation failed', style: Theme.of(context).textTheme.titleMedium), text: NetworkExceptions.getErrorMessage(e), isError: true),
        ),
      ),
    );

    return Stack(
      children: [
        Scaffold(
          appBar: const AuthAppBar(
            title: 'Create Profile',
            hasLeading: false,
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
                          'Complete Profile',
                          style: textTheme.displayMedium!.copyWith(fontSize: 20, color: kPrimary),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Fill in these details to finish creating your account",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 90,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProfileForm(
                            email: email,
                            phoneNumber: phoneNumber,
                            password: password,
                            confirmPassword: confirmPassword,
                          ),
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