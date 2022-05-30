import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:java_code_app/modules/features/dashboard/view/components/filter_menu.dart';
import 'package:java_code_app/modules/features/dashboard/view/components/menu_card.dart';
import 'package:java_code_app/modules/features/dashboard/view/components/promo_card.dart';
import 'package:java_code_app/modules/features/dashboard/view/components/search_bar.dart';
import 'package:java_code_app/shared/widgets/rect_shimmer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.any([
            DashboardController.to.getListPromo(),
            DashboardController.to.getListMenu(),
          ]);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              forceElevated: true,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: SearchBar(onChanged: DashboardController.to.setFilterMenu),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30.w),
                ),
              ),
            ),

            /// Promo section
            SliverList(
              delegate: SliverChildListDelegate(promoSection(context)),
            ),

            /// Menu section
            SliverToBoxAdapter(
              child: Obx(
                () => Column(
                  children: [
                    ...menuSection(context),
                    if (DashboardController.to.categoryMenu.value == 'all' ||
                        DashboardController.to.categoryMenu.value == 'food')
                      ...foodSection(context),
                    if (DashboardController.to.categoryMenu.value == 'all')
                      SizedBox(width: 25.w),
                    if (DashboardController.to.categoryMenu.value == 'all' ||
                        DashboardController.to.categoryMenu.value == 'drink')
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
            'available_promo'.tr,
            style: Theme.of(context).textTheme.headline6,
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
            valueBuilder: (context) => DashboardController.to.statusPromo.value,
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
                    child: Text(DashboardController.to.messagePromo.value),
                  ),
            },
            fallbackBuilder: (context) => ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 15.h,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => PromoCard(
                promo: DashboardController.to.listPromo.elementAt(index),
                onTap: () => Get.toNamed(
                  AppRoutes.detailPromoView,
                  arguments: DashboardController.to.listPromo.elementAt(index),
                ),
              ),
              itemCount: DashboardController.to.listPromo.length,
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
                isSelected: DashboardController.to.categoryMenu.value == 'all',
                onTap: () => DashboardController.to.setCategoryMenu('all'),
                iconPath: AssetConst.iconList,
                text: 'all_menu'.tr,
              ),
            ),
            SizedBox(width: 13.w),
            Obx(
              () => FilterMenu(
                isSelected: DashboardController.to.categoryMenu.value == 'food',
                onTap: () => DashboardController.to.setCategoryMenu('food'),
                iconPath: AssetConst.iconFood,
                text: 'food'.tr,
              ),
            ),
            SizedBox(width: 13.w),
            Obx(
              () => FilterMenu(
                isSelected:
                    DashboardController.to.categoryMenu.value == 'drink',
                onTap: () => DashboardController.to.setCategoryMenu('drink'),
                iconPath: AssetConst.iconDrink,
                text: 'drink'.tr,
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
          SvgPicture.asset(AssetConst.iconFood, width: 23.w, color: blueColor),
          SizedBox(width: 10.w),
          Text(
            'food'.tr,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: blueColor,
                ),
          ),
        ],
      ),

      /// Food Section - List
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 17.h),
        child: ConditionalSwitch.single<String>(
          context: context,
          valueBuilder: (context) => DashboardController.to.statusMenu.value,
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
                    DashboardController.to.messageMenu.value,
                    textAlign: TextAlign.center,
                  ),
                ),
          },
          fallbackBuilder: (context) {
            final foods = DashboardController.to.foodMenu;

            if (foods.isEmpty) {
              return Center(
                child: Text('no_data'.tr, textAlign: TextAlign.center),
              );
            } else {
              return Wrap(
                runSpacing: 17.h,
                children: foods
                    .map<Widget>(
                      (menu) => MenuCard(
                        menu: menu,
                        simple: true,
                        onTap: () {},
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
          SvgPicture.asset(AssetConst.iconDrink, width: 23.w, color: blueColor),
          SizedBox(width: 10.w),
          Text(
            'drink'.tr,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: blueColor,
                ),
          ),
          SizedBox(width: 25.w),
        ],
      ),

      /// Drink Section - List
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 17.h),
        child: ConditionalSwitch.single<String>(
          context: context,
          valueBuilder: (context) => DashboardController.to.statusMenu.value,
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
                    DashboardController.to.messageMenu.value,
                    textAlign: TextAlign.center,
                  ),
                ),
          },
          fallbackBuilder: (context) {
            final foods = DashboardController.to.drinkMenu;

            if (foods.isEmpty) {
              return Center(
                child: Text('no_data'.tr, textAlign: TextAlign.center),
              );
            } else {
              return Wrap(
                runSpacing: 17.h,
                children: foods
                    .map<Widget>(
                      (menu) => MenuCard(
                        menu: menu,
                        simple: true,
                        onTap: () {},
                      ),
                    )
                    .toList(),
              );
            }
          },
        ),
      ),
    ];
  }
}
