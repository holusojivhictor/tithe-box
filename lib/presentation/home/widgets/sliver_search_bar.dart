import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/shared/search_field.dart';
import 'package:tithe_box/theme.dart';

class SliverSearchBar extends StatelessWidget {
  const SliverSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: Styles.homeContentPadding,
      sliver: SliverToBoxAdapter(
        child: SearchField(
          value: '',
          hintText: 'Search for churches near you',
          searchChanged: (v) {},
        ),
      ),
    );
  }
}
