import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/presentation/shared/choice/choice_bar_wout_icon.dart';
import 'package:tithe_box/presentation/shared/sliver_loading.dart';

class SliverIncomeChoiceBar extends StatelessWidget {
  const SliverIncomeChoiceBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomesBloc, IncomesState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const SliverLoading(),
        loaded: (state) => SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          sliver: SliverToBoxAdapter(
            child: ChoiceBarWithoutIcon<int>(
              values: SalaryType.values.map((e) => e.index).toList(),
              selectedValue: state.salaryType.index,
              onSelected: (v) {
                context.read<IncomesBloc>().add(IncomesEvent.salaryTypeChanged(SalaryType.values[v]));
                context.read<IncomesBloc>().add(const IncomesEvent.applyFilterChanges());
                context.read<SettingsBloc>().add(SettingsEvent.salaryTypeChanged(newValue: SalaryType.values[v]));
              },
              choiceText: (val, _) => Assets.translateSalaryType(SalaryType.values[val]),
            ),
          ),
        ),
      ),
    );
  }
}
