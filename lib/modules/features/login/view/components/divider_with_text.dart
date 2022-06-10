import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.black.withOpacity(0.25))),
        15.horizontalSpaceRadius,
        Text(
          text.tr,
          style: Get.textTheme.bodySmall!.copyWith(
            color: AppColor.darkColor.withOpacity(0.25),
          ),
        ),
        15.horizontalSpaceRadius,
        Expanded(child: Divider(color: Colors.black.withOpacity(0.25))),
      ],
    );
  }
}
