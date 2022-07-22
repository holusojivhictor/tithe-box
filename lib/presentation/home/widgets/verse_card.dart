import 'package:flutter/material.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/presentation/shared/custom_card.dart';
import 'package:tithe_box/theme.dart';

class VerseCard extends StatelessWidget {
  final String bibleVerse;
  const VerseCard({Key? key, required this.bibleVerse}) : super(key: key);

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
                child: Text(
                  bibleVerse,
                  style: theme.textTheme.bodyLarge!.copyWith(color: kWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}