import 'package:flutter/material.dart';
import 'package:tithe_box/theme.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../calculate_tithe_card.dart';
import '../churches_card.dart';
import '../income_record_card.dart';
import '../payment_history_card.dart';

class SliverCardsMenu extends StatelessWidget {
  const SliverCardsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: Styles.edgeInsetAll10,
      sliver: SliverWaterfallFlow(
        delegate: SliverChildBuilderDelegate((context, index) => _buildCardsSection(index), childCount: 4),
        gridDelegate: const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }

  Widget _buildCardsSection(int index) {
    switch (index) {
      case 0:
        return const CalculateTitheCard();
      case 1:
        return const IncomeRecordCard();
      case 2:
        return const PaymentHistoryCard();
      case 3:
        return const ChurchesCard();
      default:
        throw Exception('Invalid card item');
    }
  }
}
