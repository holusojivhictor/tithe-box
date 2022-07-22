import 'package:flutter/material.dart';

import 'card_item.dart';

class PaymentHistoryCard extends StatelessWidget {
  const PaymentHistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItem(
      title: 'Payment History',
      subtitle: "Check out your transaction history.",
      image: 'payment-history.jpg',
      onClick: _goToPaymentHistoryPage,
    );
  }

  Future<void> _goToPaymentHistoryPage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => Container());
    await Navigator.push(context, route);
    await route.completed;
  }
}
