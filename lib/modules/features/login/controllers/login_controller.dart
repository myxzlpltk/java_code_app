import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:java_code_app/modules/features/login/repositories/login_repository.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/shared/customs/error_snack_bar.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();

  /// Login dengan email dan kata sandi
  void loginWithEmailAndPassword(String email, String password) async {
    /// Memanggil API repository
    UserRes userRes = await LoginRepository.getUser(email, password);

    if (userRes.status_code == 200) {
      /// Mengatur token dan user
      await LocalDBServices.setUser(userRes.user!);
      await LocalDBServices.setToken(userRes.token!);

      /// Pergi ke halaman dashboard
      Get.offAllNamed('/dashboard');
    } else if (userRes.status_code == 422 || userRes.status_code == 204) {
      /// Tampilkan snackbar jika username atau password salah
      Get.showSnackbar(ErrorSnackBar(
        title: 'Something went wrong'.tr,
        message: 'Email or password is incorrect'.tr,
      ));
    } else {
      /// Tampilkan snackbar error tidak diketahui
      Get.showSnackbar(ErrorSnackBar(
        title: 'Something went wrong'.tr,
        message: userRes.message ?? 'Unknown error'.tr,
      ));
    }
  }

  /// Login dengan akun google
  void loginWithGoogle() async {
    /// Singleton GoogleSignIn
    final GoogleSignIn googleSignIn = GoogleSignIn();

    /// Sign out dari akun saat ini (apabila ada) dan sign in
    await googleSignIn.signOut();

    /// Request login dengan akun google
    GoogleSignInAccount? account = await googleSignIn.signIn();

    /// Jika akun yang disediakan null
    if (account == null) return;

    /// Memanggil API repository
    UserRes userRes = await LoginRepository.getUserFromGoogle(
        account.displayName ?? '-', account.email);

    if (userRes.status_code == 200) {
      /// Mengatur token dan user
      await LocalDBServices.setUser(userRes.user!);
      await LocalDBServices.setToken(userRes.token!);

      /// Pergi ke halaman dashboard
      Get.offAllNamed('/dashboard');
    } else {
      /// Tampilkan snackbar error tidak diketahui
      Get.showSnackbar(ErrorSnackBar(
        title: 'Something went wrong'.tr,
        message: 'Unknown error'.tr,
      ));
    }
  }
}
