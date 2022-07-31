import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/calculate_tithe/calculate_tithe.dart';

import 'card_item.dart';

class CalculateTitheCard extends StatelessWidget {
  const CalculateTitheCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItem(
      title: 'Calculate Tithe',
      subtitle: "Let’s find out what your tithe is gonna be.",
      image: 'calculate-tithe.jpg',
      onClick: _goToCalculateTithePage,
    );
  }

  Future<void> _goToCalculateTithePage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => const CalculateTithePage());
    await Navigator.push(context, route);
    await route.completed;
  }
}
