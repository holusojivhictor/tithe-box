import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/domain/extensions/string_extensions.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:tithe_box/presentation/income_record/widgets/sliver_income_choice_bar.dart';
import 'package:tithe_box/presentation/income_record/widgets/income_record_card.dart';
import 'package:tithe_box/presentation/shared/sliver_page_header.dart';
import 'package:tithe_box/presentation/shared/clickable_title.dart';
import 'package:tithe_box/presentation/shared/loading.dart';
import 'package:tithe_box/presentation/shared/sliver_nothing_found.dart';
import 'package:tithe_box/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:tithe_box/theme.dart';

class IncomeRecordPage extends StatelessWidget {
  final bool hasAppBar;
  const IncomeRecordPage({Key? key, this.hasAppBar = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    final theme = Theme.of(context);

    return BlocBuilder<IncomesBloc, IncomesState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          appbar: hasAppBar ? const _AppBar() : null,
          slivers: [
            SliverPageHeader(header: 'Income Record', subHeader: 'View your recorded incomes grouped by time added.', hasSpace: !hasAppBar),
            const SliverIncomeChoiceBar(),
            SliverClickableTitle(
              title: 'Income Record - (${Assets.translateSalaryType(state.salaryType)})',
              textStyle: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, color: customTheme.baseTextColor),
            ),
            if (state.incomes.isNotEmpty)
              ...[
                SliverToBoxAdapter(child: _buildGroupedList(context, state.incomes)),
              ]
            else const SliverNothingFound(),

          ],
        ),
      ),
    );
  }

  Widget _buildGroupedList(BuildContext context, List<IncomeCardModel> incomes, {ScrollController? scrollController}) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    return GroupedListView<IncomeCardModel, String>(
      shrinkWrap: true,
      elements: incomes,
      controller: scrollController,
      groupBy: (item) => item.createdAt.formatDateString(),
      itemBuilder: (context, element) => IncomeRecordCard.item(income: element),
      groupSeparatorBuilder: (type) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(type, style: TextStyle(color: customTheme.baseTextColor)),
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
        "Income Record",
        style: theme.textTheme.displayMedium!.copyWith(fontSize: 20, color: theme.primaryColor),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
