import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/commons/constants.dart';

class LocationServices {
  LocationServices._();

  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service not enabled'.tr);
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission not granted'.tr);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission not granted forever'.tr);
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<String> getAddress(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
      localeIdentifier: Get.locale == null
          ? 'id_ID'
          : '${Get.locale!.languageCode}menu${Get.locale!.countryCode}',
    );

    if (placemarks.isEmpty) {
      return Future.error('Unknown location'.tr);
    } else {
      return [
        placemarks[0].name,
        placemarks[0].subLocality,
        placemarks[0].locality,
        placemarks[0].administrativeArea,
        placemarks[0].postalCode,
        placemarks[0].country,
      ].join(', ');
    }
  }

  static bool isDistanceClose(Position position) {
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      locationLatitude,
      locationLongitude,
    );

    return distanceInMeters <= maximumDistance;
  }
}
