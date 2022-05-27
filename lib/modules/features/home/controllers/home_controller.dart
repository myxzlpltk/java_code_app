import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/modules/features/home/repositories/promo_repository.dart';
import 'package:java_code_app/modules/features/home/view/components/get_location_dialog.dart';
import 'package:java_code_app/modules/models/promo.dart';
import 'package:java_code_app/utils/services/location_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxString statusLocation = RxString('loading');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();

  RxString statusPromo = RxString('loading');
  RxString messagePromo = RxString('');
  RxList<Promo> listPromo = RxList<Promo>();

  @override
  void onReady() async {
    super.onReady();

    Get.dialog(const GetLocationDialog(), barrierDismissible: false);
    await getLocation();
    await getPromo();
  }

  /// Get current location if location not exists
  Future<void> getLocation() async {
    try {
      position.value = await LocationServices.getCurrentPosition();

      if (LocationServices.isDistanceClose(position.value!)) {
        address.value = await LocationServices.getAddress(position.value!);
        statusLocation.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        Get.back();
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
  Future<void> getPromo() async {
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

  /// Go To Detail Promo Page
  void viewDetailPromo(int index) {
    Get.toNamed(
      AppRoutes.detailPromoView,
      arguments: listPromo.elementAt(index),
    );
  }

  /// Share current promo
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> sharePromo() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    String fileName = '${DateTime.now().microsecondsSinceEpoch}.png';
    String path = '$directory/$fileName';

    await screenshotController.captureAndSave(directory, fileName: fileName);
    await Share.shareFiles([path], subject: 'get_this_promo'.tr);
    await File(path).delete();
  }
}
