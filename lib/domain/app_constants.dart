import 'dart:io';

import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/models/models.dart';

const kPadding = 10.0;
const kAnimationDuration = Duration(milliseconds: 200);

const baseUrl = 'https://tithe22.herokuapp.com/api/v1/users';

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

  static List<BannerData> homeBannerData = [
    BannerData(
      header: 'Total Income\n\n',
      info: 'N1000.00',
    ),
    BannerData(
      header: 'Total Income\n\n',
      info: 'N1000.00',
    ),
    BannerData(
      header: 'Total Income\n\n',
      info: 'N1000.00',
    ),
  ];
}

/// SharedPreferences operations
Future<void> saveString({required String key, required String value}) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String> getSavedString({required String key}) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getString(key);

  return value ?? '';
}

/// Get currency symbol from platform locale
String getCurrency() {
  var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
  return format.currencySymbol;
}

/// Validator strings
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp phoneNumberValidatorRegExp = RegExp(r"^[0-9]");
const String kEmailNullError = "Please enter your email.";
const String kFullNameNullError = "Please enter your full name.";
const String kOccupationNullError = "Please enter your current occupation.";
const String kNameOfChurchNullError = "Please enter your place of worship";
const String cityNullError = "Please enter your city of residence";
const String kFirstNameNullError = "Please enter your first name.";
const String kAddressNullError = "Please enter your address.";
const String kLastNameNullError = "Please enter your last name.";
const String kPhoneNumberNullError = "Please enter your phone number.";
const String kShortPhoneNumberError = "Phone number must have at least 11 digits.";
const String kInvalidPhoneNumberError = "Please enter a valid phone number. Signs not necessary.";
const String kInvalidEmailError = "Please enter a valid email.";
const String kPassNullError = "Please enter your password.";
const String kPassMatchNullError = "Password does not match.";
const String kShortPassError = "Password should be longer than 8 characters.";
const String kConfirmPassNullError = "Please confirm your password.";

/// Keys
const String tokenStorageKey = 'TokenStorageKey';
const String userIdStorageKey = 'UserIdStorageKey';

/// Languages map
const languagesMap = {
  AppLanguageType.english: LanguageModel('en', 'US'),
};

/// Countries map list
List<Map<String, String>> countries = [
  {"name": "Afghanistan", "code": "AF"},
  {"name": "land Islands", "code": "AX"},
  {"name": "Albania", "code": "AL"},
  {"name": "Algeria", "code": "DZ"},
  {"name": "American Samoa", "code": "AS"},
  {"name": "Andorra", "code": "AD"},
  {"name": "Angola", "code": "AO"},
  {"name": "Anguilla", "code": "AI"},
  {"name": "Antarctica", "code": "AQ"},
  {"name": "Antigua and Barbuda", "code": "AG"},
  {"name": "Argentina", "code": "AR"},
  {"name": "Armenia", "code": "AM"},
  {"name": "Aruba", "code": "AW"},
  {"name": "Australia", "code": "AU"},
  {"name": "Austria", "code": "AT"},
  {"name": "Azerbaijan", "code": "AZ"},
  {"name": "Bahamas", "code": "BS"},
  {"name": "Bahrain", "code": "BH"},
  {"name": "Bangladesh", "code": "BD"},
  {"name": "Barbados", "code": "BB"},
  {"name": "Belarus", "code": "BY"},
  {"name": "Belgium", "code": "BE"},
  {"name": "Belize", "code": "BZ"},
  {"name": "Benin", "code": "BJ"},
  {"name": "Bermuda", "code": "BM"},
  {"name": "Bhutan", "code": "BT"},
  {"name": "Bolivia", "code": "BO"},
  {"name": "Bosnia and Herzegovina", "code": "BA"},
  {"name": "Botswana", "code": "BW"},
  {"name": "Bouvet Island", "code": "BV"},
  {"name": "Brazil", "code": "BR"},
  {"name": "British Indian Ocean Territory", "code": "IO"},
  {"name": "Brunei Darussalam", "code": "BN"},
  {"name": "Bulgaria", "code": "BG"},
  {"name": "Burkina Faso", "code": "BF"},
  {"name": "Burundi", "code": "BI"},
  {"name": "Cambodia", "code": "KH"},
  {"name": "Cameroon", "code": "CM"},
  {"name": "Canada", "code": "CA"},
  {"name": "Cape Verde", "code": "CV"},
  {"name": "Cayman Islands", "code": "KY"},
  {"name": "Central African Republic", "code": "CF"},
  {"name": "Chad", "code": "TD"},
  {"name": "Chile", "code": "CL"},
  {"name": "China", "code": "CN"},
  {"name": "Christmas Island", "code": "CX"},
  {"name": "Cocos (Keeling) Islands", "code": "CC"},
  {"name": "Colombia", "code": "CO"},
  {"name": "Comoros", "code": "KM"},
  {"name": "Congo", "code": "CG"},
  {"name": "Congo, The Democratic Republic of the", "code": "CD"},
  {"name": "Cook Islands", "code": "CK"},
  {"name": "Costa Rica", "code": "CR"},
  {"name": "Cote D\"Ivoire", "code": "CI"},
  {"name": "Croatia", "code": "HR"},
  {"name": "Cuba", "code": "CU"},
  {"name": "Cyprus", "code": "CY"},
  {"name": "Czech Republic", "code": "CZ"},
  {"name": "Denmark", "code": "DK"},
  {"name": "Djibouti", "code": "DJ"},
  {"name": "Dominica", "code": "DM"},
  {"name": "Dominican Republic", "code": "DO"},
  {"name": "Ecuador", "code": "EC"},
  {"name": "Egypt", "code": "EG"},
  {"name": "El Salvador", "code": "SV"},
  {"name": "Equatorial Guinea", "code": "GQ"},
  {"name": "Eritrea", "code": "ER"},
  {"name": "Estonia", "code": "EE"},
  {"name": "Ethiopia", "code": "ET"},
  {"name": "Falkland Islands (Malvinas)", "code": "FK"},
  {"name": "Faroe Islands", "code": "FO"},
  {"name": "Fiji", "code": "FJ"},
  {"name": "Finland", "code": "FI"},
  {"name": "France", "code": "FR"},
  {"name": "French Guiana", "code": "GF"},
  {"name": "French Polynesia", "code": "PF"},
  {"name": "French Southern Territories", "code": "TF"},
  {"name": "Gabon", "code": "GA"},
  {"name": "Gambia", "code": "GM"},
  {"name": "Georgia", "code": "GE"},
  {"name": "Germany", "code": "DE"},
  {"name": "Ghana", "code": "GH"},
  {"name": "Gibraltar", "code": "GI"},
  {"name": "Greece", "code": "GR"},
  {"name": "Greenland", "code": "GL"},
  {"name": "Grenada", "code": "GD"},
  {"name": "Guadeloupe", "code": "GP"},
  {"name": "Guam", "code": "GU"},
  {"name": "Guatemala", "code": "GT"},
  {"name": "Guernsey", "code": "GG"},
  {"name": "Guinea", "code": "GN"},
  {"name": "Guinea-Bissau", "code": "GW"},
  {"name": "Guyana", "code": "GY"},
  {"name": "Haiti", "code": "HT"},
  {"name": "Heard Island and Mcdonald Islands", "code": "HM"},
  {"name": "Holy See (Vatican City State)", "code": "VA"},
  {"name": "Honduras", "code": "HN"},
  {"name": "Hong Kong", "code": "HK"},
  {"name": "Hungary", "code": "HU"},
  {"name": "Iceland", "code": "IS"},
  {"name": "India", "code": "IN"},
  {"name": "Indonesia", "code": "ID"},
  {"name": "Iran, Islamic Republic Of", "code": "IR"},
  {"name": "Iraq", "code": "IQ"},
  {"name": "Ireland", "code": "IE"},
  {"name": "Isle of Man", "code": "IM"},
  {"name": "Israel", "code": "IL"},
  {"name": "Italy", "code": "IT"},
  {"name": "Jamaica", "code": "JM"},
  {"name": "Japan", "code": "JP"},
  {"name": "Jersey", "code": "JE"},
  {"name": "Jordan", "code": "JO"},
  {"name": "Kazakhstan", "code": "KZ"},
  {"name": "Kenya", "code": "KE"},
  {"name": "Kiribati", "code": "KI"},
  {"name": "Korea, Democratic People's Republic of", "code": "KP"},
  {"name": "Korea, Republic of", "code": "KR"},
  {"name": "Kuwait", "code": "KW"},
  {"name": "Kyrgyzstan", "code": "KG"},
  {"name": "Lao People'S Democratic Republic", "code": "LA"},
  {"name": "Latvia", "code": "LV"},
  {"name": "Lebanon", "code": "LB"},
  {"name": "Lesotho", "code": "LS"},
  {"name": "Liberia", "code": "LR"},
  {"name": "Libyan Arab Jamahiriya", "code": "LY"},
  {"name": "Liechtenstein", "code": "LI"},
  {"name": "Lithuania", "code": "LT"},
  {"name": "Luxembourg", "code": "LU"},
  {"name": "Macao", "code": "MO"},
  {"name": "Macedonia, The Former Yugoslav Republic of", "code": "MK"},
  {"name": "Madagascar", "code": "MG"},
  {"name": "Malawi", "code": "MW"},
  {"name": "Malaysia", "code": "MY"},
  {"name": "Maldives", "code": "MV"},
  {"name": "Mali", "code": "ML"},
  {"name": "Malta", "code": "MT"},
  {"name": "Marshall Islands", "code": "MH"},
  {"name": "Martinique", "code": "MQ"},
  {"name": "Mauritania", "code": "MR"},
  {"name": "Mauritius", "code": "MU"},
  {"name": "Mayotte", "code": "YT"},
  {"name": "Mexico", "code": "MX"},
  {"name": "Micronesia, Federated States of", "code": "FM"},
  {"name": "Moldova, Republic of", "code": "MD"},
  {"name": "Monaco", "code": "MC"},
  {"name": "Mongolia", "code": "MN"},
  {"name": "Montenegro", "code": "ME"},
  {"name": "Montserrat", "code": "MS"},
  {"name": "Morocco", "code": "MA"},
  {"name": "Mozambique", "code": "MZ"},
  {"name": "Myanmar", "code": "MM"},
  {"name": "Namibia", "code": "NA"},
  {"name": "Nauru", "code": "NR"},
  {"name": "Nepal", "code": "NP"},
  {"name": "Netherlands", "code": "NL"},
  {"name": "Netherlands Antilles", "code": "AN"},
  {"name": "New Caledonia", "code": "NC"},
  {"name": "New Zealand", "code": "NZ"},
  {"name": "Nicaragua", "code": "NI"},
  {"name": "Niger", "code": "NE"},
  {"name": "Nigeria", "code": "NG"},
  {"name": "Niue", "code": "NU"},
  {"name": "Norfolk Island", "code": "NF"},
  {"name": "Northern Mariana Islands", "code": "MP"},
  {"name": "Norway", "code": "NO"},
  {"name": "Oman", "code": "OM"},
  {"name": "Pakistan", "code": "PK"},
  {"name": "Palau", "code": "PW"},
  {"name": "Palestinian Territory, Occupied", "code": "PS"},
  {"name": "Panama", "code": "PA"},
  {"name": "Papua New Guinea", "code": "PG"},
  {"name": "Paraguay", "code": "PY"},
  {"name": "Peru", "code": "PE"},
  {"name": "Philippines", "code": "PH"},
  {"name": "Pitcairn", "code": "PN"},
  {"name": "Poland", "code": "PL"},
  {"name": "Portugal", "code": "PT"},
  {"name": "Puerto Rico", "code": "PR"},
  {"name": "Qatar", "code": "QA"},
  {"name": "Reunion", "code": "RE"},
  {"name": "Romania", "code": "RO"},
  {"name": "Russian Federation", "code": "RU"},
  {"name": "RWANDA", "code": "RW"},
  {"name": "Saint Helena", "code": "SH"},
  {"name": "Saint Kitts and Nevis", "code": "KN"},
  {"name": "Saint Lucia", "code": "LC"},
  {"name": "Saint Pierre and Miquelon", "code": "PM"},
  {"name": "Saint Vincent and the Grenadines", "code": "VC"},
  {"name": "Samoa", "code": "WS"},
  {"name": "San Marino", "code": "SM"},
  {"name": "Sao Tome and Principe", "code": "ST"},
  {"name": "Saudi Arabia", "code": "SA"},
  {"name": "Senegal", "code": "SN"},
  {"name": "Serbia", "code": "RS"},
  {"name": "Seychelles", "code": "SC"},
  {"name": "Sierra Leone", "code": "SL"},
  {"name": "Singapore", "code": "SG"},
  {"name": "Slovakia", "code": "SK"},
  {"name": "Slovenia", "code": "SI"},
  {"name": "Solomon Islands", "code": "SB"},
  {"name": "Somalia", "code": "SO"},
  {"name": "South Africa", "code": "ZA"},
  {"name": "South Georgia and the South Sandwich Islands", "code": "GS"},
  {"name": "Spain", "code": "ES"},
  {"name": "Sri Lanka", "code": "LK"},
  {"name": "Sudan", "code": "SD"},
  {"name": "Suriname", "code": "SR"},
  {"name": "Svalbard and Jan Mayen", "code": "SJ"},
  {"name": "Swaziland", "code": "SZ"},
  {"name": "Sweden", "code": "SE"},
  {"name": "Switzerland", "code": "CH"},
  {"name": "Syrian Arab Republic", "code": "SY"},
  {"name": "Taiwan, Province of China", "code": "TW"},
  {"name": "Tajikistan", "code": "TJ"},
  {"name": "Tanzania, United Republic of", "code": "TZ"},
  {"name": "Thailand", "code": "TH"},
  {"name": "Timor-Leste", "code": "TL"},
  {"name": "Togo", "code": "TG"},
  {"name": "Tokelau", "code": "TK"},
  {"name": "Tonga", "code": "TO"},
  {"name": "Trinidad and Tobago", "code": "TT"},
  {"name": "Tunisia", "code": "TN"},
  {"name": "Turkey", "code": "TR"},
  {"name": "Turkmenistan", "code": "TM"},
  {"name": "Turks and Caicos Islands", "code": "TC"},
  {"name": "Tuvalu", "code": "TV"},
  {"name": "Uganda", "code": "UG"},
  {"name": "Ukraine", "code": "UA"},
  {"name": "United Arab Emirates", "code": "AE"},
  {"name": "United Kingdom", "code": "GB"},
  {"name": "United States", "code": "US"},
  {"name": "United States Minor Outlying Islands", "code": "UM"},
  {"name": "Uruguay", "code": "UY"},
  {"name": "Uzbekistan", "code": "UZ"},
  {"name": "Vanuatu", "code": "VU"},
  {"name": "Venezuela", "code": "VE"},
  {"name": "Viet Nam", "code": "VN"},
  {"name": "Virgin Islands, British", "code": "VG"},
  {"name": "Virgin Islands, U.S.", "code": "VI"},
  {"name": "Wallis and Futuna", "code": "WF"},
  {"name": "Western Sahara", "code": "EH"},
  {"name": "Yemen", "code": "YE"},
  {"name": "Zambia", "code": "ZM"},
  {"name": "Zimbabwe", "code": "ZW"}
];

const String defaultText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.';