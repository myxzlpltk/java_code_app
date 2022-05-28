import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:java_code_app/modules/features/login/repositories/login_repository.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();

  /// Login dengan email dan kata sandi
  /// @author: Saddam Azy (myxzlpltk@gmail.com)
  ///
  /// [email] String
  /// [password] String
  void loginWithEmailAndPassword(String email, String password) async {
    /// Memanggil API repository
    UserRes userRes =
        await LoginRepository.getUserWithEmailAndPassword(email, password);

    if (userRes.status_code == 200) {
      /// Mengatur token dan user
      await LocalDBServices.setUser(userRes.user!);
      await LocalDBServices.setToken(userRes.token!);

      /// Pergi ke halaman home
      Get.offAllNamed('/home');
    } else if (userRes.status_code == 422 || userRes.status_code == 204) {
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

  /// Login dengan akun google
  /// @author: Saddam Azy (myxzlpltk@gmail.com)
  void loginWithGoogle() async {
    /// Singleton GoogleSignIn
    final GoogleSignIn googleSignIn = GoogleSignIn();

    /// Sign out dari akun saat ini (apabila ada) dan sign in
    await googleSignIn.signOut();

    GoogleSignInAccount? account = await googleSignIn.signIn();

    if (account == null) throw Exception('error');

    /// Memanggil API repository
    UserRes userRes = await LoginRepository.getUserFromGoogle(
        account.displayName ?? '-', account.email);

    if (userRes.status_code == 200) {
      /// Mengatur token dan user
      await LocalDBServices.setUser(userRes.user!);
      await LocalDBServices.setToken(userRes.token!);

      /// Pergi ke halaman home
      Get.offNamed('/home');
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'error'.tr,
        message: 'unknown_error'.tr,
        duration: const Duration(seconds: 2),
      ));
    }
  }
}
