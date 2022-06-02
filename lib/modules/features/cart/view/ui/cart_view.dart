import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/cart/controllers/cart_controller.dart';
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
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 32.w),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgPicture.asset(
              AssetConst.iconOrder,
              width: 23.w,
              color: blueColor,
            ),
            SizedBox(width: 10.w),
            Text('order'.tr, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.w),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.any([
          CartController.to.getDiscounts(),
        ]),
        child: Obx(
          () => Conditional.single(
            context: context,
            conditionBuilder: (context) => CartController.to.cart.isEmpty,
            widgetBuilder: (context) => SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetConst.iconEmptyCart,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  Text(
                    'empty_cart'.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            fallbackBuilder: (context) => ListView(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 28.h),
              children: [
                /// Food
                ...Conditional.list(
                  context: context,
                  conditionBuilder: (context) =>
                      CartController.to.foodItems.isEmpty,
                  widgetBuilder: (context) => const [],
                  fallbackBuilder: (context) => [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetConst.iconFood,
                          width: 20.r,
                          height: 20.r,
                          color: blueColor,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'food'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: blueColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 17.h),
                    Wrap(
                      runSpacing: 17.h,
                      children: CartController.to.foodItems
                          .map<Widget>(
                            (orderDetail) => MenuCard(
                              menu: orderDetail.menu,
                              price: orderDetail.price,
                              quantity: orderDetail.quantity,
                              note: orderDetail.note,
                              onIncrement: () =>
                                  CartController.to.increment(orderDetail),
                              onDecrement: () =>
                                  CartController.to.decrement(orderDetail),
                              onNoteChanged: (value) => CartController.to
                                  .updateNote(orderDetail, value),
                              onTap: () => Get.toNamed(
                                AppRoutes.detailMenuView,
                                arguments: orderDetail.menu,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 37.h),
                  ],
                ),

                /// Drink
                ...Conditional.list(
                  context: context,
                  conditionBuilder: (context) =>
                      CartController.to.drinkItems.isEmpty,
                  widgetBuilder: (context) => const [],
                  fallbackBuilder: (context) => [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetConst.iconDrink,
                          width: 20.r,
                          height: 20.r,
                          color: blueColor,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'drink'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: blueColor),
                        ),
                        SizedBox(width: 25.w),
                      ],
                    ),
                    SizedBox(height: 17.h),
                    Wrap(
                      runSpacing: 17.h,
                      children: CartController.to.drinkItems
                          .map<Widget>(
                            (orderDetail) => MenuCard(
                              menu: orderDetail.menu,
                              price: orderDetail.price,
                              quantity: orderDetail.quantity,
                              note: orderDetail.note,
                              onIncrement: () =>
                                  CartController.to.increment(orderDetail),
                              onDecrement: () =>
                                  CartController.to.decrement(orderDetail),
                              onNoteChanged: (value) => CartController.to
                                  .updateNote(orderDetail, value),
                              onTap: () => Get.toNamed(
                                AppRoutes.detailMenuView,
                                arguments: orderDetail.menu,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 37.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Conditional.single(
          context: context,
          conditionBuilder: (context) => CartController.to.cart.isEmpty,
          widgetBuilder: (context) => const SizedBox(),
          fallbackBuilder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 22.w),
                decoration: BoxDecoration(
                  color: lightColor2,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.w),
                  ),
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    /// Total orders
                    TileOption(
                      title: 'total_orders'.tr,
                      subtitle: '(${CartController.to.cart.length} Menu):',
                      message: CartController.to.totalPrice.toRupiah(),
                      titleStyle: Theme.of(context).textTheme.headlineSmall,
                      messageStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: blueColor),
                      color: lightColor2,
                    ),
                    Divider(color: darkColor2.withOpacity(0.25), height: 2),

                    /// Discount
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          CartController.to.discountPrice == 0,
                      widgetBuilder: (context) => TileOption(
                        icon: AssetConst.iconDiscount,
                        iconSize: 24.r,
                        title: 'discount'.tr,
                        message: CartController.to.selectedVoucher.value == null
                            ? 'no_discount'.tr
                            : 'discount_can_not_be_combined'.tr,
                        titleStyle: Theme.of(context).textTheme.headlineSmall,
                        messageStyle: Theme.of(context).textTheme.bodySmall,
                        color: lightColor2,
                      ),
                      fallbackBuilder: (context) => TileOption(
                        icon: AssetConst.iconDiscount,
                        iconSize: 24.r,
                        title: 'discount'.tr,
                        message: CartController.to.discountPrice.toRupiah(),
                        titleStyle: Theme.of(context).textTheme.headlineSmall,
                        messageStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: redColor),
                        color: lightColor2,
                        onTap: CartController.to.openDiscountDialog,
                      ),
                    ),
                    Divider(color: darkColor2.withOpacity(0.25), height: 2),

                    /// Vouchers
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          CartController.to.selectedVoucher.value == null,
                      widgetBuilder: (context) => TileOption(
                        icon: AssetConst.iconVoucher,
                        iconSize: 24.r,
                        title: 'voucher'.tr,
                        message: 'choose_voucher'.tr,
                        titleStyle: Theme.of(context).textTheme.headlineSmall,
                        messageStyle: Theme.of(context).textTheme.bodySmall,
                        color: lightColor2,
                        onTap: CartController.to.openVoucherDialog,
                      ),
                      fallbackBuilder: (context) => TileOption(
                        icon: AssetConst.iconVoucher,
                        iconSize: 24.r,
                        title: 'voucher'.tr,
                        message: CartController.to.voucherPrice.toRupiah(),
                        messageSubtitle:
                            CartController.to.selectedVoucher.value!.nama,
                        titleStyle: Theme.of(context).textTheme.headlineSmall,
                        messageStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: redColor),
                        color: lightColor2,
                        onTap: CartController.to.openVoucherDialog,
                      ),
                    ),
                    Divider(color: darkColor2.withOpacity(0.25), height: 2),

                    /// Payment options
                    TileOption(
                      icon: AssetConst.iconPayment,
                      iconSize: 24.r,
                      title: 'payment'.tr,
                      message: 'Pay Later',
                      titleStyle: Theme.of(context).textTheme.headlineSmall,
                      messageStyle: Theme.of(context).textTheme.bodySmall,
                      color: lightColor2,
                    ),
                  ],
                ),
              ),

              /// Actions
              Container(
                color: lightColor2,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 22.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.w),
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
                      SizedBox(width: 9.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'total_payment'.tr,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              CartController.to.grandTotalPrice.toRupiah(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: blueColor),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: PrimaryButton(
                          text: 'order_now'.tr,
                          onPressed: () {},
                        ),
                      ),
                    ],
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
