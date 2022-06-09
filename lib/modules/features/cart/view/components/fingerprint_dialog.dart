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
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Judul
          Text(
            'Verify order'.tr,
            style: Get.textTheme.headlineMedium,
          ),

          /// Subjudul
          Text(
            'Press your fingerprint'.tr,
            style: Get.textTheme.bodySmall!.copyWith(color: greyColor2),
          ),
          30.verticalSpacingRadius,

          /// Icon fingerprint
          GestureDetector(
            child: SvgPicture.asset(AssetConst.iconFingerprint),
            onTap: () => Get.back<String>(result: 'fingerprint'),
          ),
          30.verticalSpacingRadius,
          DividerWithText('or'.tr),

          /// Opsi menggunakan PIN
          TextButton(
            onPressed: () => Get.back<String>(result: 'pin'),
            child: Text(
              'Verify using PIN code'.tr,
              style: Get.textTheme.titleSmall!.copyWith(color: blueColor),
            ),
          ),
        ],
      ),
    );
  }
}
