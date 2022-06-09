import 'package:get/get.dart';
import 'package:java_code_app/modules/features/cart/controllers/cart_controller.dart';
import 'package:java_code_app/modules/global_controllers/global_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    /// Inisialisasi global controller dan cart controller
    Get.put<GlobalController>(GlobalController(), permanent: true);
    Get.put<CartController>(CartController(), permanent: true);
  }
}
