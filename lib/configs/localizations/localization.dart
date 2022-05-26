import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'error': 'Something went wrong',
          'unknown_error': 'Unknown error',
          'server_error': 'Server error. Please try again later.',
          'home_page': 'Home Page',
          'continue_to_sign_in': 'Continue to Sign In',
          'email': 'Email',
          'password': 'Password',
          'login_with': 'Login with ',
          'account_incorrect': 'Email or password is incorrect',
        },
        'id_ID': {
          'error': 'Terjadi kesalahan',
          'unknown_error': 'Kesalahan tidak diketahui',
          'server_error': 'Kesalahan server. Silahkan coba lagi nanti.',
          'home_page': 'Halaman Utama',
          'continue_to_sign_in': 'Masuk untuk melanjutkan!',
          'email': 'Email',
          'password': 'Kata Sandi',
          'login_with': 'Masuk menggunakan ',
          'account_incorrect': 'Email atau kata sandi salah',
        },
      };
}
