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
        /// Title
        Text(
          'Info discount'.tr,
          style: Get.textTheme.headlineMedium!.copyWith(
            color: Get.theme.colorScheme.primary,
          ),
        ),
        30.verticalSpacingRadius,

        /// Daftar info diskon
        ...discounts.map<Widget>(
          (discount) => Padding(
            padding: EdgeInsets.fromLTRB(15.r, 0.r, 15.r, 7.r),
            child: Row(
              children: [
                /// Nama diskon
                Expanded(
                  child: Text(
                    discount.nama.toTitleCase(),
                    style: Get.textTheme.bodyLarge,
                  ),
                ),

                /// Nominal diskon
                Text('${discount.nominal}%', style: Get.textTheme.titleSmall),
              ],
            ),
          ),
        ),
        30.verticalSpacingRadius,

        /// Tombol OK
        SizedBox(
          width: 168.r,
          child: PrimaryButton(text: 'Okay'.tr, onPressed: () => Get.back()),
        ),
      ],
    );
  }
}
