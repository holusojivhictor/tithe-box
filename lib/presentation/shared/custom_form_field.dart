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
  final Widget? child;
  final bool isSubmitted;
  final int? maxLength;
  final bool isSelectable;
  final bool enabled;
  final bool isBold;

  const FormFieldWithBorder({
    Key? key,
    required this.text,
    required this.hintText,
    required this.textEditingController,
    required this.textInputType,
    this.isSubmitted = false,
    this.obscureText = false,
    this.isSelectable = false,
    this.enabled = true,
    this.isBold = false,
    this.child,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.errorText,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    final theme = Theme.of(context);

    return Container(
      margin: Styles.formFieldMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowText(
            text: text,
            isBold: isBold,
            isSelectable: isSelectable,
            color: theme.indicatorColor.withOpacity(0.8),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            child: child,
          ),
          const SizedBox(height: 10),
          TextFormField(
            style: TextStyle(color: customTheme.baseTextColor),
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
              enabled: enabled,
              counter: maxLength != null ? const Offstage() : null,
              hintText: hintText,
              errorText: errorText,
              suffixIcon: suffixIcon,
              contentPadding: Styles.altFormFieldPadding,
              border: altFormFieldBorder(context),
              enabledBorder: altFormFieldBorder(context),
              filled: true,
              fillColor: theme.scaffoldBackgroundColor,
              hintStyle: theme.textTheme.bodyMedium!.copyWith(letterSpacing: 0.5, color: theme.indicatorColor.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder altFormFieldBorder(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    return OutlineInputBorder(
      borderSide: BorderSide(color: customTheme.formBorder!),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    );
  }
}
