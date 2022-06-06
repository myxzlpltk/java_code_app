import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/modules/models/discount.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';
import 'package:java_code_app/utils/extensions/string_extension.dart';

class DiscountInfo extends StatelessWidget {
  final List<Discount> discounts;

  const DiscountInfo({Key? key, required this.discounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Info discount'.tr,
          style: Get.textTheme.headlineMedium!.copyWith(
            color: Get.theme.colorScheme.primary,
          ),
        ),
        30.verticalSpacingRadius,
        ...discounts.map<Widget>(
          (discount) => Padding(
            padding: EdgeInsets.only(bottom: 7.r),
            child: Row(
              children: [
                15.horizontalSpaceRadius,
                Expanded(
                  child: Text(
                    discount.nama.toTitleCase(),
                    style: Get.textTheme.bodyLarge,
                  ),
                ),
                Text('${discount.nominal}%', style: Get.textTheme.titleSmall),
                15.horizontalSpaceRadius,
              ],
            ),
          ),
        ),
        30.verticalSpacingRadius,
        SizedBox(
          width: 168.r,
          child: PrimaryButton(text: 'Okay'.tr, onPressed: () => Get.back()),
        ),
      ],
    );
  }
}
