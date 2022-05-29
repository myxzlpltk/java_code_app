import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/modules/features/home/repositories/promo_repository.dart';
import 'package:java_code_app/modules/models/promo.dart';
import 'package:java_code_app/utils/services/location_services.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxString statusLocation = RxString('loading');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();

  RxString statusPromo = RxString('loading');
  RxString messagePromo = RxString('');
  RxList<Promo> listPromo = RxList<Promo>();

  RxString filterMenu = RxString('all');

  @override
  void onReady() {
    super.onReady();

    /// Mencari lokasi
    Future.delayed(const Duration(milliseconds: 500), () async {
      Get.toNamed(AppRoutes.getLocationView);
      await getLocation();
    });

    /// Mendapatkan promo
    getListPromo();
  }

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
        messageLocation.value = 'distance_not_close'.tr;
      }
    } catch (e) {
      statusLocation.value = 'error';
      messageLocation.value = e.toString();
    }
  }

  /// Get all promo
  Future<void> getListPromo() async {
    statusPromo.value = 'loading';

    try {
      var listPromoRes = await PromoRepository.getAll();

      if (listPromoRes.status_code == 200) {
        statusPromo.value = 'success';
        listPromo.value = listPromoRes.data!;
      } else if (listPromoRes.status_code == 204) {
        statusPromo.value = 'error';
        messagePromo.value = 'no_data'.tr;
      } else {
        statusPromo.value = 'error';
        messagePromo.value = listPromoRes.message ?? 'unknown_error'.tr;
      }
    } catch (e) {
      statusPromo.value = 'error';
      messagePromo.value = e.toString();
    }
  }

  Future<void> setFilterMenu(String value) async {
    filterMenu.value = value;
  }
}
