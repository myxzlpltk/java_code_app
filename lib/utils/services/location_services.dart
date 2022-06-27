import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/localizations/localization.dart';
import 'package:java_code_app/constants/commons/constants.dart';

/// Location service untuk mendapatkan informasi lokasi
class LocationServices {
  /// Memastikan class ini tidak bisa diinstansiasi
  LocationServices._();

  static Stream<ServiceStatus> streamService =
  Geolocator.getServiceStatusStream();

  /// Mendapatkan informasi lokasi
  static Future<LocationResult> getCurrentPosition() async {
    /// Apakah layanan lokasi aktif?
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      /// Jika tidak, kirim pesan error
      return LocationResult.error(message: 'Location service not enabled'.tr);
    }

    /// Cek izin lokasi
    LocationPermission permission = await Geolocator.checkPermission();

    /// Apakah izin lokasi ditolak
    if (permission == LocationPermission.denied) {
      /// Jika tidak, minta izin
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        /// Jika izin ditolak, kirim pesan error
        return LocationResult.error(
          message: 'Location permission not granted'.tr,
        );
      }
    }

    /// Apakah izin lokasi ditolak selamanya
    if (permission == LocationPermission.deniedForever) {
      /// Jika izin lokasi ditolak selamanya, kirim pesan error
      return LocationResult.error(
        message: 'Location permission not granted forever'.tr,
      );
    }

    /// Jika izin lokasi diberikan, ambil lokasi
    late Position position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st);
      return LocationResult.error(message: 'Location service not enabled'.tr);
    }

    /// Mendapatkan informasi jarak lokasi dalam meter
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      AppConst.locationLatitude,
      AppConst.locationLongitude,
    );

    /// Apakah jarak lokasi dekat dengan lokasi Java Code dalam radius yang ditentukan?
    if (distanceInMeters > AppConst.maximumDistance) {
      /// Jika tidak, kirim pesan error
      return LocationResult.error(message: 'Distance not close'.tr);
    }

    /// Ambil informasi lokasi
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
      localeIdentifier: Localization.currentLocale.toString(),
    );

    if (placemarks.isEmpty) {
      /// Jika tidak ada informasi lokasi, kirim pesan error
      return LocationResult.error(message: 'Unknown location'.tr);
    }

    /// Jika ada informasi lokasi, kirim informasi lokasi
    return LocationResult.success(
      position: position,
      address: [
        placemarks.first.name,
        placemarks.first.subLocality,
        placemarks.first.locality,
        placemarks.first.administrativeArea,
        placemarks.first.postalCode,
        placemarks.first.country,
      ].where((e) => e != null).join(', '),
    );
  }
}

class LocationResult {
  final bool success;
  final Position? position;
  final String? address;
  final String? message;

  LocationResult({
    required this.success,
    this.position,
    this.address,
    this.message,
  });

  factory LocationResult.success({required Position position, required String address}) {
    return LocationResult(
      success: true,
      position: position,
      address: address,
    );
  }

  factory LocationResult.error({required String message}) {
    return LocationResult(
      success: false,
      message: message,
    );
  }
}
