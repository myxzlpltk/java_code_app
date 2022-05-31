import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class VariantChip extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final bool isSelected;

  const VariantChip({
    Key? key,
    required this.text,
    this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.w),
            color: isSelected ? blueColor : Colors.white,
            border: Border.all(color: blueColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: isSelected ? Colors.white : darkColor2),
              ),
              if (isSelected) ...[
                SizedBox(width: 5.w),
                Icon(
                  Icons.check,
                  size: 18.h,
                  color: Colors.white,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
