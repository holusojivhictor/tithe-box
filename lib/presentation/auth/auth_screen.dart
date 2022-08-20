import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/presentation/shared/auth_app_bar.dart';
import 'package:tithe_box/presentation/shared/default_button.dart';
import 'package:tithe_box/presentation/shared/start/bottom_portrait_layout.dart';
import 'package:tithe_box/presentation/shared/start/top_portrait_layout.dart';
import 'package:tithe_box/presentation/shared/svg_image.dart';
import 'package:tithe_box/theme.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          TopPortraitLayout(
            appBar: AuthAppBar(
              onTap: () => context.read<SessionBloc>().add(const SessionEvent.selectAccountType()),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: SvgImage(
                  image: Assets.getSvgPath('calendar.svg'),
                  label: 'Character writing',
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ],
          ),
          BottomPortraitLayout(
            children: [
              const SizedBox(height: 20),
              Text(
                'Tithing has never been this easy',
                style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: theme.indicatorColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Create an account or log in to an existing one.",
                  style: theme.textTheme.bodyMedium!.copyWith(color: customTheme.altTextColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              DefaultButton(
                isPrimary: true,
                text: 'Log In',
                elevation: 0,
                onPressed: () {
                  context.read<SessionBloc>().add(const SessionEvent.signInRequested());
                },
              ),
              const SizedBox(height: 10),
              DefaultButton(
                text: 'Create Account',
                hasBorder: true,
                elevation: 0,
                backgroundColor: kWhite,
                onPressed: () {
                  context.read<SessionBloc>().add(const SessionEvent.signUpRequested());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
