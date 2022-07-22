import 'package:flutter/material.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/presentation/shared/custom_card.dart';
import 'package:tithe_box/theme.dart';

class CardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final Function(BuildContext) onClick;

  const CardItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: Styles.homeCardBorderRadius,
      onTap: () => onClick(context),
      child: CustomCard(
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        margin: Styles.edgeInsetAll10,
        shape: const RoundedRectangleBorder(borderRadius: Styles.homeCardBorderRadius),
        child: SizedBox(
          width: Styles.homeCardWidth,
          height: Styles.homeCardHeight,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              ClipRRect(
                borderRadius: Styles.homeCardBorderRadius,
                child: Image(
                  image: AssetImage(Assets.getImagePath(image)),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomStart,
                decoration: const BoxDecoration(
                  borderRadius: Styles.homeCardBorderRadius,
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.05, 1.0],
                    colors: [
                      Color(0xFF000000),
                      Color(0x00000000),
                    ],
                  ),
                ),
                child: Padding(
                  padding: Styles.edgeInsetAll10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w800, color: kWhite),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall!.copyWith(color: kWhite.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
