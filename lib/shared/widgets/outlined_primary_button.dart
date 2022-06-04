import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class OutlinedPrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final VisualDensity? visualDensity;
  final bool isCompact;

  const OutlinedPrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.visualDensity,
  })  : isCompact = false,
        super(key: key);

  const OutlinedPrimaryButton.compact({
    Key? key,
    required this.text,
    this.onPressed,
  })  : visualDensity = VisualDensity.compact,
        isCompact = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        visualDensity: visualDensity,
        primary: Colors.white,
        elevation: 3,
        textStyle: GoogleFonts.montserrat(
          fontSize: isCompact ? 10.sp : 14.sp,
          fontWeight: FontWeight.w800,
          height: 1.219,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 18.r : 24.r,
          vertical: isCompact ? 0.r : 14.r,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: darkBlueColor, width: 1),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text(text, style: const TextStyle(color: blueColor)),
    );
  }
}
