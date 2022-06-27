import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class DateChat extends StatelessWidget {
  final DateTime date;

  const DateChat({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.r, horizontal: 12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: AppColor.blueColor,
        ),
        child: Text(
          DateFormat('dd MMMM yyyy').format(date),
          style: Get.textTheme.labelMedium!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
