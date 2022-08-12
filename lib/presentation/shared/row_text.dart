import 'package:flutter/material.dart';
import 'package:tithe_box/theme.dart';

class RowText extends StatelessWidget {
  final String text;
  final MainAxisAlignment? mainAxisAlignment;
  final bool isSelectable;
  final Widget? child;
  final Color? color;
  final bool hasContainer;
  final bool isBold;

  const RowText({
    Key? key,
    required this.text,
    this.mainAxisAlignment,
    this.isSelectable = false,
    this.hasContainer = false,
    this.isBold = false,
    this.color,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final originalRow =  Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: color ?? Theme.of(context).indicatorColor, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
        if (isSelectable)
          child!,
      ],
    );
    if (hasContainer) {
      return Container(
        margin: Styles.edgeInsetAll16,
        child: originalRow,
      );
    }

    return originalRow;
  }
}
