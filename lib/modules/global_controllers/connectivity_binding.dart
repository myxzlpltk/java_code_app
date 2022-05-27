import 'package:get/get.dart';
import 'package:java_code_app/modules/global_controllers/connectivity_controller.dart';

class ConnectivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ConnectivityController>(ConnectivityController(), permanent: true);
  }
}
