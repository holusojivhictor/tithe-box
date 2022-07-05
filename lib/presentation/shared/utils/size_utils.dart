import 'package:flutter/material.dart';

double getTopHeightForOnboarding(BuildContext context) {
  const factor = 0.65;
  final value = MediaQuery.of(context).size.height * factor;
  if (value > 700) {
    return 700;
  }
  return value;
}

double getTopMarginForOnboarding(BuildContext context) {
  final maxTopHeight = (getTopHeightForOnboarding(context)) - 90;
  return maxTopHeight;
}

double getTopHeightForPortrait(BuildContext context, bool isASmallImage) {
  final factor = isASmallImage ? 0.5 : 0.6;
  final value = MediaQuery.of(context).size.height * factor;
  if (value > 700) {
    return 700;
  }
  return value;
}

double getTopMarginForPortrait(BuildContext context, bool isASmallImage) {
  final maxTopHeight = (getTopHeightForPortrait(context, isASmallImage)) - 50;
  return maxTopHeight;
}