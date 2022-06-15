import 'package:get/get.dart';
import 'package:java_code_app/modules/features/menu/controllers/detail_menu_controller.dart';

class DetailMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailMenuController());
  }
}
