import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/shared/utils/size_utils.dart';
import 'package:tithe_box/theme.dart';

class BottomPortraitLayout extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;

  const BottomPortraitLayout({
    Key? key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxTopHeight = getTopMarginForOnboarding(context);
    return SizedBox(
      width: size.width,
      child: ClipPath(
        clipper: CurvedContainer(),
        child: Card(
          margin: EdgeInsets.only(top: maxTopHeight),
          elevation: 0,
          child: Padding(
            padding: Styles.edgeInsetAll10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: mainAxisAlignment,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

class CurvedContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final roundingHeight = size.height * 0.1;
    final filledRectangle = Rect.fromLTRB(0, size.height / 1.53, size.width, size.height);
    final roundingRectangle = Rect.fromLTRB(-10, size.height - roundingHeight * 4.3, size.width + 10, size.height - roundingHeight * 2);

    final path = Path();
    path.addRect(filledRectangle);

    path.arcTo(roundingRectangle, -pi, pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
