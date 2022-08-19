import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/presentation/shared/custom_card.dart';
import 'package:tithe_box/theme.dart';

class VerseCard extends StatefulWidget {
  const VerseCard({Key? key}) : super(key: key);

  @override
  State<VerseCard> createState() => _VerseCardState();
}

class _VerseCardState extends State<VerseCard> {
  final PageController _controller = PageController();
  int _currentVerse = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
  }

  void _animateToPage() {
    if (_controller.hasClients) {
      _controller.animateToPage(_currentVerse, duration: kAnimationDuration, curve: Curves.linear);
    }
  }

  void _animateSlider() {
    Timer.periodic(const Duration(seconds: 6), (timer) {
      if (_currentVerse < Data.verseData.length - 1) {
        _currentVerse++;
        _animateToPage();
      } else {
        _currentVerse = 0;
        _animateToPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomCard(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      margin: Styles.edgeInsetAll10,
      shape: Styles.mainCardShape,
      child: SizedBox(
        height: 160,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            ClipRRect(
              borderRadius: Styles.mainCardBorderRadius,
              child: Image(
                image: AssetImage(Assets.getImagePath('hands-prayer.jpg')),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            Container(
              alignment: AlignmentDirectional.centerStart,
              decoration: BoxDecoration(
                borderRadius: Styles.mainCardBorderRadius,
                color: kDark.withOpacity(0.5),
              ),
              child: Padding(
                padding: Styles.edgeInsetAll10,
                child: SizedBox(
                  child: PageView.builder(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        _currentVerse = value;
                      });
                    },
                    itemCount: Data.verseData.length,
                    itemBuilder: (context, index) => Text(
                      Data.verseData[index],
                      style: theme.textTheme.bodyLarge!.copyWith(color: kWhite),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
