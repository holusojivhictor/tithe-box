import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/application/result/result_state.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/injection.dart';
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
  late SignInBloc _signInBloc;
  late bool obscurePassword = true;
  bool submitted = false;

  String? emailErrorText;
  String? passwordErrorText;

  @override
  void didChangeDependencies() {
    _signInBloc = Injection.getSignInBloc(context.read<SessionBloc>());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _signInBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (ctx) => _signInBloc,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            FormFieldWithoutBorder(
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
            FormFieldWithoutBorder(
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
      ),
    );
  }

  Future<void> _signIn(BuildContext context) async {
    final theme = Theme.of(context);
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _signInBloc.add(SignInEvent.signIn(emailAddress: emailAddressController.text, password: passwordController.text));

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => BlocBuilder<SignInBloc, ResultState>(
          bloc: _signInBloc,
          builder: (ctx, state) => state.when(
            idle: () => const CustomAlertDialog(text: 'Idling...'),
            loading: () => const CustomAlertDialog(text: 'Signing in...'),
            data: (_) {
              return const CustomAlertDialog(text: 'Initializing data...');
            },
            done: () {
              Navigator.pop(context);
              return const SizedBox.shrink();
            },
            error: (e) => CustomAlertDialog(title: Text('Log in failed', style: theme.textTheme.titleMedium!.copyWith(color: theme.indicatorColor)), text: NetworkExceptions.getErrorMessage(e), isError: true),
          ),
        ),
      );
    }
  }
}
