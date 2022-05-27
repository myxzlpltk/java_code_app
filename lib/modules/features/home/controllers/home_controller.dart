import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/modules/features/home/view/components/get_location_dialog.dart';
import 'package:java_code_app/utils/services/location_services.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxString status = RxString('loading');
  RxString message = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();

  @override
  void onReady() async {
    super.onReady();

    Get.dialog(const GetLocationDialog(), barrierDismissible: false);
    await getLocation();
  }

  /// Get current location if location not exists
  Future<void> getLocation() async {
    try {
      position.value = await LocationServices.getCurrentPosition();

      if (LocationServices.isDistanceClose(position.value!)) {
        address.value = await LocationServices.getAddress(position.value!);
        status.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        Get.back();
      } else {
        status.value = 'error';
        message.value = 'distance_not_close'.tr;
      }
    } catch (e) {
      status.value = 'error';
      message.value = e.toString();
    }
  }
}
