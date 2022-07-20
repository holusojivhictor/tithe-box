import 'package:flutter/material.dart';
import 'package:tithe_box/theme.dart';

import 'info_banner.dart';

class SliverInfoBanner extends StatelessWidget {
  const SliverInfoBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: Styles.homeContentPadding,
      sliver: SliverToBoxAdapter(
        child: InfoBanner(),
      ),
    );
  }
}
