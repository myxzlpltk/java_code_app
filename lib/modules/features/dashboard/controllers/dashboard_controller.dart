import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/utils/services/location_services.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();

  @override
  void onReady() {
    super.onReady();

    /// Mencari lokasi
    Future.delayed(const Duration(milliseconds: 500), () async {
      Get.toNamed(AppRoutes.getLocationView);
      await getLocation();
    });
  }

  /// Navigation bar
  RxInt tabIndex = RxInt(0);

  /// Change tab index
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  /// Location
  RxString statusLocation = RxString('loading');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();

  /// Get current location if location not exists
  Future<void> getLocation() async {
    try {
      position.value = await LocationServices.getCurrentPosition();

      if (LocationServices.isDistanceClose(position.value!)) {
        address.value = await LocationServices.getAddress(position.value!);
        statusLocation.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        Get.back(closeOverlays: true);
      } else {
        statusLocation.value = 'error';
        messageLocation.value = 'Distance not close'.tr;
      }
    } catch (e) {
      statusLocation.value = 'error';
      messageLocation.value = 'Server error'.tr;
    }
  }
}
