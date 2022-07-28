import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool hasBorder;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double maxHeight;
  final Color? backgroundColor;
  final bool hasIcon;
  final Widget? child;
  final double? elevation;

  const DefaultButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = false,
    this.hasBorder = false,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    this.borderRadius = 30,
    this.maxHeight = 55,
    this.hasIcon = false,
    this.child,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width * 0.8;

    return Padding(
      padding: padding,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 17)),
          backgroundColor: backgroundColor != null ? MaterialStateProperty.all(backgroundColor) : MaterialStateProperty.all(isPrimary ? theme.primaryColor : theme.scaffoldBackgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
              side: hasBorder
                  ? BorderSide(color: theme.indicatorColor)
                  : BorderSide.none,
            ),
          ),
          elevation: MaterialStateProperty.all(elevation),
          shadowColor: MaterialStateProperty.all(theme.shadowColor),
          maximumSize: MaterialStateProperty.all(Size(width, maxHeight)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: theme.textTheme.bodyLarge!.copyWith(color: isPrimary ? Colors.white : null)),
            if (hasIcon)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: child,
              ),
          ],
        ),
      ),
    );
  }
}

class ProgressButton extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double minHeight;
  final double? elevation;

  const ProgressButton({
    Key? key,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    this.minHeight = 55,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;

    return Padding(
      padding: padding,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
          elevation: MaterialStateProperty.all(elevation),
          minimumSize: MaterialStateProperty.all(Size(width, minHeight)),
        ),
        onPressed: null,
        child: const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}