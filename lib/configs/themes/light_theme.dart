import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/configs/themes/colors.dart';

final lightTheme = ThemeData(
  primaryColor: blueColor,
  fontFamily: GoogleFonts.montserrat().fontFamily,
  focusColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.white,
  textTheme: GoogleFonts.montserratTextTheme().copyWith(
    displayLarge: GoogleFonts.montserrat(
      fontSize: 35.sp,
      fontWeight: FontWeight.w600,
      color: darkColor,
      height: 1.219,
    ),
    displayMedium: GoogleFonts.montserrat(
      fontSize: 30.sp,
      fontWeight: FontWeight.w600,
      color: darkColor,
      height: 1.219,
    ),
    displaySmall: GoogleFonts.montserrat(
      fontSize: 25.sp,
      fontWeight: FontWeight.w600,
      color: darkColor,
      height: 1.219,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: darkColor,
      height: 1.219,
    ),
    headlineSmall: GoogleFonts.montserrat(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: darkColor,
      height: 1.219,
    ),
    titleLarge: GoogleFonts.montserrat(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: darkColor2,
      height: 1.219,
    ),
    titleMedium: GoogleFonts.montserrat(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: darkColor2,
      height: 1.219,
    ),
    titleSmall: GoogleFonts.montserrat(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: darkColor2,
      height: 1.219,
    ),
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      color: darkColor,
      height: 1.219,
    ),
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: darkColor,
      height: 1.219,
    ),
    bodySmall: GoogleFonts.montserrat(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: darkColor,
      height: 1.219,
    ),
    labelLarge: GoogleFonts.montserrat(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: darkColor2,
      height: 1.219,
    ),
    labelMedium: GoogleFonts.montserrat(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: darkColor2,
      height: 1.219,
    ),
    labelSmall: GoogleFonts.montserrat(
      fontSize: 10.sp,
      fontWeight: FontWeight.w600,
      color: darkColor2,
      height: 1.219,
    ),
  ),
);
