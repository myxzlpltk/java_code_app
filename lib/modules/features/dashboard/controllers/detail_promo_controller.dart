import 'dart:io';

import 'package:get/get.dart';
import 'package:java_code_app/constants/commons/constants.dart';
import 'package:java_code_app/modules/features/dashboard/repositories/promo_repository.dart';
import 'package:java_code_app/modules/models/promo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class DetailPromoController extends GetxController {
  static DetailPromoController get to => Get.find();

  late Rx<Promo> promo;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments is Promo) {
      promo = Rx<Promo>(Get.arguments as Promo);
    }
  }

  Future<void> setFromId(int id_promo) async {
    final promoRes = await PromoRepository.getFromId(id_promo);

    if (promoRes.status_code == 200) {
      promo = Rx<Promo>(promoRes.data!);
    } else {
      return Future.error(promoRes.message!);
    }
  }

  /// Share current promo
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> sharePromo() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    String fileName = '${DateTime.now().microsecondsSinceEpoch}.png';
    String path = '$directory/$fileName';

    await screenshotController.captureAndSave(directory, fileName: fileName);
    await Share.shareFiles(
      [path],
      text: 'get_this_promo'.trParams({
        'link': '$appDeepLink?id_promo=${promo.value.id_promo}',
      }),
    );
    await File(path).delete();
  }
}
