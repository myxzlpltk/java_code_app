import 'package:get/get.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find<SplashController>();

  @override
  void onInit() async {
    super.onInit();

    await Future.delayed(const Duration(seconds: 1));
    var user = await LocalDBServices.getUser();
    var token = await LocalDBServices.getToken();

    if (user != null && token != null) {
      /// Jika ada sesi ke halaman home
      Get.offNamed('/home');
    } else {
      /// Jika tidak ada sesi ke halaman login
      Get.offNamed('/login');
    }
  }
}
