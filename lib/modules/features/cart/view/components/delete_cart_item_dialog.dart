import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/shared/widgets/outlined_primary_button.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';

class DeleteCartItemDialog extends StatelessWidget {
  const DeleteCartItemDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          16.verticalSpacingRadius,

          /// Icon
          Row(
            children: [
              Icon(Icons.warning, color: AppColor.blueColor, size: 72.r),
              16.horizontalSpaceRadius,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Warning'.tr,
                      style: Get.textTheme.titleMedium?.copyWith(
                        color: AppColor.redColor,
                      ),
                    ),
                    4.verticalSpacingRadius,
                    Text(
                      'Are you sure want to delete this menu from cart?'.tr,
                      style: Get.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          14.verticalSpacingRadius,

          /// Actions
          Row(
            children: [
              Expanded(
                child: OutlinedPrimaryButton(
                  onPressed: () => Get.back(result: false),
                  text: 'No'.tr,
                ),
              ),
              16.horizontalSpaceRadius,
              Expanded(
                child: PrimaryButton(
                  onPressed: () => Get.back(result: true),
                  text: 'Yes'.tr,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
