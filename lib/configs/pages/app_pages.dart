// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/modules/features/cart/view/ui/cart_view.dart';
import 'package:java_code_app/modules/features/cart/view/ui/choose_voucher_view.dart';
import 'package:java_code_app/modules/features/cart/view/ui/detail_voucher_view.dart';
import 'package:java_code_app/modules/features/dashboard/view/ui/dashboard_view.dart';
import 'package:java_code_app/modules/features/dashboard/view/ui/get_location_view.dart';
import 'package:java_code_app/modules/features/login/view/ui/login_view.dart';
import 'package:java_code_app/modules/features/menu/view/ui/detail_menu_view.dart';
import 'package:java_code_app/modules/features/promo/view/ui/detail_promo_view.dart';
import 'package:java_code_app/modules/features/splash/view/ui/splash_view.dart';

class AppPages {
  /// Memastikan bahwa class ini tidak bisa diinstansiasi
  AppPages._();

  static List<GetPage> pages() {
    return [
      /// Otentikasi
      GetPage(
        name: AppRoutes.splashView,
        page: () => SplashView(),
      ),
      GetPage(
        name: AppRoutes.loginView,
        page: () => LoginView(),
      ),

      /// Home
      GetPage(
        name: AppRoutes.dashboardView,
        page: () => DashboardView(),
      ),
      GetPage(
        name: AppRoutes.getLocationView,
        page: () => GetLocationView(),
      ),

      /// Menu dan Promo
      GetPage(
        name: AppRoutes.detailPromoView,
        page: () => DetailPromoView(),
      ),
      GetPage(
        name: AppRoutes.detailMenuView,
        page: () => DetailMenuView(),
      ),

      /// Cart
      GetPage(
        name: AppRoutes.cartView,
        page: () => CartView(),
      ),
      GetPage(
        name: AppRoutes.chooseVoucherView,
        page: () => ChooseVoucherView(),
      ),
      GetPage(
        name: AppRoutes.detailVoucherView,
        page: () => DetailVoucherView(),
      ),
    ];
  }
}
