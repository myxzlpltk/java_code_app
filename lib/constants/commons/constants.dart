import 'package:flutter/material.dart';

class AppConst {
  /// Memastikan class ini tidak bisa diinstansiasi
  AppConst._();

  /// Informasi aplikasi
  static const String appName = 'Java Code App';
  static const Size appDesignSize = Size(428, 926);
  static const String appLink = 'https://promo.trainee.landa.id';
  static const String appDeepLink = 'landa://javacode.app';
  static const String appVersion = '1.0.0';

  /// Informasi lokasi
  static const double locationLatitude = -7.9423;
  static const double locationLongitude = 112.6230;
  static const double maximumDistance = 100;

  /// Informasi menu
  static const String defaultMenuPhoto =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png';
  static const String foodCategory = 'makanan';
  static const String drinkCategory = 'minuman';
}
