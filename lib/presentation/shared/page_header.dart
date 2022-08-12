import 'package:flutter/material.dart';
import 'package:tithe_box/theme.dart';

class PageHeader extends StatelessWidget {
  final String header;
  final String subHeader;
  final bool hasSpace;

  const PageHeader({
    Key? key,
    required this.header,
    required this.subHeader,
    required this.hasSpace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: hasSpace ? 10 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            header,
            style: textTheme.displayMedium!.copyWith(fontSize: 20, color: kPrimary),
          ),
          const SizedBox(height: 10),
          Text(subHeader),
        ],
      ),
    );
  }
}
