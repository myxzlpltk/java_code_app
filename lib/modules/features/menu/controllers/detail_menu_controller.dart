import 'package:get/get.dart';
import 'package:java_code_app/modules/models/menu.dart';

class DetailMenuController extends GetxController {
  static DetailMenuController get to => Get.find();

  Rxn<Menu> menu = Rxn<Menu>();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments is Menu) {
      menu.value = Get.arguments as Menu;
    }
  }

  void onIncrement() {}

  void onDecrement() {}
}
