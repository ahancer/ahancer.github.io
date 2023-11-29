import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
//--------Color Style---------//
//-BG-//
  static Color bgPrimary = const Color(0xff38B2AC);
  static Color bgWhite = const Color(0xffffffff);
  static Color bgGray0 = const Color(0xffF2F7F7);
  static Color bgGray1 = const Color(0xffEAF1F1);
  static Color bgGray2 = const Color(0xffDFE7E7);

//-BG BTN-//
  static Color bgAccent = const Color(0xff69D2CC);
  static Color bgEasyBTN = const Color(0xff38B2AC);
  static Color bgHardBTN = const Color(0xffDB5555);

//-Line-//
  static Color lineGray = const Color(0xffDFE7E7);
  static Color linePrimary = const Color(0xff69D2CC);

//-Text-//
  static Color textColorPrimary = const Color(0xff191C1C);
  static Color textColorSecondary = const Color(0xffA4ADAD);
  static Color textColorWhite = const Color(0xffffffff);
  static Color textColorGreen = const Color(0xff38B2AC);
  static Color textColorPink = const Color(0xffF3397C);

//--------Font Style---------//
//-EN-//
//Header
  static TextStyle H1 = GoogleFonts.nunito(
      fontSize: 36, fontWeight: FontWeight.bold, height: 1.1);
  static TextStyle H2 = GoogleFonts.nunito(
      fontSize: 24, fontWeight: FontWeight.bold, height: 1.16);

//button
  static TextStyle textButton = GoogleFonts.nunito(
      fontSize: 18, fontWeight: FontWeight.bold, height: 1.5);

//body
  static TextStyle title = GoogleFonts.nunito(
      fontSize: 22, fontWeight: FontWeight.w400, height: 1.18);
  static TextStyle subTitle = GoogleFonts.nunito(
      fontSize: 20, fontWeight: FontWeight.w400, height: 1.2);
  static TextStyle body = GoogleFonts.nunito(
      fontSize: 16, fontWeight: FontWeight.w400, height: 1.12);
  static TextStyle subBody = GoogleFonts.nunito(
      fontSize: 14, fontWeight: FontWeight.w400, height: 1.14);
  static TextStyle small = GoogleFonts.nunito(
      fontSize: 12, fontWeight: FontWeight.w400, height: 1.16);
  static TextStyle link = GoogleFonts.nunito(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline,
      height: 1.16);

//----JP----//
  static TextStyle jpLarge = GoogleFonts.mukta(
      fontSize: 128, fontWeight: FontWeight.normal, height: 1.1);
  static TextStyle jpMedium = GoogleFonts.mukta(
      fontSize: 64, fontWeight: FontWeight.normal, height: 1.25);
  static TextStyle jpSmall = GoogleFonts.mukta(
      fontSize: 32, fontWeight: FontWeight.normal, height: 1.3);
}

//--------App Color---------//
class AppColors {
  static MaterialColor primaryColor =
      MaterialColor(0xff38B2AC, const <int, Color>{
    50: const Color(0xff38b2ac),
    100: const Color(0xff32a09b),
    200: const Color(0xff2d8e8a),
    300: const Color(0xff277d78),
    400: const Color(0xff226b67),
    500: const Color(0xff1c5956),
    600: const Color(0xff164745),
    700: const Color(0xff113534),
    800: const Color(0xff0b2422),
    900: const Color(0xff061211)
  });
}
