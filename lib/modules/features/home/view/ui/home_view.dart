import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/home/controllers/home_controller.dart';
import 'package:java_code_app/modules/features/home/view/components/promo_card.dart';
import 'package:java_code_app/modules/features/home/view/components/shimmer_promo_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.any([
            HomeController.to.getPromo(),
          ]);
        },
        child: ListView(
          children: [
            SizedBox(height: 25.h),

            /// Promo Section - Title
            Row(
              children: [
                SizedBox(width: 25.w),
                SvgPicture.asset(AssetConst.iconPromo, width: 23.w),
                SizedBox(width: 10.w),
                Text('available_promo'.tr,
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(width: 25.w),
              ],
            ),
            SizedBox(height: 7.h),

            /// Promo Section - List
            SizedBox(
              height: 188.h,
              child: Obx(
                () => ConditionalSwitch.single<String>(
                  context: context,
                  valueBuilder: (context) =>
                      HomeController.to.statusPromo.value,
                  caseBuilders: {
                    'loading': (context) => ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.w,
                            vertical: 15.h,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, _) => const ShimmerPromoCard(),
                          itemCount: 5,
                          separatorBuilder: (context, _) =>
                              SizedBox(width: 25.w),
                        ),
                    'error': (context) => Center(
                          child: Text(HomeController.to.messagePromo.value),
                        ),
                    'success': (context) => ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.w,
                            vertical: 15.h,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => PromoCard(
                            promo: HomeController.to.listPromo.elementAt(index),
                            onTap: () => HomeController.to.viewDetailPromo(index),
                          ),
                          itemCount: HomeController.to.listPromo.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 25.w),
                        )
                  },
                  fallbackBuilder: (context) => const SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
