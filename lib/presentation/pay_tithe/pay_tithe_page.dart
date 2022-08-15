import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/shared/sliver_page_header.dart';
import 'package:tithe_box/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:tithe_box/theme.dart';

class PayTithePage extends StatelessWidget {
  const PayTithePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverScaffoldWithFab(
      appbar: _AppBar(),
      slivers: [
        SliverPageHeader(subHeader: "Select an income to pay tithe on and proceed to payment.", hasSpace: false),
      ],
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget{
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: theme.indicatorColor),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        "Pay Tithe",
        style: theme.textTheme.displayMedium!.copyWith(fontSize: 20, color: kPrimary),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
