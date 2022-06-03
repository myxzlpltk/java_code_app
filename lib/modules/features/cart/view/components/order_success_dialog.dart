import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';

class OrderSuccessDialog extends StatelessWidget {
  const OrderSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 28.h),
          SvgPicture.asset(AssetConst.iconOrderSuccess),
          SizedBox(height: 28.h),
          Text(
            'Order is being prepared'.tr,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 14.h),
          Text(
            'You can track your order in order history'.tr,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: greyColor2),
          ),
          SizedBox(height: 14.h),
          SizedBox(
            width: 168.w,
            child: PrimaryButton(
              onPressed: () => Get.back(),
              text: 'Okay'.tr,
            ),
          ),
        ],
      ),
    );
  }
}
