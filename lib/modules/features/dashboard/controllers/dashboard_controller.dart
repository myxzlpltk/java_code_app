import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/modules/features/home/view/ui/get_location_view.dart';
import 'package:java_code_app/utils/services/location_services.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();

  @override
  void onReady() {
    super.onReady();

    /// Mencari lokasi
    Future.delayed(const Duration(milliseconds: 500), () async {
      Get.dialog(const GetLocationView(), barrierDismissible: false);
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
      /// Mendapatkan lokasi saat ini
      position.value = await LocationServices.getCurrentPosition();

      if (LocationServices.isDistanceClose(position.value!)) {
        /// Jika jarak lokasi cukup dekat, dapatkan informasi alamat
        address.value = await LocationServices.getAddress(position.value!);
        statusLocation.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        Get.until((route) => Get.isDialogOpen == false);
      } else {
        /// Jika jarak lokasi tidak cukup dekat, tampilkan pesan
        statusLocation.value = 'error';
        messageLocation.value = 'Distance not close'.tr;
      }
    } catch (e) {
      /// Jika terjadi kesalahan server
      statusLocation.value = 'error';
      messageLocation.value = 'Server error'.tr;
    }
  }
}
