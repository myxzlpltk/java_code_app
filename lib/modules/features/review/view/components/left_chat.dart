import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class LeftChat extends StatelessWidget {
  final String message;
  final DateTime date;

  const LeftChat({
    Key? key,
    required this.message,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 9.r, horizontal: 14.r),
        width: 205.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
            bottomRight: Radius.circular(15.r),
          ),
          color: AppColor.lightColor3.withOpacity(0.5),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.person, color: AppColor.blueColor, size: 14.r),
                7.horizontalSpaceRadius,
                Text(
                  'Bro Gil',
                  style: Get.textTheme.labelMedium!
                      .copyWith(color: AppColor.blueColor),
                ),
                7.horizontalSpaceRadius,
                Text(
                  DateFormat('hh:mm').format(date),
                  style: Get.textTheme.labelMedium,
                ),
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
