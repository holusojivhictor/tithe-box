import 'package:flutter/material.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/presentation/shared/svg_image.dart';

class AnimatedSplash extends StatelessWidget {
  const AnimatedSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgImage(
                image: Assets.getSvgPath("buildings.svg"),
                label: 'Buildings',
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: [
                  Image.asset(
                    Assets.getImagePath("start-image.png"),
                    height: 210,
                    width: 170,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your digital Tithe Booklet',
                    style: theme.textTheme.bodySmall!.copyWith(fontStyle: FontStyle.italic, color: theme.indicatorColor),
                  ),
                ],
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.grey,
                color: theme.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
