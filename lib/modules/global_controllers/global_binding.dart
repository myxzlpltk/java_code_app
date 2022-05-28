import 'package:get/get.dart';
import 'package:java_code_app/modules/global_controllers/global_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GlobalController>(GlobalController(), permanent: true);
  }
}
