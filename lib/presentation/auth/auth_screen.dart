import 'package:flutter/material.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/presentation/shared/default_button.dart';
import 'package:tithe_box/presentation/shared/start/bottom_portrait_layout.dart';
import 'package:tithe_box/presentation/shared/start/top_portrait_layout.dart';
import 'package:tithe_box/presentation/shared/svg_image.dart';
import 'package:tithe_box/theme.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          TopPortraitLayout(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: IconThemeData(color: theme.indicatorColor),
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
              Text(
                'Tithing has never been this easy',
                style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  defaultText,
                  style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              DefaultButton(
                isPrimary: true,
                text: 'Log In',
                elevation: 0,
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              DefaultButton(
                text: 'Create Account',
                hasBorder: true,
                elevation: 0,
                backgroundColor: kWhite,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
