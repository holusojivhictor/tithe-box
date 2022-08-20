import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/shared/utils/enum_utils.dart';
import 'package:tithe_box/theme.dart';

import 'list_tile_choice.dart';

typedef ChoiceText<T> = String Function(T value, int index);

class ChoiceList<TEnum> extends StatelessWidget {
  final List<TEnum> selectedValues;
  final List<TEnum> values;
  final Function(TEnum)? onSelected;
  final List<TEnum> exclude;
  final ChoiceText<TEnum> choiceText;
  final bool sort;

  const ChoiceList({
    Key? key,
    this.selectedValues = const [],
    required this.values,
    this.onSelected,
    this.exclude = const [],
    required this.choiceText,
    this.sort = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translatedValues = getTranslatedValues();

    return Column(
      children: getChoices(context, translatedValues),
    );
  }

  List<TranslatedEnum<TEnum>> getTranslatedValues() {
    return EnumUtils.getTranslatedAndSortedEnum<TEnum>(values, choiceText, exclude: exclude, sort: sort);
  }

  List<Widget> getChoices(BuildContext context, List<TranslatedEnum<TEnum>> translatedValues) {
    return translatedValues.map((e) => _buildChoiceTile(context, e.enumValue, e.translation)).toList();
  }

  Widget _buildChoiceTile(BuildContext context, TEnum value, String valueText) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium!.copyWith(color: customTheme.baseTextColor);
    final isSelected = selectedValues.isNotEmpty && selectedValues.contains(value);
    return ListTileChoice<TEnum>(
      value: value,
      isSelected: isSelected,
      valueText: valueText,
      textStyle: textStyle,
      onPressed: handleItemSelected,
    );
  }

  void handleItemSelected(TEnum value) {
    onSelected?.call(value);
  }
}
