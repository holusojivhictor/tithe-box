import 'package:flutter/material.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/presentation/shared/choice/choice_list.dart';
import 'package:tithe_box/presentation/shared/custom_form_field.dart';
import 'package:tithe_box/presentation/shared/row_text.dart';

class AddChurchForm extends StatefulWidget {
  const AddChurchForm({Key? key}) : super(key: key);

  @override
  State<AddChurchForm> createState() => _AddChurchFormState();
}

class _AddChurchFormState extends State<AddChurchForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController churchNameController = TextEditingController();
  late TextEditingController locationController = TextEditingController();
  late TextEditingController accountNameController = TextEditingController();
  late TextEditingController accountNumberController = TextEditingController();
  bool submitted = false;
  List<ChurchServiceDay> selectedServiceDays = <ChurchServiceDay>[ChurchServiceDay.Sunday];

  String? nameErrorText;
  String? locationErrorText;
  String? accountNameErrorText;
  String? accountNumberErrorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormFieldWithBorder(
            text: "Church Name",
            hintText: "e.g Assemblies of God",
            textEditingController: churchNameController,
            textInputType: TextInputType.text,
            errorText: nameErrorText,
            isSubmitted: submitted,
            isBold: true,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter the name of your church";
              }
              return null;
            },
          ),
          FormFieldWithBorder(
            text: "Address",
            hintText: "e.g No. 5 Williams street, Asaba",
            textEditingController: locationController,
            textInputType: TextInputType.text,
            errorText: locationErrorText,
            isSubmitted: submitted,
            isBold: true,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your church's address";
              }
              return null;
            },
          ),
          FormFieldWithBorder(
            text: "Bank Account Name",
            hintText: "e.g Assemblies of God Ministries",
            textEditingController: accountNameController,
            textInputType: TextInputType.name,
            errorText: accountNameErrorText,
            isSubmitted: submitted,
            isBold: true,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your church's bank account name";
              }
              return null;
            },
          ),
          FormFieldWithBorder(
            text: "Bank Account Number",
            hintText: "e.g 0690000032",
            textEditingController: accountNumberController,
            textInputType: TextInputType.number,
            errorText: accountNumberErrorText,
            isSubmitted: submitted,
            isBold: true,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your church's bank account number";
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
            child: RowText(
              isBold: true,
              text: 'Service Days',
              color: Theme.of(context).indicatorColor.withOpacity(0.8),
            ),
          ),
          ChoiceList<ChurchServiceDay>(
            values: ChurchServiceDay.values,
            choiceText: (val, _) => val.name,
            selectedValues: selectedServiceDays,
            onSelected: (v) => _handlePressEvent(v),
          ),
        ],
      ),
    );
  }

  void _handlePressEvent(ChurchServiceDay day) {
    if (selectedServiceDays.contains(day)) {
      selectedServiceDays = selectedServiceDays.where((d) => d != day).toList();
    } else {
      selectedServiceDays = selectedServiceDays + [day];
    }
    setState(() {});
  }
}
