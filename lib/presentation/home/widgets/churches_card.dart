import 'package:flutter/material.dart';

import 'card_item.dart';

class ChurchesCard extends StatelessWidget {
  const ChurchesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItem(
      title: 'Churches',
      subtitle: "Search for churches around.",
      image: 'church.jpg',
      onClick: _goToChurchesPage,
    );
  }

  Future<void> _goToChurchesPage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => Container());
    await Navigator.push(context, route);
    await route.completed;
  }
}
