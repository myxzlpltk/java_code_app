import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/modules/features/home/controllers/detail_promo_controller.dart';
import 'package:uni_links/uni_links.dart';

class GlobalController extends GetxController {
  /// Instance dari connectivity_plus
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();

    checkConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectivity);

    initUniLinks();
  }

  /// Untuk mengecek koneksi internet
  void checkConnectivity() {
    _connectivity.checkConnectivity().then(_updateConnectivity);
  }

  /// Untuk update koneksi internet
  void _updateConnectivity(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        if (Get.currentRoute == AppRoutes.noInternetView) Get.back();
        break;
      default:
        Get.toNamed(AppRoutes.noInternetView);
        break;
    }
  }

  Future<void> initUniLinks() async {
    _processUniLinks(await getInitialUri());
    uriLinkStream.listen(_processUniLinks);
  }

  void _processUniLinks(Uri? uri) async {
    if (uri is Uri && uri.queryParameters['id_promo'] != null) {
      /// Put controller
      Get.put(DetailPromoController());

      try {
        /// Set from id
        await DetailPromoController.to
            .setFromId(int.parse(uri.queryParameters['id_promo']!));

        /// Navigate to detail promo
        await Get.toNamed(AppRoutes.detailPromoView);

        /// Wait and remove controller
        Get.delete<DetailPromoController>();
      } catch (e) {
        /// Show snackbar error
        Get.showSnackbar(GetSnackBar(
          title: 'error'.tr,
          message: e.toString(),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ));

        /// Delete controller
        Get.delete<DetailPromoController>();
      }
    }
  }
}
