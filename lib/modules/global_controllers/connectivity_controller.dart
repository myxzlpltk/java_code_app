import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:java_code_app/shared/widgets/network_error.dart';

class ConnectivityController extends GetxController {
  /// Instance dari connectivity_plus
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return _updateState(connectivityResult);
  }

  void _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        Get.back();
        break;
      default:
        Get.dialog(const NetworkError(), barrierDismissible: false);
        break;
    }
  }
}
