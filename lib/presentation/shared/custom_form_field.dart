import 'package:flutter/material.dart';
import 'package:tithe_box/theme.dart';

import 'row_text.dart';

typedef Validator = String? Function(String?);
typedef OnChanged = void Function(String);

class FormFieldWithoutBorder extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final String text;
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Validator? validator;
  final OnChanged? onChanged;
  final String? errorText;
  final bool isSubmitted;
  final int? maxLength;
  final bool hasText;

  const FormFieldWithoutBorder({
    Key? key,
    this.text = '',
    this.margin = const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    required this.hintText,
    required this.textEditingController,
    required this.textInputType,
    this.isSubmitted = false,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.errorText,
    this.maxLength,
    this.hasText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasText)
            Padding(
              padding: Styles.edgeInsetHorizontal10,
              child: RowText(text: text),
            ),
          SizedBox(height: hasText ? 10 : 0),
          TextFormField(
            autovalidateMode: isSubmitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
            controller: textEditingController,
            obscureText: obscureText,
            onSaved: (value) {
              textEditingController.text = value ?? "";
            },
            onChanged: onChanged,
            validator: validator,
            keyboardType: textInputType,
            maxLength: maxLength,
            decoration: InputDecoration(
              counter: maxLength != null ? const Offstage() : null,
              hintText: hintText,
              errorText: errorText,
              suffixIcon: suffixIcon,
              contentPadding: Styles.formFieldPadding,
              border: Styles.formFieldBorder,
              filled: true,
              fillColor: const Color(0xFFE5E5E5),
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(letterSpacing: 0.5, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}


class FormFieldWithBorder extends StatelessWidget {
  final String text;
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Validator? validator;
  final OnChanged? onChanged;
  final String? errorText;
  final bool isSubmitted;
  final int? maxLength;

  const FormFieldWithBorder({
    Key? key,
    required this.text,
    required this.hintText,
    required this.textEditingController,
    required this.textInputType,
    this.isSubmitted = false,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.errorText,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: Styles.formFieldMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowText(
            text: text,
            color: theme.indicatorColor.withOpacity(0.8),
          ),
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: isSubmitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
            controller: textEditingController,
            obscureText: obscureText,
            onSaved: (value) {
              textEditingController.text = value ?? "";
            },
            onChanged: onChanged,
            validator: validator,
            keyboardType: textInputType,
            maxLength: maxLength,
            decoration: InputDecoration(
              counter: maxLength != null ? const Offstage() : null,
              hintText: hintText,
              errorText: errorText,
              suffixIcon: suffixIcon,
              contentPadding: Styles.altFormFieldPadding,
              border: Styles.altFormFieldBorder,
              enabledBorder: Styles.altFormFieldBorder,
              focusedBorder: Styles.altFormFieldBorder,
              filled: true,
              fillColor: theme.scaffoldBackgroundColor,
              hintStyle: theme.textTheme.bodyMedium!.copyWith(letterSpacing: 0.5, color: theme.indicatorColor.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }
}