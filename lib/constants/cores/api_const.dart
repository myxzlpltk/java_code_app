class ApiConst {
  ApiConst._();

  /// Base URL for API
  static const String apiKey = '';
  static const String apiBaseUrl = 'https://trainee.landa.id/javacode';

  /// Auth
  static const String login = '$apiBaseUrl/auth/login';

  /// Home
  static const String allPromo = '$apiBaseUrl/promo/all';
  static const String detailPromo = '$apiBaseUrl/promo/detail';
  static const String allMenu = '$apiBaseUrl/menu/all';
  static const String detailMenu = '$apiBaseUrl/menu/detail';

  /// Cart
  static const String allDiscount = '$apiBaseUrl/diskon/all';
  static const String allVoucher = '$apiBaseUrl/voucher/all';

  /// Order
  static const String addOrder = '$apiBaseUrl/order/add';
  static const String onGoingOrder = '$apiBaseUrl/order/user';
  static const String detailOrder = '$apiBaseUrl/order/detail';
}
