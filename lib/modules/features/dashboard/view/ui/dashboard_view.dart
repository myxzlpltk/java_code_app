import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:java_code_app/modules/features/dashboard/view/ui/home_view.dart';
import 'package:java_code_app/modules/features/dashboard/view/ui/order_view.dart';
import 'package:java_code_app/modules/features/dashboard/view/ui/profile_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: DashboardController.to.tabIndex.value,
          children: const [
            HomeView(),
            OrderView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
        child: Obx(
          () => BottomNavigationBar(
            onTap: DashboardController.to.changeTabIndex,
            currentIndex: DashboardController.to.tabIndex.value,
            backgroundColor: darkColor2,
            selectedLabelStyle: Theme.of(context).textTheme.caption,
            unselectedLabelStyle: Theme.of(context).textTheme.caption,
            selectedItemColor: Colors.white,
            unselectedItemColor: greyColor,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: SvgPicture.asset(
                    AssetConst.iconHome,
                    color: greyColor,
                    height: 27.h,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: SvgPicture.asset(
                    AssetConst.iconHome,
                    color: Colors.white,
                    height: 27.h,
                  ),
                ),
                label: 'home'.tr,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: SvgPicture.asset(
                    AssetConst.iconOrder,
                    color: greyColor,
                    height: 27.h,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: SvgPicture.asset(
                    AssetConst.iconOrder,
                    color: Colors.white,
                    height: 27.h,
                  ),
                ),
                label: 'order'.tr,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: SvgPicture.asset(
                    AssetConst.iconProfile,
                    color: greyColor,
                    height: 27.h,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: SvgPicture.asset(
                    AssetConst.iconProfile,
                    color: Colors.white,
                    height: 27.h,
                  ),
                ),
                label: 'profile'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}