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
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          28.verticalSpacingRadius,

          /// Icon
          SvgPicture.asset(AssetConst.iconOrderSuccess),
          28.verticalSpacingRadius,

          /// Judul
          Text(
            'Order is being prepared'.tr,
            style: Get.textTheme.headlineMedium,
          ),
          14.verticalSpacingRadius,

          /// Subjudul
          Text(
            'You can track your order in order history'.tr,
            style:
                Get.textTheme.bodySmall!.copyWith(color: AppColor.greyColor2),
          ),
          14.verticalSpacingRadius,
          SizedBox(
            width: 168.r,
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
