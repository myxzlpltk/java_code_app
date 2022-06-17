import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/dashboard/controllers/dashboard_controller.dart';

class GetLocationView extends StatelessWidget {
  const GetLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetConst.bgPattern2),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Searching location...'.tr,
                style: Get.textTheme.titleLarge!.copyWith(
                  color: AppColor.darkColor.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              ),
              50.verticalSpacingRadius,
              Stack(
                children: [
                  Image.asset(AssetConst.iconLocation, width: 190.r),
                  Padding(
                    padding: EdgeInsets.all(70.r),
                    child: Icon(Icons.location_pin, size: 50.r),
                  ),
                ],
              ),
              50.verticalSpacingRadius,
              Obx(
                () => ConditionalSwitch.single<String>(
                  context: context,
                  valueBuilder: (context) =>
                      DashboardController.to.statusLocation.value,
                  caseBuilders: {
                    'error': (context) => Text(
                          DashboardController.to.messageLocation.value,
                          style: Get.textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                    'success': (context) => Text(
                          DashboardController.to.address.value!,
                          style: Get.textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                  },
                  fallbackBuilder: (context) => const CircularProgressIndicator(
                    color: AppColor.blueColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
