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
import 'package:java_code_app/modules/features/dashboard/controllers/home_controller.dart';
import 'package:java_code_app/modules/features/dashboard/view/components/filter_menu.dart';
import 'package:java_code_app/modules/features/dashboard/view/components/search_bar.dart';
import 'package:java_code_app/shared/styles/shapes.dart';
import 'package:java_code_app/shared/widgets/menu_card.dart';
import 'package:java_code_app/shared/widgets/promo_card.dart';
import 'package:java_code_app/shared/widgets/rect_shimmer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.any([
          HomeController.to.getListPromo(),
          HomeController.to.getListMenu(),
        ]),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              forceElevated: true,
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  Expanded(
                    child: SearchBar(
                      onChanged: HomeController.to.setFilterMenu,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.toNamed(AppRoutes.cartView),
                    icon: Obx(
                      () => Badge(
                        showBadge: CartController.to.cart.isNotEmpty,
                        badgeColor: blueColor,
                        badgeContent: Text(
                          CartController.to.cart.length.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.white),
                        ),
                        child: const Icon(Icons.shopping_cart),
                      ),
                    ),
                    color: Colors.black,
                  ),
                ],
              ),
              shape: CustomShape.bottomRoundedShape,
            ),

            /// Promo section
            SliverList(
              delegate: SliverChildListDelegate(promoSection(context)),
            ),

            /// Menu section
            SliverList(
              delegate: SliverChildListDelegate(menuSection(context)),
            ),

            /// Food and drink section
            SliverToBoxAdapter(
              child: Obx(
                () => Column(
                  children: [
                    if (HomeController.to.categoryMenu.value == 'all' ||
                        HomeController.to.categoryMenu.value == 'Food')
                      ...foodSection(context),
                    if (HomeController.to.categoryMenu.value == 'all' ||
                        HomeController.to.categoryMenu.value == 'Drink')
                      ...drinkSection(context),
                  ],
                ),
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
      SizedBox(height: 25.h),

      /// Promo Section - Title
      Row(
        children: [
          SizedBox(width: 25.w),
          SvgPicture.asset(AssetConst.iconPromo, width: 23.w),
          SizedBox(width: 10.w),
          Text(
            'Available promo'.tr,
            style: Theme.of(context).textTheme.titleMedium,
          ),
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
            valueBuilder: (context) => HomeController.to.statusPromo.value,
            caseBuilders: {
              'loading': (context) => ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 15.h,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, _) => RectShimmer(
                      width: 282.w,
                      height: 158.h,
                      radius: 15.w,
                    ),
                    itemCount: 5,
                    separatorBuilder: (context, _) => SizedBox(width: 25.w),
                  ),
              'error': (context) => Center(
                    child: Text(HomeController.to.messagePromo.value),
                  ),
            },
            fallbackBuilder: (context) => ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 15.h,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => PromoCard(
                promo: HomeController.to.listPromo.elementAt(index),
                onTap: () => Get.toNamed(
                  AppRoutes.detailPromoView,
                  arguments: HomeController.to.listPromo.elementAt(index),
                ),
              ),
              itemCount: HomeController.to.listPromo.length,
              separatorBuilder: (context, index) => SizedBox(width: 25.w),
            ),
          ),
        ),
      ),
      SizedBox(height: 5.h),
    ];
  }

  /// Menu section
  List<Widget> menuSection(BuildContext context) {
    return [
      /// Filter
      SizedBox(
        height: 45.h,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
          children: [
            Obx(
                  () => FilterMenu(
                    isSelected: HomeController.to.categoryMenu.value == 'all',
                onTap: () => HomeController.to.setCategoryMenu('all'),
                iconPath: AssetConst.iconList,
                text: 'All menu'.tr,
              ),
            ),
            SizedBox(width: 13.w),
            Obx(
              () => FilterMenu(
                isSelected: HomeController.to.categoryMenu.value == 'Food',
                onTap: () => HomeController.to.setCategoryMenu('Food'),
                iconPath: AssetConst.iconFood,
                text: 'Food'.tr,
              ),
            ),
            SizedBox(width: 13.w),
            Obx(
              () => FilterMenu(
                isSelected: HomeController.to.categoryMenu.value == 'Drink',
                onTap: () => HomeController.to.setCategoryMenu('Drink'),
                iconPath: AssetConst.iconDrink,
                text: 'Drink'.tr,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 17.h),
    ];
  }

  /// Food section
  List<Widget> foodSection(BuildContext context) {
    return [
      Row(
        children: [
          SizedBox(width: 25.w),
          SvgPicture.asset(
            AssetConst.iconFood,
            width: 20.r,
            height: 20.r,
            color: blueColor,
          ),
          SizedBox(width: 10.w),
          Text(
            'Food'.tr,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: blueColor),
          ),
        ],
      ),

      /// Food Section - List
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 17.h),
        child: ConditionalSwitch.single<String>(
          context: context,
          valueBuilder: (context) => HomeController.to.statusMenu.value,
          caseBuilders: {
            'loading': (context) => Wrap(
                  runSpacing: 17.h,
                  children: List.generate(
                    2,
                    (i) => RectShimmer(height: 89.h, radius: 10.w),
                  ),
                ),
            'error': (context) => Center(
                  child: Text(
                    HomeController.to.messageMenu.value,
                    textAlign: TextAlign.center,
                  ),
                ),
          },
          fallbackBuilder: (context) {
            final foods = HomeController.to.foodMenu;

            if (foods.isEmpty) {
              return Center(
                child: Text('No data'.tr, textAlign: TextAlign.center),
              );
            } else {
              return Wrap(
                runSpacing: 17.h,
                children: foods
                    .map<Widget>(
                      (menu) => MenuCard(
                        menu: menu,
                        simple: true,
                        onTap: () {
                          Get.toNamed(AppRoutes.detailMenuView,
                              arguments: menu);
                        },
                      ),
                    )
                    .toList(),
              );
            }
          },
        ),
      ),
      SizedBox(height: 17.h),
    ];
  }

  /// Drink section
  List<Widget> drinkSection(BuildContext context) {
    return [
      Row(
        children: [
          SizedBox(width: 25.w),
          SvgPicture.asset(
            AssetConst.iconDrink,
            width: 20.r,
            height: 20.r,
            color: blueColor,
          ),
          SizedBox(width: 10.w),
          Text(
            'Drink'.tr,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: blueColor),
          ),
          SizedBox(width: 25.w),
        ],
      ),

      /// Drink Section - List
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 17.h),
        child: ConditionalSwitch.single<String>(
          context: context,
          valueBuilder: (context) => HomeController.to.statusMenu.value,
          caseBuilders: {
            'loading': (context) => Wrap(
                  runSpacing: 17.h,
                  children: List.generate(
                    2,
                    (i) => RectShimmer(height: 89.h, radius: 10.w),
                  ),
                ),
            'error': (context) => Center(
                  child: Text(
                    HomeController.to.messageMenu.value,
                    textAlign: TextAlign.center,
                  ),
                ),
          },
          fallbackBuilder: (context) {
            final foods = HomeController.to.drinkMenu;

            if (foods.isEmpty) {
              return Center(
                child: Text('No data'.tr, textAlign: TextAlign.center),
              );
            } else {
              return Wrap(
                runSpacing: 17.h,
                children: foods
                    .map<Widget>(
                      (menu) => MenuCard(
                        menu: menu,
                        simple: true,
                        onTap: () {
                          Get.toNamed(AppRoutes.detailMenuView,
                              arguments: menu);
                        },
                      ),
                    )
                    .toList(),
              );
            }
          },
        ),
      ),
      SizedBox(height: 17.h),
    ];
  }
}
