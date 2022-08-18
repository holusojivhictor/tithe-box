import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/income_record/widgets/sliver_income_choice_bar.dart';
import 'package:tithe_box/presentation/pay_tithe/widgets/income_card.dart';
import 'package:tithe_box/presentation/shared/loading.dart';
import 'package:tithe_box/presentation/shared/sliver_nothing_found.dart';
import 'package:tithe_box/presentation/shared/sliver_page_header.dart';
import 'package:tithe_box/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:tithe_box/presentation/shared/utils/size_utils.dart';
import 'package:tithe_box/presentation/shared/utils/toast_utils.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class PayTithePage extends StatelessWidget {
  const PayTithePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IncomesBloc, IncomesState>(
      listener: (ctx, state) => state.maybeMap(
        loaded: (s) {
          if (s.isRefreshing) {
            _showRefreshToast(context);
          }
          return null;
        },
        orElse: () => {},
      ),
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          appbar: const _AppBar(),
          slivers: [
            const SliverPageHeader(subHeader: "Select an income to pay tithe on and proceed to payment.", hasSpace: false),
            const SliverIncomeChoiceBar(),
            if (state.incomes.isNotEmpty) _buildList(context, state.incomes) else const SliverNothingFound(),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<IncomeCardModel> incomes) {
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context, forPortrait: 1, forLandscape: 1),
        crossAxisSpacing: 5,
        mainAxisSpacing: 7,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) => IncomeCard.card(income: incomes[index]),
        childCount: incomes.length,
      ),
    );
  }

  void _showRefreshToast(BuildContext context) {
    final fToast = ToastUtils.of(context);
    ToastUtils.showInfoToast(fToast, 'Refreshing');
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
      centerTitle: true,
      title: Text(
        "Pay Tithe",
        style: theme.textTheme.displayMedium!.copyWith(fontSize: 20, color: theme.primaryColor),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
