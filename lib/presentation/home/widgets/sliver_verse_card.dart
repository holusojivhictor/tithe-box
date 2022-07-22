import 'package:flutter/material.dart';
import 'package:tithe_box/theme.dart';

import 'verse_card.dart';

class SliverVerseCard extends StatelessWidget {
  const SliverVerseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: Styles.edgeInsetAll10,
      sliver: SliverToBoxAdapter(
        child: VerseCard(
          bibleVerse: kVerse,
        ),
      ),
    );
  }
}

const kVerse = "PROV. 3:9–10 \nHonor the Lord with your wealth and with the firstfruits of all your produce; then your barns will be filled with plenty, and your vats will be bursting with wine.";
