import 'package:flutter/material.dart';
import 'package:tithe_box/theme.dart';

class ListTileChoice<T> extends StatelessWidget {
  final T value;
  final String valueText;
  final TextStyle? textStyle;
  final void Function(T value)? onPressed;
  final bool isSelected;

  const ListTileChoice({
    Key? key,
    required this.value,
    required this.valueText,
    required this.textStyle,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Styles.edgeInsetHorizontal5,
      child: CheckboxListTile(
        dense: true,
        activeColor: kPrimary,
        contentPadding: Styles.edgeInsetHorizontal10,
        title: Text(
          valueText,
          style: textStyle,
        ),
        value: isSelected,
        onChanged: onPressed != null ? (v) => onPressed!(value) : null,
      ),
    );
  }
}
