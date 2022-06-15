import 'package:get/get.dart';
import 'package:java_code_app/modules/features/order/controllers/detail_order_controller.dart';

class DetailOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailOrderController());
  }
}
