import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/domain/extensions/string_extensions.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:tithe_box/presentation/income_record/widgets/sliver_income_choice_bar.dart';
import 'package:tithe_box/presentation/income_record/widgets/income_record_card.dart';
import 'package:tithe_box/presentation/income_record/widgets/sliver_page_header.dart';
import 'package:tithe_box/presentation/shared/clickable_title.dart';
import 'package:tithe_box/presentation/shared/default_button.dart';
import 'package:tithe_box/presentation/shared/loading.dart';
import 'package:tithe_box/presentation/shared/sliver_nothing_found.dart';
import 'package:tithe_box/presentation/shared/sliver_scaffold_with_fab.dart';

class IncomeRecordPage extends StatelessWidget {
  final bool hasAppBar;
  const IncomeRecordPage({Key? key, this.hasAppBar = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<IncomesBloc, IncomesState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          appbar: hasAppBar ? const _AppBar() : null,
          slivers: [
            SliverPageHeader(header: 'Income Record', subHeader: 'Input the needed details and calculate your tithe seamlessly.', hasSpace: !hasAppBar),
            const SliverIncomeChoiceBar(),
            SliverClickableTitle(
              title: 'Income Record - (${Assets.translateSalaryType(state.salaryType)})',
              textStyle: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            if (state.incomes.isNotEmpty)
              ...[
                SliverToBoxAdapter(child: _buildGroupedList(context, state.incomes)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  sliver: SliverToBoxAdapter(
                    child: DefaultButton(
                      isPrimary: true,
                      text: 'Calculate Tithe',
                      onPressed: () {},
                    ),
                  ),
                ),
              ]
            else const SliverNothingFound(),

          ],
        ),
      ),
    );
  }

  Widget _buildGroupedList(BuildContext context, List<IncomeCardModel> incomes, {ScrollController? scrollController}) {
    return GroupedListView<IncomeCardModel, String>(
      shrinkWrap: true,
      elements: incomes,
      controller: scrollController,
      groupBy: (item) => item.createdAt.formatDateString(),
      itemBuilder: (context, element) => IncomeRecordCard.item(income: element),
      groupSeparatorBuilder: (type) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(type),
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}