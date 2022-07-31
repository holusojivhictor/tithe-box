import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/presentation/home/widgets/slider_bar.dart';
import 'package:tithe_box/presentation/shared/custom_form_field.dart';
import 'package:tithe_box/presentation/shared/default_button.dart';
import 'package:tithe_box/presentation/shared/loading.dart';
import 'package:tithe_box/presentation/shared/row_text.dart';
import 'package:tithe_box/theme.dart';

class CalculateTitheForm extends StatefulWidget {
  const CalculateTitheForm({Key? key}) : super(key: key);

  @override
  State<CalculateTitheForm> createState() => _CalculateTitheFormState();
}

class _CalculateTitheFormState extends State<CalculateTitheForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController incomeController = TextEditingController();
  bool submitted = false;

  String? incomeErrorText;

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
                return "Enter a value for total income";
              }
              return null;
            },
          ),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (ctx, state) => state.map(
              loading: (_) => const Loading(useScaffold: false),
              loaded: (state) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SliderBar(
                  sliderValue: state.tithePercentage,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      "Test data",
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: DefaultButton(
              isPrimary: true,
              text: 'Record Tithe',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
