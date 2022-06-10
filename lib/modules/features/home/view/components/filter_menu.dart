import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class FilterMenu extends StatelessWidget {
  final bool isSelected;
  final String text;
  final String iconPath;
  final Function()? onTap;

  const FilterMenu({
    Key? key,
    this.isSelected = false,
    required this.text,
    required this.iconPath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 14.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: isSelected ? AppColor.darkColor2 : AppColor.blueColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: -1,
              color: AppColor.darkColor2.withOpacity(0.25),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconPath),
            10.horizontalSpaceRadius,
            Padding(
              padding: EdgeInsets.only(bottom: 2.r),
              child: Text(
                text,
                style: Get.textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
