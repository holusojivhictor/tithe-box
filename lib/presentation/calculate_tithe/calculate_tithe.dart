import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/extensions/double_extensions.dart';
import 'package:tithe_box/presentation/home/widgets/info_banner.dart';
import 'package:tithe_box/presentation/shared/sliver_page_header.dart';
import 'package:tithe_box/presentation/shared/loading.dart';
import 'package:tithe_box/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:tithe_box/theme.dart';

import 'widgets/calculate_tithe_form.dart';

class CalculateTithePage extends StatelessWidget {
  const CalculateTithePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomesBloc, IncomesState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          appbar: const _AppBar(),
          slivers: [
            const SliverPageHeader(subHeader: 'Input the needed details to calculate your tithe.'),
            SliverPadding(
              padding: const EdgeInsets.only(top: 25, bottom: 10),
              sliver: SliverToBoxAdapter(
                child: InfoBanner(
                  header: 'Total Income\n\n',
                  info: 'N${state.totalIncome.parseToString()}',
                ),
              ),
            ),
            SliverPadding(
              padding: Styles.edgeInsetAll10,
              sliver: SliverToBoxAdapter(
                child: CalculateTitheForm(
                  totalIncome: state.totalIncome,
                ),
              ),
            ),
          ],
        ),
      ),
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
        "Calculate Tithe",
        style: theme.textTheme.displayMedium!.copyWith(fontSize: 20, color: theme.primaryColor),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
