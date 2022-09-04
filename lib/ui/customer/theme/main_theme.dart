import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData themeData = ThemeData(
  primaryColor: Color(0xFFFFFFFF),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Color(0xFF9D521E),
    onSecondary: Color(0xFFC99542),
  ),
  textTheme: TextTheme(
    headline1: GoogleFonts.poppins(
      fontSize: 93,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: Color(0xFF621C0D),
    ),
    headline2: GoogleFonts.poppins(
      fontSize: 58,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: Color(0xFF621C0D),
    ),
    headline3: GoogleFonts.poppins(
      fontSize: 46,
      fontWeight: FontWeight.w400,
      color: Color(0xFF621C0D),
    ),
    headline4: GoogleFonts.poppins(
      fontSize: 33,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Color(0xFF621C0D),
    ),
    headline5: GoogleFonts.poppins(
      fontSize: 23,
      fontWeight: FontWeight.w400,
      color: Color(0xFF621C0D),
    ),
    headline6: GoogleFonts.poppins(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Color(0xFF621C0D),
    ),
    subtitle1: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: Color(0xFF9D521E),
    ),
    subtitle2: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Color(0xFF9D521E),
    ),
    bodyText1: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xFF026242),
    ),
    bodyText2: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Color(0xFF026242),
    ),
    button: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: Color(0xFFFFFFFF),
    ),
    caption: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: Color(0xFF026242),
    ),
    overline: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: Color(0xFF9D521E),
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xFF9D521E)),
  appBarTheme: AppBarTheme(color: Color(0xFFFFFFFF)),
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  cardColor: Color(0xFFFAFAFA),
);
