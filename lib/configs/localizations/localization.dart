import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'ok': 'OK',

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
          'delete_from_order': 'Delete from Order',
          'update_to_order': 'Update to Order',

          /// Keranjang
          'empty_cart': 'Empty Cart',
          'total_orders': 'Total Orders',
          'discount': 'Discount',
          'payment': 'Payment',
          'total_payment': 'Total Payment',
          'order_now': 'Order Now',
          'choose_discount': 'Choose Discount',
          'choose_voucher': 'Choose Voucher',
          'info_discount': 'Info Discount',
          'no_discount': 'No Discount',
          'detail_voucher': 'Detail Voucher',
          'valid_date': 'Valid Date',
          'choose_voucher_terms_1':
              'The use of vouchers cannot be combined with a discount',
          'choose_voucher_terms_2': 'employee reward program',
          'discount_can_not_be_combined': 'Discount can not be combined',
          'use_voucher': 'Use Voucher',
          'use_voucher_later': 'Use Voucher Later',

          /// Bottom Navigation Bar
          'home': 'Home',
          'order': 'Order',
          'profile': 'Profile',
        },
        'id_ID': {
          'ok': 'Oke',

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
          'delete_from_order': 'Hapus dari Pesanan',
          'update_to_order': 'Perbarui ke Pesanan',

          /// Keranjang
          'empty_cart': 'Keranjang Kosong',
          'total_orders': 'Total Pesanan',
          'discount': 'Diskon',
          'payment': 'Pembayaran',
          'total_payment': 'Total Pembayaran',
          'order_now': 'Pesan Sekarang',
          'choose_discount': 'Pilih Diskon',
          'choose_voucher': 'Pilih Voucher',
          'info_discount': 'Info Diskon',
          'no_discount': 'Tidak Ada Diskon',
          'detail_voucher': 'Detail Voucher',
          'valid_date': 'Tanggal Valid',
          'choose_voucher_terms_1':
              'Penggunaan voucher tidak dapat digabung dengan discount ',
          'choose_voucher_terms_2': 'employee reward program',
          'discount_can_not_be_combined': 'Diskon tidak dapat digabung',
          'use_voucher': 'Pakai Voucher',
          'use_voucher_later': 'Pakai Voucher Nanti',

          /// Bottom Navigation Bar
          'home': 'Beranda',
          'order': 'Pesanan',
          'profile': 'Profil',
        },
      };
}
