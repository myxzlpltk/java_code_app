import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/login/view/components/divider_with_text.dart';

class FingerprintDialog extends StatelessWidget {
  const FingerprintDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Verify order'.tr,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'Press your fingerprint'.tr,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: greyColor2),
          ),
          SizedBox(height: 30.h),
          GestureDetector(
            child: SvgPicture.asset(AssetConst.iconFingerprint),
            onTap: () => Get.back<String>(result: 'fingerprint'),
          ),
          SizedBox(height: 30.h),
          DividerWithText('or'.tr),
          TextButton(
            onPressed: () => Get.back<String>(result: 'pin'),
            child: Text(
              'Verify using PIN code'.tr,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: blueColor),
            ),
          ),
        ],
      ),
    );
  }
}
