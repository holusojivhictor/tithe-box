import 'package:flutter/material.dart';
import 'package:tithe_box/theme.dart';

import '../verse_card.dart';

class SliverVerseCard extends StatelessWidget {
  const SliverVerseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: Styles.edgeInsetAll10,
      sliver: SliverToBoxAdapter(
        child: VerseCard(),
      ),
    );
  }
}
