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
  static Color bgEasyBTN = const Color(0xffF580AA);
  static Color bgHardBTN = const Color(0xffDB557D);

//-Line-//
  static Color lineGray = const Color(0xffDFE7E7);
  static Color linePrimary = const Color(0xff69D2CC);

//-Text-//
  static Color textPrimary = const Color(0xff191C1C);
  static Color textSecondary = const Color(0xffA4ADAD);
  static Color textWhite = const Color(0xffffffff);
  static Color textHighlight = const Color(0xff38B2AC);
  static Color textPink = const Color(0xffF3397C);

//--------Font Style---------//
//-EN-//
//Header
  static TextStyle H1 =
      GoogleFonts.nunito(fontSize: 36, fontWeight: FontWeight.bold);
  static TextStyle H2 =
      GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.bold);

//button
  static TextStyle button =
      GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold);

//body
  static TextStyle title =
      GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w400);
  static TextStyle subTitle =
      GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w400);
  static TextStyle body =
      GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle subBody =
      GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400);
  static TextStyle small =
      GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w400);
  static TextStyle link = GoogleFonts.nunito(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline);

//----JP----//
  static TextStyle jpLarge =
      GoogleFonts.mukta(fontSize: 128, fontWeight: FontWeight.normal);
  static TextStyle jpMedium =
      GoogleFonts.mukta(fontSize: 64, fontWeight: FontWeight.normal);
  static TextStyle jpSmall =
      GoogleFonts.mukta(fontSize: 32, fontWeight: FontWeight.normal);
}

//--------App Color---------//
class AppColors {
  static MaterialColor primaryColor =
      MaterialColor(0xff69D2CC, const <int, Color>{
    50: const Color(0xff69d2cc),
    100: const Color(0xff5fbdb8),
    200: const Color(0xff54a8a3),
    300: const Color(0xff4a938f),
    400: const Color(0xff3f7e7a),
    500: const Color(0xff356966),
    600: const Color(0xff2a5452),
    700: const Color(0xff1f3f3d),
    800: const Color(0xff152a29),
    900: const Color(0xff0a1514)
  });
}
