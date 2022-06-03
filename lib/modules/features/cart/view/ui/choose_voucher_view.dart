import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/cart/controllers/cart_controller.dart';
import 'package:java_code_app/modules/features/cart/view/components/voucher_card.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';
import 'package:java_code_app/shared/widgets/rect_shimmer.dart';

class ChooseVoucherView extends StatelessWidget {
  const ChooseVoucherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 32.w),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgPicture.asset(AssetConst.iconVoucher, width: 23.w),
            SizedBox(width: 10.w),
            Text(
              'Choose voucher'.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.w),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: CartController.to.getVouchers,
        child: Obx(
          () => ConditionalSwitch.single<String>(
            context: context,
            valueBuilder: (context) => CartController.to.voucherStatus.value,
            caseBuilders: {
              'error': (context) => Stack(
                    children: [
                      ListView(),
                      Center(child: Text('Server error'.tr)),
                    ],
                  ),
              'loading': (context) => ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 30.h,
                    ),
                    itemBuilder: (context, _) =>
                        RectShimmer(height: 216.h, radius: 15.w),
                    separatorBuilder: (context, _) => SizedBox(height: 17.h),
                    itemCount: 5,
                  ),
            },
            fallbackBuilder: (context) => ListView(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
              children: CartController.to.vouchers
                  .map(
                    (voucher) => Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: VoucherCard(
                        voucher: voucher,
                        isSelected:
                            voucher == CartController.to.selectedVoucher.value,
                        onTap: () => Get.toNamed(
                          AppRoutes.detailVoucherView,
                          arguments: voucher,
                        ),
                        onChanged: (value) {
                          CartController.to
                              .setVoucher(value == true ? voucher : null);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 22.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: -1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5.h),
            Row(
              children: [
                SizedBox(width: 10.w),
                Icon(Icons.check_circle_outline, color: blueColor, size: 24.r),
                SizedBox(width: 10.w),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'The use of vouchers cannot be combined with a discount'
                                  .tr,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextSpan(
                          text: ' ${'employee reward program'.tr}',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: blueColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                text: 'Okay'.tr,
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
