import 'package:tithe_box/domain/models/models.dart';

const kPadding = 10.0;
const kAnimationDuration = Duration(milliseconds: 200);

class Data {
  static List<StartVerseModel> startVerseData = [
    StartVerseModel(
      verse: 'Leviticus 27:30',
      reading: 'A tithe of everything from the land, whether grain from the soil or fruit from the trees, belongs to the Lord: it is holy to the Lord.',
    ),
    StartVerseModel(
      verse: 'Malachi 3:10',
      reading: 'For sure, I tell you, anyone who gives a cup of cold water to one of these little ones because he follows Me, will not lose his reward.',
    ),
    StartVerseModel(
      verse: 'Deuteronomy 8:18',
      reading: 'But remember the Lord your God. For it is He who is giving you power to become rich.',
    ),
  ];
}

const String defaultText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.';

/// Validator strings
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp phoneNumberValidatorRegExp = RegExp(r"^[0-9]");
const String kEmailNullError = "Please enter your email.";
const String kFullNameNullError = "Please enter your full name.";
const String kOccupationNullError = "Please enter your current occupation.";
const String kNameOfChurchNullError = "Please enter your place of worship";
const String kFirstNameNullError = "Please enter your first name.";
const String kAddressNullError = "Please enter your address.";
const String kLastNameNullError = "Please enter your last name.";
const String kPhoneNumberNullError = "Please enter your phone number.";
const String kInvalidPhoneNumberError = "Please enter a valid phone number. Signs not necessary.";
const String kInvalidEmailError = "Please enter a valid email.";
const String kPassNullError = "Please enter your password.";
const String kPassMatchNullError = "Password does not match.";
const String kShortPassError = "Password should be longer than 8 characters.";
const String kConfirmPassNullError = "Please confirm your password.";