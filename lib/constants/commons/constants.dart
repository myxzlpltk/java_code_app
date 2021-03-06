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
  static const String firebaseCloudMessagingKey =
      'AAAA17gfCJY:APA91bEaXVcZNiyh-932cP0aEvbEx4pA9yV6qqU6Nr3Xh_CNqJ8XzgeOx4gCkRU5c13EgLRjZPygoOgemnCkilf8GPoyUWyRXgN1gtApPE9Mk440FMWansSH12cq5BilS6_dwujy2ZMj';

  /// Informasi lokasi
  static const double locationLatitude = -7.9423;
  static const double locationLongitude = 112.6230;
  static const double maximumDistance = 100;

  /// Informasi menu
  static const String defaultMenuPhoto =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png';
  static const String foodCategory = 'makanan';
  static const String drinkCategory = 'minuman';

  /// Informasi kondisi
  static const String fingerprint = 'fingerprint';
  static const String pin = 'pin';
}
