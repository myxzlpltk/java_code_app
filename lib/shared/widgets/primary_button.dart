import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: blueColor,
        elevation: 4,
        textStyle: Theme.of(context).textTheme.button,
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 14.h,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: darkBlueColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text(text),
    );
  }
}