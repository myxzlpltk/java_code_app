import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/promo/controllers/detail_promo_controller.dart';
import 'package:java_code_app/shared/widgets/promo_card.dart';
import 'package:java_code_app/shared/widgets/rect_shimmer.dart';
import 'package:java_code_app/utils/extensions/string_case_extension.dart';
import 'package:screenshot/screenshot.dart';

class DetailPromoView extends StatelessWidget {
  const DetailPromoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DetailPromoController());

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 32.w),
          onPressed: () => Get.back(closeOverlays: true),
        ),
        centerTitle: true,
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgPicture.asset(AssetConst.iconPromo, width: 23.w),
            SizedBox(width: 10.w),
            Text('promo'.tr, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.w),
          ),
        ),
      ),
      backgroundColor: lightColor2,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25.w),
            child: Obx(
              () => Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    DetailPromoController.to.status.value == 'success',
                widgetBuilder: (context) => Screenshot(
                  controller: DetailPromoController.to.screenshotController,
                  child: PromoCard(
                    promo: DetailPromoController.to.promo.value!,
                    width: 378.w,
                    height: 181.h,
                    shadow: true,
                  ),
                ),
                fallbackBuilder: (context) => RectShimmer(
                  width: 378.w,
                  height: 181.h,
                  radius: 15.w,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 45.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
              ),
              child: Column(
                children: [
                  Obx(
                    () => Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          DetailPromoController.to.status.value == 'success',
                      widgetBuilder: (context) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              DetailPromoController.to.promo.value!.nama
                                  .toTitleCase(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          SizedBox(width: 25.w),
                          Text(
                            DetailPromoController
                                .to.promo.value!.typeAmountLabel,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: blueColor),
                          ),
                        ],
                      ),
                      fallbackBuilder: (context) => RectShimmer(height: 25.h),
                    ),
                  ),
                  SizedBox(height: 17.h),
                  Divider(color: const Color(0xFF2E2E2E).withOpacity(0.25)),
                  SizedBox(height: 13.h),
                  Row(
                    children: [
                      const Icon(Icons.list, color: blueColor),
                      SizedBox(width: 14.w),
                      Text(
                        'terms_and_conditions'.tr,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () => Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          DetailPromoController.to.status.value == 'success',
                      widgetBuilder: (context) => Html(
                        data: DetailPromoController
                            .to.promo.value!.syarat_ketentuan,
                        style: {
                          '*': Style.fromTextStyle(
                            Theme.of(context).textTheme.labelLarge!,
                          ),
                        },
                      ),
                      fallbackBuilder: (context) => RectShimmer(height: 100.h),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.share),
        onPressed: () => DetailPromoController.to.sharePromo(),
      ),
    );
  }
}
