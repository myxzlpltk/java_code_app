import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          /// Error umum
          'error': 'Something went wrong',
          'unknown_error': 'Unknown error',
          'server_error': 'Server error. Please try again later.',
          'no_data': 'No data',

          /// Halaman Login
          'continue_to_sign_in': 'Continue to Sign In',
          'email': 'Email',
          'password': 'Password',
          'login_with': 'Login with ',
          'account_incorrect': 'Email or password is incorrect',
          'or': 'or',

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

          /// Halaman Home - Promo
          'available_promo': 'Available Promo',
          'diskon': 'Discount',
          'voucher': 'Voucher',
          'terms_and_conditions': 'Terms and Conditions',
          'get_this_promo': 'Get this promo! Access this link\n@link',

          /// Halaman Home - Menu
          'search_bar': 'Search',
          'all_menu': 'All Menu',
          'food': 'Food',
          'drink': 'Drink',
          'add_note': 'Add Note',
          'promo': 'Promo',
          'detail_menu': 'Detail Menu',
          'price': 'Price',
          'topping': 'Topping',
          'level': 'Level',
          'note': 'Note',
          'add_to_order': 'Add to Order',
          'create_note': 'Create Note',
          'select_level': 'Select Level',
          'select_topping': 'Select Topping',

          /// Bottom Navigation Bar
          'home': 'Home',
          'order': 'Order',
          'profile': 'Profile',
        },
        'id_ID': {
          /// Error umum
          'error': 'Terjadi kesalahan',
          'unknown_error': 'Kesalahan tidak diketahui',
          'server_error': 'Kesalahan server. Silahkan coba lagi nanti.',
          'no_data': 'Tidak ada data',

          /// Halaman Login
          'continue_to_sign_in': 'Masuk untuk melanjutkan!',
          'email': 'Email',
          'password': 'Kata Sandi',
          'login_with': 'Masuk menggunakan ',
          'account_incorrect': 'Email atau kata sandi salah',
          'or': 'atau',

          /// Koneksi
          'connected': 'Terhubung ke internet',
          'not_connected': 'Tidak terhubung ke internet',
          'open_settings': 'Buka Pengaturan',

          /// Halaman Home - Lokasi
          'home_page': 'Halaman Utama',
          'searching_location': 'Mencari Lokasimu...',
          'unknown_location': 'Lokasi tidak diketahui',
          'distance_not_close': 'Jarak tidak dekat dengan Java Code',
          'location_service_not_enabled': 'Layanan lokasi dimatikan.',
          'location_permission_not_granted': 'Izin lokasi tidak diberikan.',
          'location_permission_not_granted_forever':
              'Izin lokasi tidak diberikan secara permanen.',

          /// Halaman Home - Promo
          'available_promo': 'Promo yang Tersedia',
          'diskon': 'Diskon',
          'voucher': 'Voucher',
          'terms_and_conditions': 'Syarat dan Ketentuan',
          'get_this_promo': 'Dapatkan Promo ini! Akses link berikut\n@link',

          /// Halaman Home - Menu
          'search_bar': 'Pencarian',
          'all_menu': 'Semua Menu',
          'food': 'Makanan',
          'drink': 'Minuman',
          'add_note': 'Tambahkan catatan',
          'promo': 'Promo',
          'detail_menu': 'Detail Menu',
          'price': 'Harga',
          'topping': 'Toping',
          'level': 'Level',
          'note': 'Catatan',
          'add_to_order': 'Tambahkan ke Pesanan',
          'create_note': 'Buat catatan',
          'select_level': 'Pilih Level',
          'select_topping': 'Pilih Toping',

          /// Bottom Navigation Bar
          'home': 'Beranda',
          'order': 'Pesanan',
          'profile': 'Profil',
        },
      };
}
