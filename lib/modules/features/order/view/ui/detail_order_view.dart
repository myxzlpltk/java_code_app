import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/order/controllers/detail_order_controller.dart';
import 'package:java_code_app/modules/features/order/view/components/checked_step.dart';
import 'package:java_code_app/modules/features/order/view/components/detail_order_card.dart';
import 'package:java_code_app/modules/features/order/view/components/unchecked_step.dart';
import 'package:java_code_app/shared/styles/shapes.dart';
import 'package:java_code_app/shared/widgets/empty_data_list_view.dart';
import 'package:java_code_app/shared/widgets/rect_shimmer.dart';
import 'package:java_code_app/shared/widgets/server_error_list_view.dart';
import 'package:java_code_app/shared/widgets/tile_option.dart';
import 'package:java_code_app/utils/extensions/currency_extension.dart';

class DetailOrderView extends StatelessWidget {
  const DetailOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DetailOrderController());

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
            SvgPicture.asset(
              AssetConst.iconOrder,
              width: 23.r,
              color: blueColor,
            ),
            10.horizontalSpaceRadius,
            Text('Order'.tr, style: Get.textTheme.titleMedium),
          ],
        ),
        shape: CustomShape.bottomRoundedShape,
      ),
      body: RefreshIndicator(
        onRefresh: DetailOrderController.to.fetch,
        child: Obx(
          () => ConditionalSwitch.single<String>(
            context: context,
            valueBuilder: (context) => DetailOrderController.to.status.value,
            caseBuilders: {
              'loading': (context) => ListView.separated(
                    padding: EdgeInsets.all(25.r),
                    separatorBuilder: (_, i) => 18.verticalSpacingRadius,
                    itemCount: 3,
                    itemBuilder: (_, i) => AspectRatio(
                      aspectRatio: 378 / 89,
                      child: RectShimmer(radius: 10.r),
                    ),
                  ),
              'empty': (context) => const EmptyDataListView(),
              'error': (context) => const ServerErrorListView(),
            },
            fallbackBuilder: (context) => ListView(
              padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 28.r),
              children: [
                /// Food
                if (DetailOrderController.to.foodItems.isNotEmpty) ...[
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetConst.iconFood,
                        width: 20.r,
                        height: 20.r,
                        color: blueColor,
                      ),
                      10.horizontalSpaceRadius,
                      Text(
                        'Food'.tr,
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: blueColor),
                      ),
                    ],
                  ),
                  17.verticalSpacingRadius,
                  Wrap(
                    runSpacing: 17.r,
                    children: DetailOrderController.to.foodItems
                        .map<Widget>(
                          (detailOrder) => DetailOrderCard(detailOrder),
                        )
                        .toList(),
                  ),
                  37.verticalSpacingRadius,
                ],

                /// Drink
                if (DetailOrderController.to.drinkItems.isNotEmpty) ...[
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetConst.iconDrink,
                        width: 20.r,
                        height: 20.r,
                        color: blueColor,
                      ),
                      10.horizontalSpaceRadius,
                      Text(
                        'Drink'.tr,
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: blueColor),
                      ),
                      25.horizontalSpaceRadius,
                    ],
                  ),
                  17.verticalSpacingRadius,
                  Wrap(
                    runSpacing: 17.r,
                    children: DetailOrderController.to.drinkItems
                        .map<Widget>(
                          (detailOrder) => DetailOrderCard(detailOrder),
                        )
                        .toList(),
                  ),
                  37.verticalSpacingRadius,
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => ConditionalSwitch.single<String>(
          context: context,
          valueBuilder: (context) => DetailOrderController.to.status.value,
          caseBuilders: {
            'loading': (context) => const SizedBox(),
            'empty': (context) => const SizedBox(),
            'error': (context) => const SizedBox(),
          },
          fallbackBuilder: (context) => Container(
            padding: EdgeInsets.all(25.r),
            decoration: BoxDecoration(
              color: lightColor2,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Total orders
                TileOption(
                  title: 'total_orders'.tr,
                  subtitle:
                      '(${DetailOrderController.to.order.value!.menu.length} Menu):',
                  message:
                      DetailOrderController.to.order.value!.total.toRupiah(),
                  titleStyle: Get.textTheme.headlineSmall,
                  messageStyle:
                      Get.textTheme.labelLarge!.copyWith(color: blueColor),
                ),
                Divider(color: darkColor2.withOpacity(0.25), height: 2.r),

                /// Discount
                ...Conditional.list(
                  context: context,
                  conditionBuilder: (context) =>
                      DetailOrderController.to.order.value!.diskon == 1 &&
                      DetailOrderController.to.order.value!.potongan > 0,
                  widgetBuilder: (context) => [
                    TileOption(
                      icon: AssetConst.iconDiscount,
                      iconSize: 24.r,
                      title: 'Discount'.tr,
                      message: DetailOrderController.to.order.value!.potongan
                          .toRupiah(),
                      titleStyle: Get.textTheme.headlineSmall,
                      messageStyle:
                          Get.textTheme.bodySmall!.copyWith(color: redColor),
                    ),
                    Divider(
                      color: darkColor2.withOpacity(0.25),
                      height: 2.r,
                    ),
                  ],
                  fallbackBuilder: (context) => [],
                ),

                /// Vouchers
                ...Conditional.list(
                  context: context,
                  conditionBuilder: (context) =>
                      DetailOrderController.to.order.value!.id_voucher != 0,
                  widgetBuilder: (context) => [
                    TileOption(
                      icon: AssetConst.iconVoucher,
                      iconSize: 24.r,
                      title: 'voucher'.tr,
                      message: DetailOrderController.to.order.value!.potongan
                          .toRupiah(),
                      messageSubtitle:
                          DetailOrderController.to.order.value!.nama_voucher,
                      titleStyle: Get.textTheme.headlineSmall,
                      messageStyle:
                          Get.textTheme.bodySmall!.copyWith(color: redColor),
                    ),
                    Divider(
                      color: darkColor2.withOpacity(0.25),
                      height: 2.r,
                    ),
                  ],
                  fallbackBuilder: (context) => [],
                ),

                /// Payment options
                TileOption(
                  icon: AssetConst.iconPayment,
                  iconSize: 24.r,
                  title: 'Payment'.tr,
                  message: 'Pay Later',
                  titleStyle: Get.textTheme.headlineSmall,
                  messageStyle: Get.textTheme.bodySmall,
                ),
                Divider(color: darkColor2.withOpacity(0.25), height: 2.r),

                /// Total pay
                TileOption(
                  iconSize: 24.r,
                  title: 'Total payment'.tr,
                  message: DetailOrderController.to.order.value!.total_bayar
                      .toRupiah(),
                  titleStyle: Get.textTheme.headlineSmall,
                  messageStyle:
                      Get.textTheme.headlineSmall!.copyWith(color: blueColor),
                ),
                Divider(color: darkColor2.withOpacity(0.25), height: 2.r),
                24.verticalSpacingRadius,

                /// Status order
                Text(
                  'Pesanan kamu sedang disiapkan',
                  style: Get.textTheme.titleSmall,
                  textAlign: TextAlign.left,
                ),
                18.verticalSpacingRadius,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(flex: 10),
                    Expanded(
                      flex: 10,
                      child: Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            DetailOrderController.to.order.value!.status == 0 ||
                            DetailOrderController.to.order.value!.status == 1,
                        widgetBuilder: (context) => const CheckedStep(),
                        fallbackBuilder: (context) => const UncheckedStep(),
                      ),
                    ),
                    const Spacer(flex: 3),
                    Expanded(
                      flex: 42,
                      child: Container(
                        height: 4.r,
                        color: darkColor2.withOpacity(0.25),
                      ),
                    ),
                    const Spacer(flex: 3),
                    Expanded(
                      flex: 10,
                      child: Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            DetailOrderController.to.order.value!.status == 2,
                        widgetBuilder: (context) => const CheckedStep(),
                        fallbackBuilder: (context) => const UncheckedStep(),
                      ),
                    ),
                    const Spacer(flex: 3),
                    Expanded(
                      flex: 42,
                      child: Container(
                        height: 4.r,
                        color: darkColor2.withOpacity(0.25),
                      ),
                    ),
                    const Spacer(flex: 3),
                    Expanded(
                      flex: 10,
                      child: Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            DetailOrderController.to.order.value!.status == 3,
                        widgetBuilder: (context) => const CheckedStep(),
                        fallbackBuilder: (context) => const UncheckedStep(),
                      ),
                    ),
                    const Spacer(flex: 10),
                  ],
                ),
                11.verticalSpacingRadius,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Order accepted'.tr,
                        style: Get.textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(
                        'Please take it'.tr,
                        style: Get.textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(
                        'Order completed'.tr,
                        style: Get.textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
