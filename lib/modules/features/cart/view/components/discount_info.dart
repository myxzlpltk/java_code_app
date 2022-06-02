import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/modules/models/discount.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';
import 'package:java_code_app/utils/extensions/string_case_extension.dart';

class DiscountInfo extends StatelessWidget {
  final List<Discount> discounts;

  const DiscountInfo({Key? key, required this.discounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...discounts.map<Widget>(
            (discount) => Padding(
              padding: EdgeInsets.only(bottom: 7.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      discount.nama.toTitleCase(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    '${discount.nominal}%',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.h),
          SizedBox(
            width: 168.w,
            child: PrimaryButton(
              text: 'ok'.tr,
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }
}
