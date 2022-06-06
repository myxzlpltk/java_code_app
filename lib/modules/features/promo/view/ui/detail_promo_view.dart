import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/promo/controllers/detail_promo_controller.dart';
import 'package:java_code_app/shared/styles/shapes.dart';
import 'package:java_code_app/shared/widgets/promo_card.dart';
import 'package:java_code_app/shared/widgets/rect_shimmer.dart';
import 'package:java_code_app/utils/extensions/string_extension.dart';
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
          splashRadius: 30.r,
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 36.r),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgPicture.asset(AssetConst.iconPromo, width: 23.r),
            10.horizontalSpaceRadius,
            Text('Promo'.tr, style: Get.textTheme.titleMedium),
          ],
        ),
        shape: CustomShape.bottomRoundedShape,
      ),
      backgroundColor: lightColor3,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(25.r),
              child: Obx(
                () => Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      DetailPromoController.to.status.value == 'success',
                  widgetBuilder: (context) => Screenshot(
                    controller: DetailPromoController.to.screenshotController,
                    child: AspectRatio(
                      aspectRatio: 378 / 181,
                      child: PromoCard(
                        promo: DetailPromoController.to.promo.value!,
                        shadow: true,
                      ),
                    ),
                  ),
                  fallbackBuilder: (context) => AspectRatio(
                    aspectRatio: 378 / 181,
                    child: RectShimmer(
                      width: 378.r,
                      height: 181.r,
                      radius: 15.r,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.symmetric(horizontal: 22.r, vertical: 45.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
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
                              style: Get.textTheme.titleMedium,
                            ),
                          ),
                          25.horizontalSpaceRadius,
                          Text(
                            DetailPromoController
                                .to.promo.value!.typeAmountLabel,
                            style: Get.textTheme.titleMedium!
                                .copyWith(color: blueColor),
                          ),
                        ],
                      ),
                      fallbackBuilder: (context) => RectShimmer(height: 25.r),
                    ),
                  ),
                  17.verticalSpacingRadius,
                  Divider(color: const Color(0xFF2E2E2E).withOpacity(0.25)),
                  13.verticalSpacingRadius,
                  Row(
                    children: [
                      const Icon(Icons.list, color: blueColor),
                      14.horizontalSpaceRadius,
                      Text(
                        'Terms and conditions'.tr,
                        style: Get.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  10.verticalSpacingRadius,
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
                            Get.textTheme.labelMedium!,
                          ),
                          'body': Style(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                          ),
                        },
                      ),
                      fallbackBuilder: (context) => RectShimmer(height: 100.r),
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
        onPressed: DetailPromoController.to.sharePromo,
        child: const Icon(Icons.share),
      ),
    );
  }
}
