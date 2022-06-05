class ApiConst {
  ApiConst._();

  /// Base URL for API
  static const String apiKey = '';
  static const String apiBaseUrl = 'https://trainee.landa.id/javacode';

  /// Auth
  static const String login = '$apiBaseUrl/auth/login';

  /// Home
  static const String allPromoPerUser = '$apiBaseUrl/promo/user';
  static const String detailPromo = '$apiBaseUrl/promo/detail';
  static const String allMenu = '$apiBaseUrl/menu/all';
  static const String detailMenu = '$apiBaseUrl/menu/detail';

  /// Cart
  static const String allDiscountPerUser = '$apiBaseUrl/diskon/user';
  static const String allVoucherPerUser = '$apiBaseUrl/voucher/user';

  /// Order
  static const String addOrder = '$apiBaseUrl/order/add';
  static const String onGoingOrder = '$apiBaseUrl/order/user';
  static const String detailOrder = '$apiBaseUrl/order/detail';
}
