import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/income_record/income_record_page.dart';

import 'card_item.dart';

class IncomeRecordCard extends StatelessWidget {
  const IncomeRecordCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItem(
      title: 'Income Record',
      subtitle: "Record your incomes to pay tithe.",
      image: 'income-record.jpg',
      onClick: _goToIncomeRecordPage,
    );
  }

  Future<void> _goToIncomeRecordPage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => const IncomeRecordPage(hasAppBar: true));
    await Navigator.push(context, route);
    await route.completed;
  }
}
