import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class RightChat extends StatelessWidget {
  final String message;
  final DateTime date;

  const RightChat({
    Key? key,
    required this.message,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 9.r, horizontal: 14.r),
        width: 205.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
            bottomLeft: Radius.circular(15.r),
          ),
          color: AppColor.blueColor.withOpacity(0.1),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat('hh:mm').format(date),
                  style: Get.textTheme.labelMedium,
                ),
                7.horizontalSpaceRadius,
                Icon(Icons.person, color: AppColor.blueColor, size: 14.r),
              ],
            ),
            2.verticalSpacingRadius,
            Text(message, style: Get.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}
