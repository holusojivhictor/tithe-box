import 'package:flutter/material.dart';
import 'package:tithe_box/theme.dart';

class SliverPageHeader extends StatelessWidget {
  final String header;
  final String subHeader;
  final bool hasSpace;

  const SliverPageHeader({
    Key? key,
    required this.header,
    required this.subHeader,
    this.hasSpace = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: hasSpace ? 10 : 0),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Text(
              header,
              style: textTheme.displayMedium!.copyWith(fontSize: 20, color: kPrimary),
            ),
            const SizedBox(height: 10),
            Text(subHeader),
          ],
        ),
      ),
    );
  }
}
