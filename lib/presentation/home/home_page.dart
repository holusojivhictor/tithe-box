import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tithe_box/presentation/home/widgets/sliver_cards_menu.dart';
import 'package:tithe_box/presentation/home/widgets/sliver_verse_card.dart';
import 'package:tithe_box/presentation/shared/clickable_title.dart';

import 'widgets/sliver_choice_bar.dart';
import 'widgets/sliver_home_greet.dart';
import 'widgets/sliver_info_banner.dart';
import 'widgets/sliver_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ResponsiveBuilder(
      builder: (ctx, size) => const Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverHomeGreet(),
            SliverSearchBar(),
            SliverInfoBanner(),
            SliverChoiceBar(),
            SliverCardsMenu(),
            SliverClickableTitle(title: 'What the Bible says'),
            SliverVerseCard(),
          ],
        ),
      ),
    );
  }
}
