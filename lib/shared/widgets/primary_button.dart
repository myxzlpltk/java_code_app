import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final VisualDensity? visualDensity;
  final bool isCompact;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.visualDensity,
  })  : isCompact = false,
        super(key: key);

  const PrimaryButton.compact({
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
        primary: blueColor,
        elevation: 3,
        textStyle: GoogleFonts.montserrat(
          fontSize: isCompact ? 10.sp : 14.sp,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          height: 1.219,
        ),
        tapTargetSize: isCompact ? MaterialTapTargetSize.shrinkWrap : null,
        minimumSize: isCompact ? Size(100.r, 40.r) : null,
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 18.r : 24.r,
          vertical: isCompact ? 0.r : 14.r,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: darkBlueColor, width: 1),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text(text),
    );
  }
}
