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

  /// Data promo
  RxString status = RxString('loading');
  Rxn<Promo> promo = Rxn<Promo>();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments is Promo) {
      /// Jika argument adalah promo, tampilkan
      status.value = 'success';
      promo.value = Get.arguments as Promo;
    } else if (Get.arguments is int) {
      /// Jika argument adalah id promo, ambil dari API
      setFromId(Get.arguments as int);
    }
  }

  /// Set data promo dari id
  Future<void> setFromId(int id) async {
    /// Mengambil data promo dari API
    final promoRes = await PromoRepository.getFromId(id);

    if (promoRes.status_code == 200) {
      /// Jika status sukses, tampilkan
      status.value = 'success';
      promo.value = promoRes.data;
    } else {
      status.value = 'error';
    }
  }

  /// Screenshot controller
  ScreenshotController screenshotController = ScreenshotController();

  /// Bagikan promo
  Future<void> sharePromo() async {
    /// Jika promo belum ada, batalkan
    if (promo.value == null) return;

    /// Tentukan path gambar
    final directory = (await getApplicationDocumentsDirectory()).path;
    String fileName = '${DateTime.now().microsecondsSinceEpoch}.png';
    String path = '$directory/$fileName';

    /// Ambil screenshot
    await screenshotController.captureAndSave(directory, fileName: fileName);

    /// Bagikan screenshot
    await Share.shareFiles(
      [path],
      text: 'Get this promo'.trParams({
        'link': '${AppConst.appDeepLink}?id_promo=${promo.value!.id_promo}',
      }),
    );

    /// Hapus gambar
    await File(path).delete();
  }
}
