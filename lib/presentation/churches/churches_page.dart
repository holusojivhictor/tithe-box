import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/churches/widgets/church_card.dart';
import 'package:tithe_box/presentation/shared/loading.dart';
import 'package:tithe_box/presentation/shared/sliver_nothing_found.dart';
import 'package:tithe_box/presentation/shared/sliver_page_header.dart';
import 'package:tithe_box/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:tithe_box/theme.dart';

class ChurchesPage extends StatelessWidget {
  final bool isInSelectionMode;

  static Future<String?> forSelection(BuildContext context) async {
    final bloc = context.read<ChurchesBloc>();
    bloc.add(const ChurchesEvent.init());

    final route = MaterialPageRoute<String>(builder: (ctx) => const ChurchesPage(isInSelectionMode: true));
    final key = await Navigator.of(context).push(route);
    await route.completed;

    bloc.add(const ChurchesEvent.init());

    return key;
  }

  const ChurchesPage({Key? key, this.isInSelectionMode = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChurchesBloc, ChurchesState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          slivers: [
            isInSelectionMode ? const SliverPadding(padding: Styles.edgeInsetVertical10, sliver: SliverPageHeader(subHeader: 'Select the church you want to pay the tithe to.')) : const SliverPageHeader(header: 'Churches', subHeader: 'See all your added churches.', hasSpace: true),
            if (state.churches.isNotEmpty) _buildList(context, state.churches) else const SliverNothingFound(),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<ChurchCardModel> churches) {
    return SliverPadding(
      padding: Styles.edgeInsetAll0,
      sliver: SliverToBoxAdapter(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: churches.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            final e = churches[index];
            return ChurchCard.item(church: e, isInSelectionMode: isInSelectionMode);
          },
        ),
      ),
    );
  }
}
