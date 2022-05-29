import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/home/controllers/detail_promo_controller.dart';
import 'package:java_code_app/modules/features/home/view/components/promo_card.dart';
import 'package:java_code_app/utils/extensions/string_case_extension.dart';
import 'package:screenshot/screenshot.dart';

class DetailPromoView extends StatelessWidget {
  const DetailPromoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DetailPromoController());

    final promo = DetailPromoController.to.promo.value;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            pinned: true,
            floating: false,
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
                Text('Promo', style: Theme.of(context).textTheme.headline6),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30.w),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(25.w),
              child: Screenshot(
                controller: DetailPromoController.to.screenshotController,
                child: PromoCard(
                  promo: promo,
                  width: 378.w,
                  height: 181.h,
                  shadow: true,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 45.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          promo.nama.toTitleCase(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      SizedBox(width: 25.w),
                      Text(
                        promo.typeAmountLabel,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: blueColor),
                      ),
                    ],
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
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  Html(data: promo.syarat_ketentuan),
                ],
              ),
            ),
          )
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
