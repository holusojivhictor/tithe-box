import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/presentation/shared/clickable_title.dart';
import 'package:tithe_box/presentation/shared/loading.dart';

import 'widgets/slivers/sliver_add_income_form.dart';
import 'widgets/slivers/sliver_cards_menu.dart';
import 'widgets/slivers/sliver_choice_bar.dart';
import 'widgets/slivers/sliver_home_greet.dart';
import 'widgets/slivers/sliver_info_banner.dart';
import 'widgets/slivers/sliver_slider_bar.dart';
import 'widgets/slivers/sliver_slider_form.dart';
import 'widgets/slivers/sliver_verse_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) {
          final contentType = state.contentType;
          List children;
          switch (contentType) {
            case HomeContentType.all:
              children = [
                const SliverSliderBar(),
                const SliverCardsMenu(),
                SliverClickableTitle(title: 'What the Bible says', color: Theme.of(context).primaryColor),
                const SliverVerseCard(),
              ];
              break;
            case HomeContentType.addIncome:
              children = [
                const SliverAddIncomeForm(),
              ];
              break;
            case HomeContentType.tithingSlider:
              children = [
                const SliverSliderForm(),
              ];
              break;
            case HomeContentType.progress:
              children = [SliverToBoxAdapter(child: Container())];
              break;
            default:
              children = [SliverToBoxAdapter(child: Container())];
              break;
          }

          return ResponsiveBuilder(
            builder: (ctx, size) => Scaffold(
              body: CustomScrollView(
                slivers: [
                  const SliverHomeGreet(),
                  const SliverInfoBanner(),
                  const SliverChoiceBar(),
                  ...children,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
