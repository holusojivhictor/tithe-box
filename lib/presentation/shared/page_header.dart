import 'package:flutter/material.dart';
import 'package:tithe_box/theme.dart';

class PageHeader extends StatelessWidget {
  final String header;
  final String subHeader;
  final bool hasSpace;

  const PageHeader({
    Key? key,
    this.header = '',
    required this.subHeader,
    required this.hasSpace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: hasSpace ? 10 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          hasSpace ? Text(
            header,
            style: theme.textTheme.displayMedium!.copyWith(fontSize: 20, color: theme.primaryColor),
          ) : const SizedBox.shrink(),
          SizedBox(height: hasSpace ? 10 : 0),
          Text(subHeader, style: TextStyle(color: customTheme.baseTextColor)),
        ],
      ),
    );
  }
}
