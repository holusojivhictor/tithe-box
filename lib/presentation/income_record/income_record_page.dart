import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/income_record/widgets/sliver_income_choice_bar.dart';
import 'package:tithe_box/presentation/income_record/widgets/income_record_card.dart';
import 'package:tithe_box/presentation/income_record/widgets/sliver_page_header.dart';
import 'package:tithe_box/presentation/shared/sliver_loading.dart';
import 'package:tithe_box/presentation/shared/sliver_nothing_found.dart';
import 'package:tithe_box/presentation/shared/sliver_scaffold_with_fab.dart';

class IncomeRecordPage extends StatelessWidget {
  const IncomeRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverScaffoldWithFab(
      appbar: const _AppBar(),
      slivers: [
        const SliverPageHeader(),
        const SliverIncomeChoiceBar(),
        BlocBuilder<IncomesBloc, IncomesState>(
          builder: (ctx, state) => state.map(
            loading: (_) => const SliverLoading(),
            loaded: (state) {
              if (state.incomes.isNotEmpty) {
                return SliverToBoxAdapter(
                  child: _buildList(context, state.incomes),
                );
              } else {
                return const SliverNothingFound();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context, List<IncomeCardModel> incomes) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: incomes.length,
      itemBuilder: (ctx, index) {
        final e = incomes[index];
        return IncomeRecordCard.item(income: e);
      },
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget{
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: theme.indicatorColor),
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
