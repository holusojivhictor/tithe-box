import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/presentation/shared/choice/choice_bar_wout_icon.dart';
import 'package:tithe_box/presentation/shared/sliver_loading.dart';

class SliverChoiceBar extends StatelessWidget {
  const SliverChoiceBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const SliverLoading(),
        loaded: (state) => SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          sliver: SliverToBoxAdapter(
            child: ChoiceBarWithoutIcon<int>(
              values: HomeContentType.values.map((e) => e.index).toList(),
              selectedValue: state.contentType.index,
              onSelected: (v) {
                context.read<HomeBloc>().add(HomeEvent.homeContentTypeChanged(HomeContentType.values[v]));
                context.read<HomeBloc>().add(const HomeEvent.applyFilterChanges());
              },
              choiceText: (val, _) => Assets.translateHomeContentType(HomeContentType.values[val]),
            ),
          ),
        ),
      ),
    );
  }
}
