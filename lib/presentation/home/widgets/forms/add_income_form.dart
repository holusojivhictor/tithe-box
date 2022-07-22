import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/shared/custom_form_field.dart';

class AddIncomeForm extends StatefulWidget {
  const AddIncomeForm({Key? key}) : super(key: key);

  @override
  State<AddIncomeForm> createState() => _AddIncomeFormState();
}

class _AddIncomeFormState extends State<AddIncomeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController dateController = TextEditingController();
  late TextEditingController incomeController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  bool submitted = false;

  String? dateErrorText;
  String? incomeErrorText;
  String? descriptionErrorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormFieldWithBorder(
            text: "Date",
            hintText: "e.g dd/mm/yy",
            textEditingController: dateController,
            textInputType: TextInputType.text,
            errorText: dateErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter a value for date";
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
        ],
      ),
    );
  }
}
