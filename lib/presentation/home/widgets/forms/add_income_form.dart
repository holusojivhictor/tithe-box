import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/presentation/shared/custom_form_field.dart';
import 'package:tithe_box/presentation/shared/default_button.dart';
import 'package:tithe_box/presentation/shared/item_popup_menu_filter.dart';
import 'package:tithe_box/presentation/shared/row_text.dart';
import 'package:tithe_box/presentation/shared/utils/toast_utils.dart';
import 'package:tithe_box/theme.dart';

class AddIncomeForm extends StatefulWidget {
  const AddIncomeForm({Key? key}) : super(key: key);

  @override
  State<AddIncomeForm> createState() => _AddIncomeFormState();
}

class _AddIncomeFormState extends State<AddIncomeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController businessNameController = TextEditingController();
  late TextEditingController incomeController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  SalaryType selectedSalaryType = SalaryType.weekly;
  bool submitted = false;

  String? businessNameErrorText;
  String? incomeErrorText;
  String? descriptionErrorText;

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormFieldWithBorder(
            text: "Business Name",
            hintText: "e.g Trainer",
            textEditingController: businessNameController,
            textInputType: TextInputType.text,
            errorText: businessNameErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your business name";
              }
              return null;
            },
          ),
          FormFieldWithBorder(
            text: "Income Earned",
            hintText: "e.g \$1000.00",
            textEditingController: incomeController,
            textInputType: TextInputType.number,
            errorText: incomeErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter a value for income";
              }
              return null;
            },
          ),
          FormFieldWithBorder(
            text: "Description",
            hintText: "e.g i earned \$1000 from my business.",
            textEditingController: descriptionController,
            textInputType: TextInputType.text,
            errorText: descriptionErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return "Briefly describe the nature of this income";
              }
              return null;
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: const RowText(text: 'Frequency'),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: customTheme.formBorder!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Assets.translateSalaryType(selectedSalaryType),
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                    ),
                    ItemPopupMenuFilter<SalaryType>(
                      toolTipText: 'Salary',
                      selectedValue: selectedSalaryType,
                      values: SalaryType.values,
                      onSelected: (newVal) {
                        setState(() {
                          selectedSalaryType = newVal;
                        });
                      },
                      icon: Icon(Icons.expand_more, color: customTheme.formBorder!),
                      itemText: (val, _) => Assets.translateSalaryType(val),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: Styles.edgeInsetAll10,
            child: DefaultButton(
              isPrimary: true,
              text: 'Record Income',
              onPressed: () => _recordIncome(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _recordIncome(BuildContext context) async {
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final bloc = context.read<DataBloc>();
      final fToast = ToastUtils.of(context);
      bloc.add(DataEvent.recordIncome(businessName: businessNameController.text, incomeAmount: incomeController.text, description: descriptionController.text, frequency: selectedSalaryType.name));
      ToastUtils.showSucceedToast(fToast, 'Income added successfully');
      setState(() => submitted = false);
      TextEditingController().clear();
    }
  }
}
