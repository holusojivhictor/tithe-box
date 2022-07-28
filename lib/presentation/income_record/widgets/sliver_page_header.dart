import 'package:flutter/material.dart';
import 'package:tithe_box/theme.dart';

class SliverPageHeader extends StatelessWidget {
  const SliverPageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Text(
              'Income Record',
              style: textTheme.displayMedium!.copyWith(fontSize: 20, color: kPrimary),
            ),
            const SizedBox(height: 10),
            const Text(
              "Input the needed details and calculate your tithe seamlessly.",
            ),
          ],
        ),
      ),
    );
  }
}
