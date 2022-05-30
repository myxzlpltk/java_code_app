class ApiConst {
  ApiConst._();

  /// Base URL for API
  static const String apiKey = '';
  static const String apiBaseUrl = 'https://trainee.landa.id/javacode';

  /// Auth
  static const String login = '$apiBaseUrl/auth/login';

  /// Home
  static const String allPromo = '$apiBaseUrl/promo/all';
  static const String promo = '$apiBaseUrl/promo/detail';
  static const String allMenu = '$apiBaseUrl/menu/all';
  static const String menu = '$apiBaseUrl/menu/detail';
}
