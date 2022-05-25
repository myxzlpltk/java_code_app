import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/modules/features/home/view/ui/home_view.dart';

class AppPages {
  /// Memastikan bahwa class ini tidak bisa diinstansiasi
  AppPages._();

  static List<GetPage> pages() {
    return [
      GetPage(
        name: AppRoutes.homeView,
        page: () => HomeView(),
      ),
    ];
  }
}
