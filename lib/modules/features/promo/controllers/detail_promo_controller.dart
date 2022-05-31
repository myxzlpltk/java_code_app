import 'dart:io';

import 'package:get/get.dart';
import 'package:java_code_app/constants/commons/constants.dart';
import 'package:java_code_app/modules/features/promo/repositories/promo_repository.dart';
import 'package:java_code_app/modules/models/promo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class DetailPromoController extends GetxController {
  static DetailPromoController get to => Get.find();

  RxString status = RxString('loading');
  Rxn<Promo> promo = Rxn<Promo>();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments is Promo) {
      status.value = 'success';
      promo.value = Get.arguments as Promo;
    } else if (Get.arguments is int) {
      setFromId(Get.arguments as int);
    }
  }

  Future<void> setFromId(int id) async {
    final promoRes = await PromoRepository.getFromId(id);

    if (promoRes.status_code == 200) {
      status.value = 'success';
      promo.value = promoRes.data;
    } else {
      status.value = 'error';
    }
  }

  /// Share current promo
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> sharePromo() async {
    if (promo.value == null) return;

    final directory = (await getApplicationDocumentsDirectory()).path;
    String fileName = '${DateTime.now().microsecondsSinceEpoch}.png';
    String path = '$directory/$fileName';

    await screenshotController.captureAndSave(directory, fileName: fileName);
    await Share.shareFiles(
      [path],
      text: 'get_this_promo'.trParams({
        'link': '$appDeepLink?id_promo=${promo.value!.id_promo}',
      }),
    );
    await File(path).delete();
  }
}
