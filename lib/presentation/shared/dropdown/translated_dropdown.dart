import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/shared/utils/enum_utils.dart';
import 'package:tithe_box/theme.dart';

class TranslatedDropdown<T> extends StatelessWidget {
  final String hint;
  final T currentValue;
  final List<TranslatedEnum<T>> values;
  final Function(T, BuildContext)? onChanged;
  final bool isExpanded;
  final bool withoutUnderline;

  const TranslatedDropdown({
    Key? key,
    required this.hint,
    required this.currentValue,
    required this.values,
    this.onChanged,
    this.isExpanded = true,
    this.withoutUnderline = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    return DropdownButton<T>(
      isExpanded: isExpanded,
      hint: Text(hint, style: TextStyle(color: customTheme.baseTextColor)),
      value: currentValue,
      underline: withoutUnderline ? Container(height: 0, color: Colors.transparent) : null,
      onChanged: onChanged != null ? (v) => onChanged!(v as T, context) : null,
      selectedItemBuilder: (context) => values.map((lang) => Align(
        alignment: Alignment.centerLeft,
        child: Text(lang.translation, textAlign: TextAlign.center, style: TextStyle(color: customTheme.baseTextColor)),
      )).toList(),
      items: values.map<DropdownMenuItem<T>>((lang) => DropdownMenuItem<T>(
        value: lang.enumValue,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: lang.enumValue != currentValue ? const SizedBox(width: 20) : const Center(child: Icon(Icons.check)),
            ),
            Expanded(
              child: Text(
                lang.translation,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: customTheme.baseTextColor),
                maxLines: 2,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}
