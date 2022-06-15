import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/cart/controllers/cart_controller.dart';
import 'package:java_code_app/shared/styles/shapes.dart';
import 'package:java_code_app/shared/widgets/menu_card.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';
import 'package:java_code_app/shared/widgets/tile_option.dart';
import 'package:java_code_app/utils/extensions/currency_extension.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: 30.r,
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 36.r),
          onPressed: () => Get.back(closeOverlays: true),
        ),
        centerTitle: true,
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgPicture.asset(
              AssetConst.iconOrder,
              width: 23.r,
              color: AppColor.blueColor,
            ),
            10.horizontalSpaceRadius,
            Text('Order'.tr, style: Get.textTheme.titleMedium),
          ],
        ),
        shape: CustomShape.bottomRoundedShape,
      ),
      body: RefreshIndicator(
        onRefresh: CartController.to.getDiscounts,
        child: Obx(
          () => Conditional.single(
            context: context,
            conditionBuilder: (context) => CartController.to.cart.isEmpty,

            /// Jika keranjang kosong
            widgetBuilder: (context) => SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetConst.iconEmptyCart,
                    width: 0.8.sw,
                  ),
                  Text(
                    'Empty cart'.tr,
                    style: Get.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            /// Jika keranjang tidak kosong
            fallbackBuilder: (context) => ListView(
              padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 28.r),
              children: [
                /// Food
                if (CartController.to.foodItems.isNotEmpty) ...[
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetConst.iconFood,
                        width: 20.r,
                        height: 20.r,
                        color: AppColor.blueColor,
                      ),
                      10.horizontalSpaceRadius,
                      Text(
                        'Food'.tr,
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: AppColor.blueColor),
                      ),
                    ],
                  ),
                  17.verticalSpacingRadius,
                  Wrap(
                    runSpacing: 17.r,
                    children: CartController.to.foodItems
                        .map<Widget>(
                          (cartItem) => MenuCard(
                            menu: cartItem.menu,
                            price: cartItem.price,
                            quantity: cartItem.quantity,
                            note: cartItem.note,
                            onIncrement: () =>
                                CartController.to.increment(cartItem),
                            onDecrement: () =>
                                CartController.to.decrement(cartItem),
                            onNoteChanged: (value) =>
                                CartController.to.updateNote(cartItem, value),
                            onTap: () => Get.toNamed(
                              AppRoutes.detailMenuView,
                              arguments: cartItem.menu,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  37.verticalSpacingRadius,
                ],

                /// Drink
                if (CartController.to.drinkItems.isNotEmpty) ...[
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetConst.iconDrink,
                        width: 20.r,
                        height: 20.r,
                        color: AppColor.blueColor,
                      ),
                      10.horizontalSpaceRadius,
                      Text(
                        'Drink'.tr,
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: AppColor.blueColor),
                      ),
                      25.horizontalSpaceRadius,
                    ],
                  ),
                  17.verticalSpacingRadius,
                  Wrap(
                    runSpacing: 17.r,
                    children: CartController.to.drinkItems
                        .map<Widget>(
                          (cartItem) => MenuCard(
                            menu: cartItem.menu,
                            price: cartItem.price,
                            quantity: cartItem.quantity,
                            note: cartItem.note,
                            onIncrement: () =>
                                CartController.to.increment(cartItem),
                            onDecrement: () =>
                                CartController.to.decrement(cartItem),
                            onNoteChanged: (value) =>
                                CartController.to.updateNote(cartItem, value),
                            onTap: () => Get.toNamed(
                              AppRoutes.detailMenuView,
                              arguments: cartItem.menu,
                            ),
                          ),
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
        () => Conditional.single(
          context: context,
          conditionBuilder: (context) => CartController.to.cart.isNotEmpty,
          widgetBuilder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 25.r, horizontal: 22.r),
                decoration: BoxDecoration(
                  color: AppColor.lightColor2,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                  ),
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    /// Total orders
                    TileOption(
                      title: 'Total orders'.tr,
                      subtitle: '(${CartController.to.cart.length} Menu):',
                      message: CartController.to.totalPrice.toRupiah(),
                      titleStyle: Get.textTheme.headlineSmall,
                      messageStyle: Get.textTheme.labelLarge!
                          .copyWith(color: AppColor.blueColor),
                    ),
                    Divider(
                        color: AppColor.darkColor2.withOpacity(0.25),
                        height: 2.r),

                    /// Discount
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          CartController.to.discountPrice == 0,
                      widgetBuilder: (context) => TileOption(
                        icon: AssetConst.iconDiscount,
                        iconSize: 24.r,
                        title: 'Discount'.tr,
                        message: CartController.to.selectedVoucher.value == null
                            ? 'No discount'.tr
                            : 'Discount can not be combined'.tr,
                        titleStyle: Get.textTheme.headlineSmall,
                        messageStyle: Get.textTheme.bodySmall,
                      ),
                      fallbackBuilder: (context) => TileOption(
                        icon: AssetConst.iconDiscount,
                        iconSize: 24.r,
                        title: 'Discount'.tr,
                        message: CartController.to.discountPrice.toRupiah(),
                        titleStyle: Get.textTheme.headlineSmall,
                        messageStyle: Get.textTheme.bodySmall!
                            .copyWith(color: AppColor.redColor),
                        onTap: CartController.to.openDiscountDialog,
                      ),
                    ),
                    Divider(
                        color: AppColor.darkColor2.withOpacity(0.25),
                        height: 2.r),

                    /// Vouchers
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          CartController.to.selectedVoucher.value == null,
                      widgetBuilder: (context) => TileOption(
                        icon: AssetConst.iconVoucher,
                        iconSize: 24.r,
                        title: 'voucher'.tr,
                        message: 'Choose voucher'.tr,
                        titleStyle: Get.textTheme.headlineSmall,
                        messageStyle: Get.textTheme.bodySmall,
                        onTap: CartController.to.openVoucherDialog,
                      ),
                      fallbackBuilder: (context) => TileOption(
                        icon: AssetConst.iconVoucher,
                        iconSize: 24.r,
                        title: 'voucher'.tr,
                        message: CartController.to.voucherPrice.toRupiah(),
                        messageSubtitle:
                            CartController.to.selectedVoucher.value!.nama,
                        titleStyle: Get.textTheme.headlineSmall,
                        messageStyle: Get.textTheme.bodySmall!
                            .copyWith(color: AppColor.redColor),
                        onTap: CartController.to.openVoucherDialog,
                      ),
                    ),
                    Divider(
                        color: AppColor.darkColor2.withOpacity(0.25),
                        height: 2.r),

                    /// Payment options
                    TileOption(
                      icon: AssetConst.iconPayment,
                      iconSize: 24.r,
                      title: 'Payment'.tr,
                      message: 'Pay Later',
                      titleStyle: Get.textTheme.headlineSmall,
                      messageStyle: Get.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              /// Actions
              Container(
                color: AppColor.lightColor2,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.r,
                    horizontal: 22.r,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.r),
                    ),
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
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AssetConst.iconCart,
                        width: 35.r,
                        height: 35.r,
                      ),
                      9.horizontalSpaceRadius,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total payment'.tr,
                              style: Get.textTheme.labelMedium,
                            ),
                            Text(
                              CartController.to.grandTotalPrice.toRupiah(),
                              style: Get.textTheme.titleMedium!
                                  .copyWith(color: AppColor.blueColor),
                            ),
                          ],
                        ),
                      ),
                      PrimaryButton(
                        text: 'Order now'.tr,
                        onPressed: CartController.to.verify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          fallbackBuilder: (context) => const SizedBox(),
        ),
      ),
    );
  }
}
