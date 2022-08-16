import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/payments/widgets/transaction_card.dart';
import 'package:tithe_box/presentation/shared/loading.dart';
import 'package:tithe_box/presentation/shared/sliver_nothing_found.dart';
import 'package:tithe_box/presentation/shared/sliver_page_header.dart';
import 'package:tithe_box/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:tithe_box/presentation/shared/utils/size_utils.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          slivers: [
            const SliverPageHeader(header: 'Payments', subHeader: 'View the status of all transactions performed.', hasSpace: true),
            if (state.transactions.isNotEmpty) _buildList(context, state.transactions) else const SliverNothingFound(),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<TransactionCardModel> transactions) {
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context, forPortrait: 1, forLandscape: 1),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) => TransactionCard.item(transaction: transactions[index]),
        childCount: transactions.length,
      ),
    );
  }
}
