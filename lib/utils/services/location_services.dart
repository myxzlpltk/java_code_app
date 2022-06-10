import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/localizations/localization.dart';
import 'package:java_code_app/constants/commons/constants.dart';

/// Location service untuk mendapatkan informasi lokasi
class LocationServices {
  /// Memastikan class ini tidak bisa diinstansiasi
  LocationServices._();

  /// Mendapatkan informasi lokasi
  static Future<Position> getCurrentPosition() async {
    /// Apakah layanan lokasi aktif?
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      /// Jika tidak, kirim pesan error
      return Future.error('Location service not enabled'.tr);
    }

    /// Cek izin lokasi
    LocationPermission permission = await Geolocator.checkPermission();

    /// Apakah izin lokasi ditolak
    if (permission == LocationPermission.denied) {
      /// Jika tidak, minta izin
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        /// Jika izin ditolak, kirim pesan error
        return Future.error('Location permission not granted'.tr);
      }
    }

    /// Apakah izin lokasi ditolak selamanya
    if (permission == LocationPermission.deniedForever) {
      /// Jika izin lokasi ditolak selamanya, kirim pesan error
      return Future.error('Location permission not granted forever'.tr);
    }

    /// Jika izin lokasi diberikan, ambil lokasi
    return await Geolocator.getCurrentPosition();
  }

  /// Mendapatkan informasi nama alamat dari lokasi
  static Future<String> getAddress(Position position) async {
    /// Ambil informasi lokasi
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
      localeIdentifier: Localization.currentLocale.toString(),
    );

    if (placemarks.isEmpty) {
      /// Jika tidak ada informasi lokasi, kirim pesan error
      return Future.error('Unknown location'.tr);
    } else {
      /// Jika ada informasi lokasi, kirim informasi lokasi
      return [
        placemarks.first.name,
        placemarks.first.subLocality,
        placemarks.first.locality,
        placemarks.first.administrativeArea,
        placemarks.first.postalCode,
        placemarks.first.country,
      ].where((e) => e != null).join(', ');
    }
  }

  /// Apakah lokasi dekat dengan lokasi Java Code
  static bool isDistanceClose(Position position) {
    /// Mendapatkan informasi jarak lokasi dalam meter
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      AppConst.locationLatitude,
      AppConst.locationLongitude,
    );

    /// Apakah jarak lokasi dekat dengan lokasi Java Code dalam radius yang ditentukan?
    return distanceInMeters <= AppConst.maximumDistance;
  }
}
