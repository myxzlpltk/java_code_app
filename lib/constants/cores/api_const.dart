class ApiConst {
  ApiConst._();

  /// Base URL for API
  static const String apiKey = '';
  static const String apiBaseUrl = 'https://trainee.landa.id/javacode';

  /// Auth
  static const String login = '$apiBaseUrl/auth/login';

  /// Home
  static const String allPromo = '$apiBaseUrl/promo/all';
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
  static const String historyOrder = '$apiBaseUrl/order/history';
  static const String detailOrder = '$apiBaseUrl/order/detail';
  static const String cancelOrder = '$apiBaseUrl/order/batal';

  /// Profile
  static const String detailUser = '$apiBaseUrl/user/detail';
  static const String updateUser = '$apiBaseUrl/user/update';
  static const String updateUserPhoto = '$apiBaseUrl/user/profil';
  static const String updateUserKTP = '$apiBaseUrl/user/ktp';

  /// Review
  static const String allReview = '$apiBaseUrl/review';
  static const String addReview = '$apiBaseUrl/review/add';

  /// Firebase Cloud Messaging
  static const String firebaseCloudMessaging =
      'https://fcm.googleapis.com/fcm/send';
}
