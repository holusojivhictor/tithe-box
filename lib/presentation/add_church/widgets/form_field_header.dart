import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/shared/row_text.dart';

class FormFieldHeader extends StatelessWidget {
  final String text;
  const FormFieldHeader({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: RowText(text: text, isBold: true),
    );
  }
}
