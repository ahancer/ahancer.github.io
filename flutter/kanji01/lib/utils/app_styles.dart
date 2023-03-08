import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles{
  static Color colorBlack = const Color(0xFF000000);
  static Color colorGrey = const Color(0xFFBFBFBF);
  static Color colorWhite = const Color(0xFFFFFFFF);
  static Color colorYellow = const Color(0xFFFEDA00);
  static Color colorPink = const Color(0xFFFF6196);
  static Color colorPinkLight = const Color(0xFFFFA0C0);
  static Color colorRed = const Color(0xFFd2bdd6);
  static Color colorGreen = const Color(0xFF00A9A1);
  static Color colorBlue = const Color(0xFF025BFF);

  static TextStyle fontKanjiBig = GoogleFonts.mochiyPopOne(fontSize: 148, fontWeight: FontWeight.w400, color: Styles.colorBlack);
  static TextStyle fontKanjiSmall = GoogleFonts.mochiyPopOne(fontSize: 40, fontWeight: FontWeight.w400, color: Styles.colorBlack);

  static TextStyle fontH1 = GoogleFonts.poppins(fontSize: 56, fontWeight: FontWeight.w700, color: Styles.colorBlack, height: 1.0,);
  static TextStyle fontH2 = GoogleFonts.poppins(fontSize: 40, fontWeight: FontWeight.w700, color: Styles.colorBlack, height: 1.0,);
  static TextStyle fontH3 = GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w700, color: Styles.colorBlack, height: 1.0,);
  static TextStyle fontBody = GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, height: 1.5,);
  static TextStyle fontBodyBold = GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, height: 1.5,);
  static TextStyle fontSmall = GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5,);

}