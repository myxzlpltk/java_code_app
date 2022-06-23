import 'package:get/get.dart';
import 'package:java_code_app/configs/localizations/localization.dart';
import 'package:java_code_app/modules/global_controllers/global_controller.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';
import 'package:uni_links/uni_links.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find<SplashController>();

  @override
  Future<void> onInit() async {
    super.onInit();

    /// Delay 1 detik
    await Future.delayed(const Duration(seconds: 1));

    /// Mendapatkan bahasa saat ini
    var language = await LocalDBServices.getLanguage();
    if (language != null) {
      Localization.changeLocale(language);
    }

    /// Cek koneksi internet
    if (!GlobalController.to.internetStatus.value) {
      await GlobalController.to.showAlert();
    }

    /// Mendapatkan user dan token dari local DB service
    var user = await LocalDBServices.getUser();
    var token = await LocalDBServices.getToken();

    /// Jika ada sesi login
    if (user != null && token != null) {
      /// Ke halaman utama
      Get.offAllNamed('/dashboard');

      /// Mendapatkan uri saat ini
      var uri = await getInitialUri();
      if (uri != null) {
        /// Jika ada uri, proses uni links
        GlobalController.to.processUniLinks(uri);
      }
    } else {
      /// Jika tidak ada sesi ke halaman login
      Get.offAllNamed('/login');
    }
  }
}
