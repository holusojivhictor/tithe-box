import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/presentation/shared/loading.dart';

class SliverHomeGreet extends StatelessWidget {
  const SliverHomeGreet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (ctx, state) => state.map(
            loading: (_) => const Loading(useScaffold: false),
            loaded: (state) {
              final firstName = state.firstName;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Welcome, ',
                      style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: theme.indicatorColor),
                      children: <TextSpan>[
                        TextSpan(text: firstName, style: TextStyle(color: theme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const HomeThemeIcon(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class HomeThemeIcon extends StatelessWidget {
  const HomeThemeIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) {
          final autoThemeMode = state.themeMode;
          final currentTheme = state.currentTheme;

          final child = autoThemeMode == AutoThemeModeType.on
              ? const SizedBox.shrink()
              : InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    context.read<SettingsBloc>().add(SettingsEvent.themeChanged(newValue: currentTheme == AppThemeType.light
                        ? AppThemeType.dark
                        : AppThemeType.light,
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      currentTheme == AppThemeType.light
                          ? Icons.wb_cloudy_outlined
                          : Icons.nights_stay,
                      color: theme.primaryColor,
                    ),
                  ),
                );
          return child;
        },
      ),
    );
  }
}
