import 'package:get/get.dart';
import 'package:java_code_app/modules/features/promo/controllers/detail_promo_controller.dart';

class DetailPromoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailPromoController());
  }
}
