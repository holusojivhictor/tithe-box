import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/presentation/shared/custom_form_field.dart';
import 'package:tithe_box/presentation/shared/default_button.dart';
import 'package:tithe_box/presentation/shared/row_text.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController fullNameController = TextEditingController();
  late TextEditingController occupationController = TextEditingController();
  late TextEditingController emailAddressController = TextEditingController();
  late TextEditingController nameOfChurchController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController confirmPasswordController = TextEditingController();
  late bool obscurePassword = true;
  late bool obscureConfirmPassword = true;
  bool submitted = false;

  String? fullNameErrorText;
  String? occupationErrorText;
  String? emailErrorText;
  String? nameOfChurchErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomFormField(
            text: "Full Name",
            hintText: "e.g Steven Mark",
            textEditingController: fullNameController,
            textInputType: TextInputType.name,
            errorText: fullNameErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return kFullNameNullError;
              }
              return null;
            },
          ),
          CustomFormField(
            text: "Email",
            hintText: "e.g steven@gmail.com",
            textEditingController: emailAddressController,
            textInputType: TextInputType.emailAddress,
            errorText: emailErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return kEmailNullError;
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                return kInvalidEmailError;
              }
              return null;
            },
          ),
          CustomFormField(
            text: "Occupation",
            hintText: "e.g Civil Engineer",
            textEditingController: occupationController,
            textInputType: TextInputType.name,
            errorText: occupationErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return kOccupationNullError;
              }
              return null;
            },
          ),
          CustomFormField(
            text: "Name of Church",
            hintText: "e.g Assemblies of God.",
            textEditingController: nameOfChurchController,
            textInputType: TextInputType.name,
            errorText: nameOfChurchErrorText,
            isSubmitted: submitted,
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return kNameOfChurchNullError;
              }
              return null;
            },
          ),
          CustomFormField(
            text: "Password",
            hintText: "enter your password",
            obscureText: obscurePassword,
            textEditingController: passwordController,
            textInputType: TextInputType.text,
            errorText: passwordErrorText,
            isSubmitted: submitted,
            suffixIcon: InkWell(
              onTap: () => setState(() => obscurePassword = !obscurePassword),
              child: Icon(
                !obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20,
              ),
            ),
            onChanged: (_) => setState(() {}),
            validator: (value) {
              if (value!.isEmpty) {
                return kPassNullError;
              } else if (value.length < 8) {
                return kShortPassError;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15),
            child: DefaultButton(
              isPrimary: true,
              text: 'Sign Up',
              onPressed: () => _signUp(context),
            ),
          ),
          RowText(
            isSelectable: true,
            text: "Already have an account?.   ",
            mainAxisAlignment: MainAxisAlignment.center,
            child: InkWell(
              onTap: () {
                context.read<SessionBloc>().add(const SessionEvent.signInRequested());
              },
              child: Text(
                'Login',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signUp(BuildContext context) async {
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
}
