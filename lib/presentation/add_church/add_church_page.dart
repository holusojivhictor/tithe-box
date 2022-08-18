import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/shared/sliver_page_header.dart';
import 'package:tithe_box/presentation/shared/sliver_scaffold_with_fab.dart';

import 'widgets/add_church_form.dart';

class AddChurchPage extends StatelessWidget {
  const AddChurchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverScaffoldWithFab(
      appbar: _AppBar(),
      slivers: [
        SliverPageHeader(subHeader: "Fill these in to keep record of your church's details", hasSpace: false),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          sliver: SliverToBoxAdapter(
            child: AddChurchForm(),
          ),
        ),
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
        "Church Information",
        style: theme.textTheme.displayMedium!.copyWith(fontSize: 20, color: theme.primaryColor),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
