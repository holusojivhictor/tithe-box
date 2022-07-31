import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/presentation/shared/custom_alert_dialog.dart';
import 'package:tithe_box/presentation/shared/default_button.dart';
import 'package:tithe_box/presentation/shared/start/bottom_portrait_layout.dart';
import 'package:tithe_box/presentation/shared/start/top_portrait_layout.dart';
import 'package:tithe_box/presentation/shared/svg_image.dart';
import 'package:tithe_box/theme.dart';

class AccountSelectionPage extends StatelessWidget {
  final bool isInitialize;
  const AccountSelectionPage({Key? key, required this.isInitialize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          TopPortraitLayout(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: SvgImage(
                  image: Assets.getSvgPath('character-writing.svg'),
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
                'Choose Tithe Type',
                style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).indicatorColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Select a personal or a corporate account type according to which best describes your use of the app.",
                  style: textTheme.bodyMedium!.copyWith(color: customTheme.altTextColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              DefaultButton(
                isPrimary: true,
                text: 'Personal Tithe',
                elevation: 0,
                onPressed: () {
                  context.read<SessionBloc>().add(const SessionEvent.startAuthState());
                },
              ),
              const SizedBox(height: 10),
              DefaultButton(
                text: 'Corporate Tithe',
                isPrimary: true,
                elevation: 0,
                backgroundColor: kSecondary,
                onPressed: null,
              ),
            ],
          ),
          if (isInitialize)
            Container(
              color: Colors.black54,
              child: const CustomAlertDialog(text: 'Initializing data...'),
            ),
        ],
      ),
    );
  }
}
