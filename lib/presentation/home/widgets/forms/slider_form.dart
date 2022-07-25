import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/presentation/shared/custom_form_field.dart';
import 'package:tithe_box/presentation/shared/default_button.dart';
import 'package:tithe_box/presentation/shared/utils/toast_utils.dart';
import 'package:tithe_box/theme.dart';

class SliderForm extends StatefulWidget {
  const SliderForm({Key? key}) : super(key: key);

  @override
  State<SliderForm> createState() => _SliderFormState();
}

class _SliderFormState extends State<SliderForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController percentageController = TextEditingController();
  bool submitted = false;

  String? percentageErrorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormFieldWithoutBorder(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            hintText: 'Input a number here',
            textEditingController: percentageController,
            textInputType: TextInputType.number,
            errorText: percentageErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            suffixIcon: const Icon(Icons.percent, size: 16),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter a value to continue";
              } else if (!phoneNumberValidatorRegExp.hasMatch(value)) {
                return "Please enter a valid value";
              } else if (double.parse(value) > 100) {
                return "Value cannot be greater than 100";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: Styles.edgeInsetAll10,
            child: DefaultButton(
              isPrimary: true,
              text: 'Save',
              onPressed: () => _saveValue(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveValue(BuildContext context) async {
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final bloc = context.read<SettingsBloc>();
      final fToast = ToastUtils.of(context);
      bloc.add(SettingsEvent.tithePercentageChanged(newValue: double.parse(percentageController.text)));
      ToastUtils.showSucceedToast(fToast, 'Percentage successfully updated');
      setState(() => submitted = false);
      percentageController.clear();
    }
  }
}
