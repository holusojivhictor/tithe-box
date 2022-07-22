import 'package:flutter/material.dart';
import 'package:tithe_box/domain/app_constants.dart';
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
                  header: Data.homeBannerData[index].header,
                  info: Data.homeBannerData[index].info,
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
