import 'package:get/get.dart';
import 'package:java_code_app/modules/global_controllers/global_controller.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';
import 'package:uni_links/uni_links.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find<SplashController>();

  @override
  void onInit() async {
    super.onInit();

    await Future.delayed(const Duration(seconds: 1));
    var user = await LocalDBServices.getUser();
    var token = await LocalDBServices.getToken();
    var uri = await getInitialUri();

    if (!GlobalController.to.internetStatus.value) {
      await GlobalController.to.showAlert();
    }

    if (user != null && token != null) {
      if (uri is Uri) {
        Get.offAllNamed('/dashboard');
        GlobalController.to.processUniLinks(uri);
      } else {
        /// Jika ada sesi ke halaman dashboard
        Get.offAllNamed('/dashboard');
      }
    } else {
      /// Jika tidak ada sesi ke halaman login
      Get.offAllNamed('/login');
    }
  }
}
