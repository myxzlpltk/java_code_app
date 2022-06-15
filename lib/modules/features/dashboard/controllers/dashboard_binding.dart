import 'package:get/get.dart';
import 'package:java_code_app/modules/features/cart/controllers/cart_controller.dart';
import 'package:java_code_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:java_code_app/modules/features/home/controllers/home_controller.dart';
import 'package:java_code_app/modules/features/order/controllers/order_controller.dart';
import 'package:java_code_app/modules/features/profile/controllers/profile_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    /// Inisialisasi dashboard controller
    Get.put(DashboardController());

    /// Inisialisasi cart controller
    Get.lazyPut(() => CartController());

    /// Inisialisasi home, order, profile
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => ProfileController());
  }
}
