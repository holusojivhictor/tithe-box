import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/create_profile/widgets/profile_form.dart';
import 'package:tithe_box/presentation/shared/auth_app_bar.dart';
import 'package:tithe_box/theme.dart';

class CreateProfilePage extends StatelessWidget {
  const CreateProfilePage({Key? key}) : super(key: key);

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
                      "Fill in these details to load up your personal profile",
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 90,
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      ProfileForm(),
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
