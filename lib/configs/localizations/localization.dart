import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          /// Error umum
          'error': 'Something went wrong',
          'unknown_error': 'Unknown error',
          'server_error': 'Server error. Please try again later.',

          /// Halaman Login
          'continue_to_sign_in': 'Continue to Sign In',
          'email': 'Email',
          'password': 'Password',
          'login_with': 'Login with ',
          'account_incorrect': 'Email or password is incorrect',

          /// Koneksi
          'connected': 'Connected to the internet',
          'not_connected': 'Not connected to the internet',
          'open_settings': 'Open Settings',

          /// Halaman Home
          'home_page': 'Home Page',
          'searching_location': 'Searching location...',
          'unknown_location': 'Unknown location',
          'distance_not_close': 'Distance not close',
          'location_service_not_enabled': 'Location service not enabled',
          'location_permission_not_granted': 'Location permission not granted',
          'location_permission_not_granted_forever':
              'Location permission not granted forever',
        },
        'id_ID': {
          /// Error umum
          'error': 'Terjadi kesalahan',
          'unknown_error': 'Kesalahan tidak diketahui',
          'server_error': 'Kesalahan server. Silahkan coba lagi nanti.',

          /// Halaman Login
          'continue_to_sign_in': 'Masuk untuk melanjutkan!',
          'email': 'Email',
          'password': 'Kata Sandi',
          'login_with': 'Masuk menggunakan ',
          'account_incorrect': 'Email atau kata sandi salah',

          /// Koneksi
          'connected': 'Terhubung ke internet',
          'not_connected': 'Tidak terhubung ke internet',
          'open_settings': 'Buka Pengaturan',

          /// Halaman Home
          'home_page': 'Halaman Utama',
          'searching_location': 'Mencari Lokasimu...',
          'unknown_location': 'Lokasi tidak diketahui',
          'distance_not_close': 'Jarak tidak dekat dengan Java Code',
          'location_service_not_enabled': 'Layanan lokasi dimatikan.',
          'location_permission_not_granted': 'Izin lokasi tidak diberikan.',
          'location_permission_not_granted_forever':
              'Izin lokasi tidak diberikan secara permanen.',
        },
      };
}
