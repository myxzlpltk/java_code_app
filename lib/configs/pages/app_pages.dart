// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/modules/features/dashboard/view/ui/dashboard_view.dart';
import 'package:java_code_app/modules/features/dashboard/view/ui/detail_promo_view.dart';
import 'package:java_code_app/modules/features/dashboard/view/ui/get_location_view.dart';
import 'package:java_code_app/modules/features/login/view/ui/login_view.dart';
import 'package:java_code_app/modules/features/splash/view/ui/splash_view.dart';
import 'package:java_code_app/shared/widgets/network_error_view.dart';

class AppPages {
  /// Memastikan bahwa class ini tidak bisa diinstansiasi
  AppPages._();

  static List<GetPage> pages() {
    return [
      /// Default app
      GetPage(
        name: AppRoutes.noInternetView,
        page: () => NetworkErrorView(),
      ),

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
        name: AppRoutes.homeView,
        page: () => DashboardView(),
      ),
      GetPage(
        name: AppRoutes.getLocationView,
        page: () => GetLocationView(),
      ),
      GetPage(
        name: AppRoutes.detailPromoView,
        page: () => DetailPromoView(),
      ),
    ];
  }
}
