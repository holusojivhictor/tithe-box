import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kDark = Colors.black;
Color kWhite = Colors.white;

class Styles {
  static const edgeInsetAll16 = EdgeInsets.all(16);
  static const edgeInsetAll10 = EdgeInsets.all(10);
  static const edgeInsetAll7 = EdgeInsets.all(7);
  static const edgeInsetAll5 = EdgeInsets.all(5);
  static const edgeInsetAll3 = EdgeInsets.all(3);
  static const edgeInsetAll0 = EdgeInsets.zero;
  static const edgeInsetHorizontal16 = EdgeInsets.symmetric(horizontal: 16);
  static const edgeInsetVertical5 = EdgeInsets.symmetric(vertical: 5);
  static const edgeInsetHorizontal5 = EdgeInsets.symmetric(horizontal: 5);
  static const edgeInsetVertical16 = EdgeInsets.symmetric(vertical: 16);
  static const edgeInsetVertical10 = EdgeInsets.symmetric(vertical: 10);
  static const edgeInsetHorizontal10 = EdgeInsets.symmetric(horizontal: 10);
  static const edgeInsetHorizontal10Vertical5 = EdgeInsets.symmetric(horizontal: 10, vertical: 5);
  static const edgeInsetHorizontal16Vertical5 = EdgeInsets.symmetric(horizontal: 16, vertical: 5);
  static const edgeInsetSymmetric10 = EdgeInsets.symmetric(horizontal: 10, vertical: 10);
  static const edgeInsetSymmetric8 = EdgeInsets.symmetric(horizontal: 8, vertical: 8);
  static const edgeInsetSymmetric5 = EdgeInsets.symmetric(horizontal: 5, vertical: 5);

  static const homeContentPadding = EdgeInsets.symmetric(horizontal: 15, vertical: 10);

  static const edgeInsetHorizontal16Top10 = EdgeInsets.only(left: 16, right: 16, top: 10);

  static const alertContentPadding = EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 5);

  static const altAlertContentPadding = EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12);

  static const pickerAlertContentPadding = EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 6);

  static const signAlertContentPadding = EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12);

  static const double smallButtonSplashRadius = 18;

  static const formFieldMargin = EdgeInsets.symmetric(vertical: 10, horizontal: 12);

  static const modalBottomSheetShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
    ),
  );

  static const modalBottomSheetContainerMargin = EdgeInsets.only(left: 10, right: 10, bottom: 10);
  static const modalBottomSheetContainerPadding = EdgeInsets.only(left: 10, right: 10, top: 10);

  static double getIconSizeForItemPopupMenuFilter(bool forDefaultIcons) {
    return forDefaultIcons ? 24 : 18;
  }

  static const double mediumButtonSplashRadius = 25;

  static const expandedBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(15),
    topRight: Radius.circular(15),
  );

  static const cardItemDetailShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      topLeft: Radius.circular(20),
    ),
  );

  static const formFieldBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );

  static const searchFieldBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );

  static const formFieldPadding = EdgeInsets.symmetric(horizontal: 14, vertical: 18);

  static const altFormFieldPadding = EdgeInsets.symmetric(horizontal: 14, vertical: 15);

  static const editFormFieldPadding = EdgeInsets.symmetric(horizontal: 0, vertical: 7);

  static const double materialCardHeight = 270;
  static const double materialCardWidth = 220;
  static const double homeCardHeight = 160;
  static const double homeCardWidth = 140;

  static const double cardThreeElevation = 3;
  static const double cardTenElevation = 10;

  static const circularBorderRadius5 = BorderRadius.all(Radius.circular(5));

  static const circularBorderRadius7 = BorderRadius.all(Radius.circular(7));

  static const mainCardBorderRadius = BorderRadius.all(Radius.circular(5));

  static const homeCardBorderRadius = BorderRadius.all(Radius.circular(10));

  static const settingsCardBorderRadius = BorderRadius.all(Radius.circular(5));

  static const alertDialogBorderRadius = BorderRadius.all(Radius.circular(5));

  static const circleTapBorderRadius = BorderRadius.all(Radius.circular(20));

  static const RoundedRectangleBorder mainCardShape = RoundedRectangleBorder(borderRadius: mainCardBorderRadius);

  static const RoundedRectangleBorder settingsCardShape = RoundedRectangleBorder(borderRadius: settingsCardBorderRadius);

  static const RoundedRectangleBorder alertDialogShape = RoundedRectangleBorder(borderRadius: alertDialogBorderRadius);

  static const RoundedRectangleBorder dialogShape = RoundedRectangleBorder(borderRadius: alertDialogBorderRadius);
}

Color kPrimary = const Color(0xFFDF4903);
Color kSecondary = const Color(0xFF505050);
Color kGrey = const Color(0xFFEFEFEF);

class TitheBoxTheme {
  static Typography textTypography = Typography.material2021();

  static TextTheme darkText = ThemeData.light().textTheme.apply(bodyColor: Colors.black, displayColor: Colors.black);

  static TextTheme lightText = ThemeData.dark().textTheme.apply(bodyColor: Colors.black, displayColor: Colors.black);

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(textStyle: darkText.displayLarge),
    displayMedium: GoogleFonts.poppins(textStyle: darkText.displayMedium),
    displaySmall: GoogleFonts.poppins(textStyle: darkText.displaySmall),
    headlineLarge: GoogleFonts.poppins(textStyle: darkText.headlineLarge),
    headlineMedium: GoogleFonts.poppins(textStyle: darkText.headlineMedium),
    headlineSmall: GoogleFonts.poppins(textStyle: darkText.headlineSmall),
    titleLarge: GoogleFonts.poppins(textStyle: darkText.titleLarge),
    titleMedium: GoogleFonts.poppins(textStyle: darkText.titleMedium),
    titleSmall: GoogleFonts.poppins(textStyle: darkText.titleSmall),
    bodyLarge: GoogleFonts.poppins(textStyle: darkText.bodyLarge),
    bodyMedium: GoogleFonts.poppins(textStyle: darkText.bodyMedium),
    bodySmall: GoogleFonts.poppins(textStyle: darkText.bodySmall),
    labelLarge: GoogleFonts.poppins(textStyle: darkText.labelLarge),
    labelMedium: GoogleFonts.poppins(textStyle: darkText.labelMedium),
    labelSmall: GoogleFonts.poppins(textStyle: darkText.labelSmall),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(textStyle: lightText.displayLarge),
    displayMedium: GoogleFonts.poppins(textStyle: lightText.displayMedium),
    displaySmall: GoogleFonts.poppins(textStyle: lightText.displaySmall),
    headlineLarge: GoogleFonts.poppins(textStyle: lightText.headlineLarge),
    headlineMedium: GoogleFonts.poppins(textStyle: lightText.headlineMedium),
    headlineSmall: GoogleFonts.poppins(textStyle: lightText.headlineSmall),
    titleLarge: GoogleFonts.poppins(textStyle: lightText.titleLarge),
    titleMedium: GoogleFonts.poppins(textStyle: lightText.titleMedium),
    titleSmall: GoogleFonts.poppins(textStyle: lightText.titleSmall),
    bodyLarge: GoogleFonts.poppins(textStyle: lightText.bodyLarge),
    bodyMedium: GoogleFonts.poppins(textStyle: lightText.bodyMedium),
    bodySmall: GoogleFonts.poppins(textStyle: lightText.bodySmall),
    labelLarge: GoogleFonts.poppins(textStyle: lightText.labelLarge),
    labelMedium: GoogleFonts.poppins(textStyle: lightText.labelMedium),
    labelSmall: GoogleFonts.poppins(textStyle: lightText.labelSmall),
  );
}

@immutable
class CustomTheme extends ThemeExtension<CustomTheme> {
  final Color? formBorder;
  final Color? categoryOverlay;
  final Color? altTextColor;
  final Color? baseTextColor;

  const CustomTheme({
    required this.formBorder,
    required this.categoryOverlay,
    required this.altTextColor,
    required this.baseTextColor,
  });

  @override
  CustomTheme copyWith({Color? formBorder, Color? categoryOverlay, Color? altTextColor, Color? baseTextColor}) {
    return CustomTheme(
      formBorder: formBorder ?? this.formBorder,
      categoryOverlay: categoryOverlay ?? this.categoryOverlay,
      altTextColor: altTextColor ?? this.altTextColor,
      baseTextColor: baseTextColor ?? this.baseTextColor,
    );
  }

  @override
  CustomTheme lerp(ThemeExtension<CustomTheme>? other, double t) {
    if (other is! CustomTheme) {
      return this;
    }

    return CustomTheme(
      formBorder: Color.lerp(formBorder, other.formBorder, t),
      categoryOverlay: Color.lerp(categoryOverlay, other.categoryOverlay, t),
      altTextColor: Color.lerp(altTextColor, other.altTextColor, t),
      baseTextColor: Color.lerp(baseTextColor, other.baseTextColor, t),
    );
  }
}
