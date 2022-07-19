import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/create_profile/widgets/profile_form.dart';
import 'package:tithe_box/presentation/shared/auth_app_bar.dart';
import 'package:tithe_box/theme.dart';

class CreateProfilePage extends StatelessWidget {
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  const CreateProfilePage({
    Key? key,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
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
    );
  }
}