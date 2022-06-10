import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class DangerButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const DangerButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: AppColor.redColor,
        elevation: 3,
        textStyle: GoogleFonts.montserrat(
          fontSize: 14.sp,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          height: 1.219,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 14.r),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColor.darkRedColor, width: 1),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text(text),
    );
  }
}
