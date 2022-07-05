import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/shared/utils/size_utils.dart';

class TopPortraitLayout extends StatelessWidget {
  final List<Widget> children;
  final Color? color;
  final Widget? appBar;

  const TopPortraitLayout({
    Key? key,
    required this.children,
    this.color,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: getTopHeightForOnboarding(context),
      width: width,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          ...children,
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: appBar ?? const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
