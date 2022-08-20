import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/domain/enums/enums.dart';
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
              const SizedBox(height: 20),
              Text(
                'Choose Tithe Type',
                style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).indicatorColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Select an account type to access.",
                  style: textTheme.bodyMedium!.copyWith(color: customTheme.altTextColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              DefaultButton(
                isPrimary: true,
                text: 'Personal Tithe',
                elevation: 0,
                backgroundColor: kPrimary,
                onPressed: () => _startAuthState(context, AppAccentColorType.orange, UserAccountType.personal),
              ),
              const SizedBox(height: 10),
              DefaultButton(
                text: 'Corporate Tithe',
                isPrimary: true,
                elevation: 0,
                backgroundColor: kSecondary,
                onPressed: () => _startAuthState(context, AppAccentColorType.grey, UserAccountType.corporate),
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

  void _startAuthState(BuildContext context, AppAccentColorType accentColor, UserAccountType accountType) {
    final settingsBloc = context.read<SettingsBloc>();
    settingsBloc.add(SettingsEvent.accentColorChanged(newValue: accentColor));
    settingsBloc.add(SettingsEvent.userAccountTypeChanged(newValue: accountType));
    context.read<SessionBloc>().add(const SessionEvent.startAuthState());
  }
}
