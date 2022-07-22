import 'package:flutter/material.dart';

import 'card_item.dart';

class IncomeRecordCard extends StatelessWidget {
  const IncomeRecordCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItem(
      title: 'Income Record',
      subtitle: "Hurray! Credit Alert.",
      image: 'income-record.jpg',
      onClick: _goToIncomeRecordPage,
    );
  }

  Future<void> _goToIncomeRecordPage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => Container());
    await Navigator.push(context, route);
    await route.completed;
  }
}
