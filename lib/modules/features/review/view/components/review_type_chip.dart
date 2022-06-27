import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';

class ReviewTypeChip extends StatelessWidget {
  final String type;
  final bool isSelected;
  final void Function()? onTap;

  const ReviewTypeChip({
    Key? key,
    required this.type,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30.r),
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 5.r, horizontal: 13.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color: isSelected ? AppColor.blueColor : AppColor.greyColor,
              width: 1.r,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                type,
                style: Get.textTheme.labelMedium!.copyWith(
                  color: isSelected ? AppColor.blueColor : AppColor.greyColor,
                ),
              ),
              ...Conditional.list(
                context: context,
                conditionBuilder: (context) => isSelected,
                widgetBuilder: (context) => [
                  7.horizontalSpaceRadius,
                  SvgPicture.asset(
                    AssetConst.iconCheck,
                    width: 10.r,
                    height: 10.r,
                  ),
                ],
                fallbackBuilder: (context) => [],
              )
            ],
          ),
        ),
      ),
    );
  }
}
