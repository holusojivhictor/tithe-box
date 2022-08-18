import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/extensions/double_extensions.dart';
import 'package:tithe_box/presentation/home/widgets/slider_bar.dart';
import 'package:tithe_box/presentation/shared/custom_form_field.dart';
import 'package:tithe_box/presentation/shared/loading.dart';
import 'package:tithe_box/presentation/shared/row_text.dart';
import 'package:tithe_box/theme.dart';

class CalculateTitheForm extends StatefulWidget {
  final double totalIncome;
  const CalculateTitheForm({
    Key? key,
    required this.totalIncome,
  }) : super(key: key);

  @override
  State<CalculateTitheForm> createState() => _CalculateTitheFormState();
}

class _CalculateTitheFormState extends State<CalculateTitheForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController incomeController = TextEditingController();
  bool submitted = true;
  bool hasError = false;

  String? incomeErrorText;

  @override
  void initState() {
    super.initState();
    incomeController.text = widget.totalIncome.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormFieldWithBorder(
            text: "What’s your Income?",
            hintText: "Enter total income",
            textEditingController: incomeController,
            textInputType: TextInputType.number,
            errorText: incomeErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                hasError = true;
                return "Enter a value for total income";
              } else if (!amountValidatorRegExp.hasMatch(value)) {
                hasError = true;
                return "Please enter a valid amount. Signs not necessary.";
              }
              hasError = false;
              return null;
            },
          ),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (ctx, state) => state.map(
              loading: (_) => const Loading(useScaffold: false),
              loaded: (state) {
                final titheValue = calculateTithe(hasError ? 0 : double.parse(incomeController.text), state.tithePercentage);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SliderBar(
                        sliderValue: state.tithePercentage,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        child: const RowText(text: 'Your Tithe is'),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        padding: Styles.altFormFieldPadding,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: customTheme.formBorder!),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              hasError ? '0' : titheValue.parseToString(),
                              style: TextStyle(color: Theme.of(context).indicatorColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
