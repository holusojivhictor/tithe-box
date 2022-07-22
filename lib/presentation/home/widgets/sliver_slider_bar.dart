import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/presentation/shared/sliver_loading.dart';

import 'slider_bar.dart';

class SliverSliderBar extends StatelessWidget {
  const SliverSliderBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const SliverLoading(),
        loaded: (state) => SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          sliver: SliverToBoxAdapter(
            child: SliderBar(
              sliderValue: state.tithePercentage,
              isActive: false,
            ),
          ),
        ),
      ),
    );
  }
}
