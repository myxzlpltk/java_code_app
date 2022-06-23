import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/modules/features/dashboard/view/ui/get_location_view.dart';
import 'package:java_code_app/modules/global_controllers/global_controller.dart';
import 'package:java_code_app/utils/services/location_services.dart';
import 'package:uni_links/uni_links.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();

  @override
  void onReady() {
    super.onReady();

    /// Mencari lokasi
    getLocation().then((_) => uniLinksCheck());
    LocationServices.streamService.listen((status) => getLocation());
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
    if (Get.isDialogOpen == false) {
      Get.dialog(const GetLocationView(), barrierDismissible: false);
    }

    try {
      /// Mendapatkan lokasi saat ini
      statusLocation.value = 'loading';
      final locationResult = await LocationServices.getCurrentPosition();

      if (locationResult.success) {
        /// Jika jarak lokasi cukup dekat, dapatkan informasi alamat
        position.value = locationResult.position;
        address.value = locationResult.address;
        statusLocation.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        Get.until(ModalRoute.withName(AppRoutes.dashboardView));
      } else {
        /// Jika jarak lokasi tidak cukup dekat, tampilkan pesan
        statusLocation.value = 'error';
        messageLocation.value = locationResult.message!;
      }
    } catch (e) {
      /// Jika terjadi kesalahan server
      statusLocation.value = 'error';
      messageLocation.value = 'Server error'.tr;
    }
  }

  Future<void> uniLinksCheck() async {
    /// Mendapatkan uri saat ini
    var uri = await getInitialUri();
    if (uri != null) {
      /// Jika ada uri, proses uni links
      GlobalController.to.processUniLinks(uri);
    }
  }
}
