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
import 'package:java_code_app/shared/styles/shapes.dart';
import 'package:java_code_app/shared/widgets/empty_data_list_view.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';
import 'package:java_code_app/shared/widgets/rect_shimmer.dart';
import 'package:java_code_app/shared/widgets/server_error_list_view.dart';

class ChooseVoucherView extends StatelessWidget {
  const ChooseVoucherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            SvgPicture.asset(AssetConst.iconVoucher, width: 23.r),
            10.horizontalSpaceRadius,
            Text('Choose voucher'.tr, style: Get.textTheme.titleMedium),
          ],
        ),
        shape: CustomShape.bottomRoundedShape,
      ),
      body: RefreshIndicator(
        onRefresh: CartController.to.getVouchers,
        child: Obx(
          () => ConditionalSwitch.single<String>(
            context: context,
            valueBuilder: (context) => CartController.to.voucherStatus.value,
            caseBuilders: {
              'error': (context) => const ServerErrorListView(),
              'empty': (context) => const EmptyDataListView(),
              'loading': (context) => ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.r,
                      vertical: 30.r,
                    ),
                    itemBuilder: (context, _) =>
                        RectShimmer(height: 216.r, radius: 15.r),
                    separatorBuilder: (context, _) => 17.verticalSpacingRadius,
                    itemCount: 5,
                  ),
            },
            fallbackBuilder: (context) => ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 25.r,
                vertical: 30.r,
              ),
              itemBuilder: (context, index) => VoucherCard(
                voucher: CartController.to.vouchers.elementAt(index),
                isSelected: CartController.to.vouchers.elementAt(index) ==
                    CartController.to.selectedVoucher.value,
                onTap: () => Get.toNamed(
                  AppRoutes.detailVoucherView,
                  arguments: CartController.to.vouchers.elementAt(index),
                ),
                onChanged: (value) {
                  if (value == true) {
                    CartController.to.setVoucher(
                        CartController.to.vouchers.elementAt(index));
                  } else {
                    CartController.to.setVoucher(null);
                  }
                },
              ),
              separatorBuilder: (context, _) => 17.verticalSpacingRadius,
              itemCount: CartController.to.vouchers.length,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 22.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
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
            5.verticalSpacingRadius,
            Row(
              children: [
                10.horizontalSpaceRadius,
                Icon(Icons.check_circle_outline,
                    color: AppColor.blueColor, size: 24.r),
                10.horizontalSpaceRadius,
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'The use of vouchers cannot be combined with a discount'
                                  .tr,
                          style: Get.textTheme.bodySmall,
                        ),
                        TextSpan(
                          text: ' ${'employee reward program'.tr}',
                          style: Get.textTheme.labelLarge!
                              .copyWith(color: AppColor.blueColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            10.verticalSpacingRadius,
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
