import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/application/result/result_state.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/shared/custom_alert_dialog.dart';
import 'package:tithe_box/presentation/shared/custom_form_field.dart';
import 'package:tithe_box/presentation/shared/default_button.dart';
import 'package:tithe_box/presentation/shared/row_text.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController emailAddressController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late bool obscurePassword = true;
  bool submitted = false;

  String? emailErrorText;
  String? passwordErrorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
              text: 'Sign In',
              onPressed: () => _signIn(context),
            ),
          ),
          RowText(
            isSelectable: true,
            text: "Don’t have an Account?.   ",
            mainAxisAlignment: MainAxisAlignment.center,
            child: InkWell(
              onTap: () {
                context.read<SessionBloc>().add(const SessionEvent.signUpRequested());
              },
              child: Text(
                'Register',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn(BuildContext context) async {
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final bloc = context.read<SignInBloc>();
      bloc.add(SignInEvent.signIn(emailAddress: emailAddressController.text, password: passwordController.text));

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => BlocBuilder<SignInBloc, ResultState>(
          builder: (ctx, state) => state.when(
            idle: () => const CustomAlertDialog(text: 'Idling...'),
            loading: () => const CustomAlertDialog(text: 'Signing in...'),
            data: (_) {
              return const CustomAlertDialog(text: 'Initializing data...');
            },
            error: (e) => CustomAlertDialog(title: Text('Log in failed', style: Theme.of(context).textTheme.titleMedium), text: NetworkExceptions.getErrorMessage(e), isError: true),
          ),
        ),
      );
    }
  }
}
