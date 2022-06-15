import 'package:get/get.dart';
import 'package:java_code_app/modules/features/splash/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
