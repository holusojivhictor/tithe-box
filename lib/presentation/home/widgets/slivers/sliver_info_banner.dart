import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/extensions/double_extensions.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/shared/sliver_loading.dart';
import 'package:tithe_box/theme.dart';

import '../info_banner.dart';

class SliverInfoBanner extends StatefulWidget {
  const SliverInfoBanner({Key? key}) : super(key: key);

  @override
  State<SliverInfoBanner> createState() => _SliverInfoBannerState();
}

class _SliverInfoBannerState extends State<SliverInfoBanner> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomesBloc, IncomesState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const SliverLoading(),
        loaded: (state) => BlocBuilder<SettingsBloc, SettingsState>(
          builder: (ctx, settingsState) => settingsState.map(
            loading: (_) => const SliverLoading(),
            loaded: (settingsState) {
              final titheValue = calculateTithe(state.totalIncome, settingsState.tithePercentage);
              final homeBannerData = [
                BannerData(
                  header: 'Total Income\n\n',
                  info: 'N${state.totalIncome.parseToString()}',
                ),
                BannerData(
                  header: 'Tithe Percentage\n\n',
                  info: '${settingsState.tithePercentage}%',
                ),
                BannerData(
                  header: 'Tithe Amount\n\n',
                  info: 'N${titheValue.parseToString()}',
                ),
              ];

              return SliverPadding(
                padding: Styles.homeContentPadding,
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 135,
                        child: PageView.builder(
                          onPageChanged: (value) {
                            setState(() {
                              _currentPage = value;
                            });
                          },
                          itemCount: Data.homeBannerData.length,
                          itemBuilder: (context, index) => InfoBanner(
                            header: homeBannerData[index].header,
                            info: homeBannerData[index].info,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) => buildDot(index: index)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: kPadding / 1.5),
      height: 3,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? kPrimary : kPrimary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
