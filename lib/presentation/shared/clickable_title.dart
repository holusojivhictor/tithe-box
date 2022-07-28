import 'package:flutter/material.dart';

class ClickableTitle extends StatelessWidget {
  final String title;
  final Function? onClick;
  final String? buttonText;
  final TextStyle? textStyle;
  final TextStyle? trailingTextStyle;
  final EdgeInsetsGeometry padding;
  final Color? color;

  const ClickableTitle({
    Key? key,
    required this.title,
    this.padding = const EdgeInsets.only(top: 5, left: 5),
    this.onClick,
    this.buttonText,
    this.textStyle,
    this.trailingTextStyle,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final endText = buttonText != null
        ? Text(buttonText!, style: trailingTextStyle ?? theme.textTheme.bodyLarge)
        : null;

    return Padding(
      padding: padding,
      child: ListTile(
        dense: true,
        onTap: () => onClick?.call(),
        visualDensity: const VisualDensity(vertical: -4, horizontal: -2),
        trailing: endText,
        title: Text(
          title,
          textAlign: TextAlign.start,
          style: textStyle ?? theme.textTheme.bodyLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.15, color: color),
        ),
      ),
    );
  }
}

class SliverClickableTitle extends StatelessWidget {
  final String title;
  final Function? onClick;
  final String? buttonText;
  final TextStyle? textStyle;
  final TextStyle? trailingTextStyle;
  final EdgeInsetsGeometry padding;
  final Color? color;

  const SliverClickableTitle({
    Key? key,
    required this.title,
    this.padding = const EdgeInsets.only(top: 5, left: 5),
    this.onClick,
    this.buttonText,
    this.textStyle,
    this.trailingTextStyle,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final endText = buttonText != null
        ? Text(buttonText!, style: trailingTextStyle ?? theme.textTheme.bodyLarge)
        : null;

    return SliverPadding(
      padding: padding,
      sliver: SliverToBoxAdapter(
        child: ListTile(
          dense: true,
          onTap: () => onClick?.call(),
          visualDensity: const VisualDensity(vertical: -4),
          trailing: endText,
          title: Text(
            title,
            textAlign: TextAlign.start,
            style: textStyle ?? theme.textTheme.bodyLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.15, color: color),
          ),
        ),
      ),
    );
  }
}
