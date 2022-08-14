import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/shared/dropdown/translated_dropdown.dart';
import 'package:tithe_box/presentation/shared/utils/enum_utils.dart';
import 'package:tithe_box/theme.dart';

import 'common_dropdown_button.dart';

class CustomFullDropdownButton<T> extends StatelessWidget {
  final String title;
  final T currentValue;
  final bool isExpanded;
  final List<T> items;
  final List<TranslatedEnum<T>> translatedItems;
  final void Function(T)? onChanged;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool isTranslated;
  final bool hasBorder;

  const CustomFullDropdownButton({
    Key? key,
    required this.title,
    required this.currentValue,
    this.items = const [],
    this.translatedItems = const [],
    this.onChanged,
    this.isExpanded = true,
    this.isTranslated = false,
    this.margin = const EdgeInsets.only(bottom: 15),
    this.padding = const EdgeInsets.only(left: 10),
    this.hasBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: hasBorder ? null : const Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(30),
        border: hasBorder ? Border.all(color: customTheme.formBorder!) : null,
      ),
      child: isTranslated
          ? TranslatedDropdown<T>(
              hint: title,
              currentValue: currentValue,
              isExpanded: isExpanded,
              withoutUnderline: true,
              values: translatedItems,
              onChanged: onChanged != null ? (v, _) => onChanged!(v!) : null,
            )
          : CommonDropdownButton<T>(
              hint: title,
              currentValue: currentValue,
              isExpanded: isExpanded,
              withoutUnderline: true,
              values: items,
              onChanged: onChanged != null ? (v, _) => onChanged!(v!) : null,
            ),
    );
  }
}
