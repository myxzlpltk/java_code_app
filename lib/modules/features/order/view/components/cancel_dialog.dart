import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class CancelDialog extends StatelessWidget {
  const CancelDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Warning'.tr,
        style: Get.textTheme.titleMedium?.copyWith(color: AppColor.redColor),
      ),
      content: Text(
        'Are you sure want to cancel order?'.tr,
        style: Get.textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back<bool>(result: false),
          child: Text(
            'No'.tr,
            style:
                Get.textTheme.labelLarge?.copyWith(color: AppColor.greenColor),
          ),
        ),
        TextButton(
          onPressed: () => Get.back<bool>(result: true),
          child: Text(
            'Yes'.tr,
            style: Get.textTheme.labelLarge?.copyWith(color: AppColor.redColor),
          ),
        ),
      ],
    );
  }
}
