import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/modules/features/home/view/ui/home_view.dart';
import 'package:java_code_app/modules/features/login/view/ui/login_view.dart';
import 'package:java_code_app/modules/features/splash/view/ui/splash_view.dart';

class AppPages {
  /// Memastikan bahwa class ini tidak bisa diinstansiasi
  AppPages._();

  static List<GetPage> pages() {
    return [
      GetPage(
        name: AppRoutes.splashView,
        page: () => const SplashView(),
      ),
      GetPage(
        name: AppRoutes.loginView,
        page: () => LoginView(),
      ),
      GetPage(
        name: AppRoutes.homeView,
        page: () => HomeView(),
      ),
    ];
  }
}
