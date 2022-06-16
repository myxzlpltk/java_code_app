// ignore_for_file: must_be_immutable

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/cart/controllers/cart_controller.dart';
import 'package:java_code_app/modules/features/home/controllers/home_controller.dart';
import 'package:java_code_app/modules/features/home/view/components/filter_menu.dart';
import 'package:java_code_app/modules/features/home/view/components/loading_menu_list.dart';
import 'package:java_code_app/modules/features/home/view/components/menu_list.dart';
import 'package:java_code_app/modules/features/home/view/components/search_bar.dart';
import 'package:java_code_app/shared/styles/shapes.dart';
import 'package:java_code_app/shared/widgets/custom_error_vertical.dart';
import 'package:java_code_app/shared/widgets/empty_data_vertical.dart';
import 'package:java_code_app/shared/widgets/promo_card.dart';
import 'package:java_code_app/shared/widgets/rect_shimmer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Row(
          children: [
            Expanded(
              child: SearchBar(
                controller: HomeController.to.searchController,
                onChanged: HomeController.to.setQueryMenu,
              ),
            ),
            IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.toNamed(AppRoutes.cartView);
              },
              splashRadius: 30.r,
              visualDensity: VisualDensity.compact,
              icon: Obx(
                () => Badge(
                  showBadge: CartController.to.cart.isNotEmpty,
                  badgeColor: AppColor.blueColor,
                  badgeContent: Text(
                    CartController.to.cart.length.toString(),
                    style: Get.textTheme.labelMedium!
                        .copyWith(color: Colors.white),
                  ),
                  child: Icon(Icons.shopping_cart, size: 30.r),
                ),
              ),
              color: Colors.black,
            ),
          ],
        ),
        shape: CustomShape.bottomRoundedShape,
      ),
      body: RefreshIndicator(
        onRefresh: HomeController.to.reload,
        child: ListView(
          children: [
            /// Promo section
            ...promoSection(context),

            /// Menu section
            listCategoryMenu(context),
            17.verticalSpacingRadius,

            Obx(
              () => Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    HomeController.to.categoryMenu.value != 'drink',
                widgetBuilder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: foodSection(context),
                ),
                fallbackBuilder: (context) => const SizedBox(),
              ),
            ),

            Obx(
              () => Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    HomeController.to.categoryMenu.value != 'food',
                widgetBuilder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: drinkSection(context),
                ),
                fallbackBuilder: (context) => const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Promo section
  List<Widget> promoSection(BuildContext context) {
    return [
      25.verticalSpacingRadius,

      /// Promo Section - Title
      Row(
        children: [
          25.horizontalSpaceRadius,
          SvgPicture.asset(AssetConst.iconPromo, width: 23.r),
          10.horizontalSpaceRadius,
          Text('Available promo'.tr, style: Get.textTheme.titleMedium),
          25.horizontalSpaceRadius,
        ],
      ),
      7.verticalSpacingRadius,

      /// Promo Section - List
      Obx(
        () => ConditionalSwitch.single<String>(
          context: context,
          valueBuilder: (context) => HomeController.to.statusPromo.value,
          caseBuilders: {
            'loading': (context) => SizedBox(
                  height: 188.r,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.r,
                      vertical: 15.r,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, _) => RectShimmer(
                      width: 282.r,
                      height: 158.r,
                      radius: 15.r,
                    ),
                    itemCount: 5,
                    separatorBuilder: (context, _) => 25.horizontalSpaceRadius,
                  ),
                ),
            'empty': (context) => Padding(
                  padding: EdgeInsets.only(bottom: 15.r),
                  child: EmptyDataVertical(width: 100.r),
                ),
            'error': (context) => CustomErrorVertical(
                  message: HomeController.to.messagePromo.value,
                ),
          },
          fallbackBuilder: (context) => SizedBox(
            height: 188.r,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 15.r),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => PromoCard(
                promo: HomeController.to.listPromo.elementAt(index),
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Get.toNamed(
                    AppRoutes.detailPromoView,
                    arguments: HomeController.to.listPromo.elementAt(index),
                  );
                },
              ),
              itemCount: HomeController.to.listPromo.length,
              separatorBuilder: (context, index) => 25.horizontalSpaceRadius,
            ),
          ),
        ),
      ),
      5.verticalSpacingRadius,
    ];
  }

  /// Menu section
  Widget listCategoryMenu(BuildContext context) {
    final List<Map<String, String>> filters = [
      {'name': 'All menu'.tr, 'value': 'all', 'icon': AssetConst.iconList},
      {'name': 'Food'.tr, 'value': 'food', 'icon': AssetConst.iconFood},
      {'name': 'Drink'.tr, 'value': 'drink', 'icon': AssetConst.iconDrink},
    ];

    return SizedBox(
      height: 45.r,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 5.r),
        itemBuilder: (context, index) => Obx(
          () => FilterMenu(
            isSelected:
                HomeController.to.categoryMenu.value == filters[index]['value'],
            onTap: () =>
                HomeController.to.setCategoryMenu(filters[index]['value']!),
            iconPath: filters[index]['icon']!,
            text: filters[index]['name']!,
          ),
        ),
        itemCount: filters.length,
        separatorBuilder: (context, index) => 13.horizontalSpaceRadius,
      ),
    );
  }

  /// Food section
  List<Widget> foodSection(BuildContext context) {
    return [
      Row(
        children: [
          25.horizontalSpaceRadius,
          SvgPicture.asset(
            AssetConst.iconFood,
            width: 20.r,
            height: 20.r,
            color: AppColor.blueColor,
          ),
          10.horizontalSpaceRadius,
          Text(
            'Food'.tr,
            style:
                Get.textTheme.titleMedium!.copyWith(color: AppColor.blueColor),
          ),
        ],
      ),

      /// Food Section - List
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 17.r),
        child: ConditionalSwitch.single<String>(
          context: context,
          valueBuilder: (context) => HomeController.to.statusMenu.value,
          caseBuilders: {
            'loading': (context) => const LoadingMenuList(),
            'empty': (context) => EmptyDataVertical(width: 100.r),
            'error': (context) => CustomErrorVertical(
                  message: HomeController.to.messageMenu.value,
                ),
          },
          fallbackBuilder: (context) => MenuList(
            data: HomeController.to.foodMenu,
          ),
        ),
      ),
      17.verticalSpacingRadius,
    ];
  }

  /// Drink section
  List<Widget> drinkSection(BuildContext context) {
    return [
      Row(
        children: [
          25.horizontalSpaceRadius,
          SvgPicture.asset(
            AssetConst.iconDrink,
            width: 20.r,
            height: 20.r,
            color: AppColor.blueColor,
          ),
          10.horizontalSpaceRadius,
          Text(
            'Drink'.tr,
            style:
                Get.textTheme.titleMedium!.copyWith(color: AppColor.blueColor),
          ),
          25.horizontalSpaceRadius,
        ],
      ),

      /// Drink Section - List
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 17.r),
        child: ConditionalSwitch.single<String>(
          context: context,
          valueBuilder: (context) => HomeController.to.statusMenu.value,
          caseBuilders: {
            'loading': (context) => const LoadingMenuList(),
            'empty': (context) => EmptyDataVertical(width: 100.r),
            'error': (context) => CustomErrorVertical(
                  message: HomeController.to.messageMenu.value,
                ),
          },
          fallbackBuilder: (context) => MenuList(
            data: HomeController.to.drinkMenu,
          ),
        ),
      ),
      17.verticalSpacingRadius,
    ];
  }
}
