import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/add_church/add_church_page.dart';

import 'card_item.dart';

class AddChurchCard extends StatelessWidget {
  const AddChurchCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItem(
      title: 'Add Church',
      subtitle: "Add your church details to be able to pay tithes.",
      image: 'payment-history.jpg',
      onClick: _goToPaymentHistoryPage,
    );
  }

  Future<void> _goToPaymentHistoryPage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => const AddChurchPage());
    await Navigator.push(context, route);
    await route.completed;
  }
}
