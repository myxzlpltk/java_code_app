class AppRoutes {
  /// Memastikan bahwa class ini tidak bisa diinstansiasi
  AppRoutes._();

  /// Default app
  static const String noInternetView = '/no-internet';

  /// Otentikasi
  static const String splashView = '/';
  static const String loginView = '/login';

  /// Home
  static const String homeView = '/dashboard';
  static const String getLocationView = '/dashboard/get-location';
  static const String detailPromoView = '/dashboard/detail-promo';
}
