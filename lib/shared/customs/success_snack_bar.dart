import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class SuccessSnackBar extends GetSnackBar {
  SuccessSnackBar({
    Key? key,
    required String title,
    required String message,
  }) : super(
          key: key,
          titleText: Text(
            title,
            style: Get.textTheme.bodySmall!.copyWith(color: Colors.white),
          ),
          messageText: Text(
            message,
            style: Get.textTheme.labelMedium!.copyWith(color: Colors.white),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: AppColor.greenColor,
          isDismissible: true,
        );
}
