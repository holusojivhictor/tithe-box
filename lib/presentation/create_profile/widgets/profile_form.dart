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
import 'package:tithe_box/presentation/shared/dropdown/custom_full_dropdown.dart';
import 'package:tithe_box/presentation/shared/row_text.dart';
import 'package:tithe_box/theme.dart';

class ProfileForm extends StatefulWidget {
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  const ProfileForm({
    Key? key,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  }) : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController occupationController = TextEditingController();
  late TextEditingController cityController = TextEditingController();
  late UserProfileBloc _userProfileBloc;
  String selectedCountryValue = 'Nigeria';
  bool submitted = false;

  String? firstNameErrorText;
  String? lastNameErrorText;
  String? occupationErrorText;
  String? cityErrorText;

  @override
  void didChangeDependencies() {
    _userProfileBloc = Injection.getUserProfileBloc(context.read<SessionBloc>());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _userProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserProfileBloc>(
      create: (ctx) => _userProfileBloc,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            FormFieldWithoutBorder(
              text: "First Name",
              hintText: "e.g Steven",
              textEditingController: firstNameController,
              textInputType: TextInputType.name,
              errorText: firstNameErrorText,
              isSubmitted: submitted,
              onChanged: (_) => setState(() {}),
              validator: (value) {
                if (value!.isEmpty) {
                  return kFirstNameNullError;
                }
                return null;
              },
            ),
            FormFieldWithoutBorder(
              text: "Last Name",
              hintText: "e.g Peterson",
              textEditingController: lastNameController,
              textInputType: TextInputType.name,
              errorText: lastNameErrorText,
              isSubmitted: submitted,
              onChanged: (_) => setState(() {}),
              validator: (value) {
                if (value!.isEmpty) {
                  return kLastNameNullError;
                }
                return null;
              },
            ),
            FormFieldWithoutBorder(
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
            FormFieldWithoutBorder(
              text: "City",
              hintText: "e.g Lagos",
              textEditingController: cityController,
              textInputType: TextInputType.name,
              errorText: cityErrorText,
              isSubmitted: submitted,
              onChanged: (_) => setState(() {}),
              validator: (value) {
                if (value!.isEmpty) {
                  return cityNullError;
                }
                return null;
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  padding: Styles.edgeInsetHorizontal10,
                  child: const RowText(text: 'Country'),
                ),
                CustomFullDropdownButton<String>(
                  margin: Styles.formFieldMargin,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  title: 'Country',
                  currentValue: selectedCountryValue,
                  items: countries.map((e) => e["name"]!).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCountryValue = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15),
              child: DefaultButton(
                isPrimary: true,
                text: 'Sign Up',
                onPressed: () => _completeProfile(context),
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
      ),
    );
  }

  Future<void> _completeProfile(BuildContext context) async {
    final theme = Theme.of(context);
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _userProfileBloc.add(UserProfileEvent.createProfile(emailAddress: widget.email, firstName: firstNameController.text, lastName: lastNameController.text, occupation: occupationController.text, city: cityController.text, country: selectedCountryValue, phoneNumber: widget.phoneNumber, password: widget.password, passwordConfirmation: widget.confirmPassword));

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => BlocBuilder<UserProfileBloc, ResultState>(
          bloc: _userProfileBloc,
          builder: (ctx, state) => state.when(
            idle: () => const CustomAlertDialog(text: 'Idling...'),
            loading: () => const CustomAlertDialog(text: 'Creating account...'),
            data: (_) {
              return const CustomAlertDialog(text: 'Setting up user...');
            },
            done: () {
              Navigator.pop(context);
              return const SizedBox.shrink();
            },
            error: (e) => CustomAlertDialog(title: Text('Account creation failed', style: theme.textTheme.titleMedium!.copyWith(color: theme.indicatorColor)), text: NetworkExceptions.getErrorMessage(e), isError: true),
          ),
        ),
      );
    }
  }
}
