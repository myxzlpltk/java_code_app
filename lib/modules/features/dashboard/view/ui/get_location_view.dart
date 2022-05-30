import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetConst.bgPattern2),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'searching_location'.tr,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50.h),
              Stack(
                children: [
                  Image.asset(AssetConst.iconLocation, width: 190.h),
                  Padding(
                    padding: EdgeInsets.all(70.h),
                    child: Icon(Icons.location_pin, size: 50.h),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              Obx(
                () => ConditionalSwitch.single<String>(
                  context: context,
                  valueBuilder: (context) =>
                      DashboardController.to.statusLocation.value,
                  caseBuilders: {
                    'error': (context) => Text(
                          DashboardController.to.messageLocation.value,
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.center,
                        ),
                    'success': (context) => Text(
                          DashboardController.to.address.value!,
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.center,
                        ),
                  },
                  fallbackBuilder: (context) =>
                      const CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
