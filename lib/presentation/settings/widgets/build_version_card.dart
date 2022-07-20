import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/presentation/shared/loading.dart';

import 'card_header_text.dart';
import 'settings_card.dart';
import 'settings_list_tile.dart';

class BuildVersionCard extends StatelessWidget {
  const BuildVersionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CardHeaderText(title: 'BUILD'),
        SettingsCard(
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (ctx, state) => state.map(
              loading: (_) => const Loading(useScaffold: false),
              loaded: (state) => Column(
                children: [
                  SettingsListTile(
                    title: state.appVersion,
                    leadingIcon: Icons.help_outline_outlined,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
