import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/presentation/home/widgets/forms/slider_form.dart';
import 'package:tithe_box/presentation/shared/sliver_loading.dart';

import '../slider_bar.dart';

class SliverSliderForm extends StatelessWidget {
  const SliverSliderForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const SliverLoading(),
        loaded: (state) => SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                SliderBar(
                  sliderValue: state.tithePercentage,
                ),
                const SliderForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
