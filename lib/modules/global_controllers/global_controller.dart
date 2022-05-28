import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';

class GlobalController extends GetxController {
  /// Instance dari connectivity_plus
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();

    checkConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectivity);
  }

  void checkConnectivity() {
    _connectivity.checkConnectivity().then(_updateConnectivity);
  }

  void _updateConnectivity(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        if (Get.currentRoute == AppRoutes.noInternetView) Get.back();
        break;
      default:
        Get.toNamed(AppRoutes.noInternetView);
        break;
    }
  }
}
