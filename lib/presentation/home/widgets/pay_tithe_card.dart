import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/pay_tithe/pay_tithe_page.dart';

import 'card_item.dart';

class ChurchesCard extends StatelessWidget {
  const ChurchesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItem(
      title: 'Pay Tithe Now',
      subtitle: "Start the tithe payment flow.",
      image: 'church.jpg',
      onClick: _goToChurchesPage,
    );
  }

  Future<void> _goToChurchesPage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => const PayTithePage());
    await Navigator.push(context, route);
    await route.completed;
  }
}
