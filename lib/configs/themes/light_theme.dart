import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/configs/themes/colors.dart';

final lightTheme = ThemeData(
  fontFamily: GoogleFonts.montserrat().fontFamily,
  textTheme: TextTheme(
    headline1: GoogleFonts.montserrat(
      fontSize: 96.sp,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: darkColor,
    ),
    headline2: GoogleFonts.montserrat(
      fontSize: 60.sp,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: darkColor,
    ),
    headline3: GoogleFonts.montserrat(
      fontSize: 48.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: darkColor,
    ),
    headline4: GoogleFonts.montserrat(
      fontSize: 35.sp,
      fontWeight: FontWeight.w900,
      letterSpacing: 0.25,
      color: darkColor,
    ),
    headline5: GoogleFonts.montserrat(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      color: darkColor,
    ),
    headline6: GoogleFonts.montserrat(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.15,
      color: darkColor,
    ),
    subtitle1: GoogleFonts.montserrat(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: darkColor,
    ),
    subtitle2: GoogleFonts.montserrat(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1,
      color: darkColor,
    ),
    bodyText1: GoogleFonts.montserrat(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: darkColor,
    ),
    bodyText2: GoogleFonts.montserrat(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: darkColor,
    ),
    button: GoogleFonts.montserrat(
      fontSize: 14.sp,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.25,
      color: Colors.white,
    ),
    caption: GoogleFonts.montserrat(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: darkColor,
    ),
  )
);