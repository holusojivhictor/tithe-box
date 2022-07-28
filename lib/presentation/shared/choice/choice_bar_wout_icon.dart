import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/shared/utils/enum_utils.dart';
import 'package:tithe_box/theme.dart';

import 'alt_common_choice_button.dart';

typedef ChoiceButtonText<T> = String Function(T value, int index);

class ChoiceBarWithoutIcon<TEnum> extends StatelessWidget {
  final TEnum selectedValue;
  final List<TEnum> values;
  final Function(TEnum)? onSelected;
  final List<TEnum> exclude;
  final ChoiceButtonText<TEnum> choiceText;
  final WrapAlignment alignment;

  const ChoiceBarWithoutIcon({
    Key? key,
    required this.selectedValue,
    required this.values,
    this.onSelected,
    this.exclude = const [],
    this.alignment = WrapAlignment.start,
    required this.choiceText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    final translatedValues = getTranslatedValues();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: Styles.edgeInsetAll5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: customTheme.categoryOverlay,
        ),
        height: 45,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: SizedBox(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: getButtons(context, translatedValues),
            ),
          ),
        ),
      ),
    );
  }

  List<TranslatedEnum<TEnum>> getTranslatedValues() {
    return EnumUtils.getTranslatedAndSortedEnum<TEnum>(values, choiceText, exclude: exclude, sort: false);
  }

  List<Widget> getButtons(BuildContext context, List<TranslatedEnum<TEnum>> translatedValues) {
    return translatedValues.map((e) => _buildChoiceButton(context, e.enumValue, e.translation)).toList();
  }

  Widget _buildChoiceButton(BuildContext context, TEnum value, String valueText) {
    final theme = Theme.of(context);
    final isSelected = selectedValue == value;
    final textStyle = theme.textTheme.bodySmall!.copyWith(color: isSelected ? Colors.white : Colors.grey);
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: AltCommonChoiceButton<TEnum>(
        value: value,
        isSelected: isSelected,
        valueText: valueText,
        textStyle: textStyle,
        onPressed: handleItemSelected,
      ),
    );
  }

  void handleItemSelected(TEnum value) {
    onSelected?.call(value);
  }
}


class ChoiceBarWithoutIconWithAllValue extends ChoiceBarWithoutIcon<int> {
  static int allValue = -1;

  final Function(int?)? onAllOrValueSelected;
  final bool sort;

  ChoiceBarWithoutIconWithAllValue({
    Key? key,
    int? selectedValue,
    this.onAllOrValueSelected,
    this.sort = true,
    required List<int> values,
    required ChoiceButtonText<int> choiceText,
    List<int> exclude = const [],
  }) : super(
    key: key,
    selectedValue: selectedValue ?? allValue,
    choiceText: choiceText,
    exclude: exclude,
    values: values..add(allValue),
  );

  @override
  List<TranslatedEnum<int>> getTranslatedValues() {
    return EnumUtils.getTranslatedAndSortedEnumWithAllValue(allValue, 'All', values, choiceText, sort: sort, exclude: exclude);
  }

  @override
  void handleItemSelected(int value) {
    if (onAllOrValueSelected == null) {
      return;
    }

    final valueToUse = value == allValue ? null : value;
    onAllOrValueSelected!(valueToUse);
  }
}