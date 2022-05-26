import 'package:get/get.dart';
import 'package:java_code_app/modules/features/login/repositories/login_repository.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find<AuthController>();

  /// Login dengan email dan kata sandi
  /// @author: Saddam Azy
  ///
  /// [email] String
  /// [password] String
  void loginWithEmailAndPassword(String email, String password) async {
    if (email.isEmpty || password.isEmpty) return;

    UserRes userRes =
        await LoginRepository.getUserWithEmailAndPassword(email, password);

    if (userRes.statusCode == 200) {
      /// Mengatur token
      await LocalDBServices.setToken(userRes.token!);

      /// Pergi ke halaman home
      Get.offNamed('/home');
    } else if (userRes.statusCode == 422 || userRes.statusCode == 204) {
      Get.showSnackbar(GetSnackBar(
        title: 'error'.tr,
        message: 'account_incorrect'.tr,
        duration: const Duration(seconds: 2),
      ));
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'error'.tr,
        message: userRes.message ?? 'unknown_error'.tr,
        duration: const Duration(seconds: 2),
      ));
    }
  }
}
