import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/shared/widgets/network_error_view.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';
import 'package:uni_links/uni_links.dart';

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();

  /// Instance dari connectivity_plus
  final Connectivity _connectivity = Connectivity();

  /// Status internet
  RxBool internetStatus = RxBool(true);

  @override
  void onInit() {
    super.onInit();

    /// Cek konektivitas
    checkConnectivity();

    /// Listen dari perubahan konektivitas
    _connectivity.onConnectivityChanged.listen(_updateConnectivity);

    /// Inisialisasi uni links
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

        /// Jika koneksi internet berhasil
        internetStatus.value = true;
        break;
      default:

        /// Jika koneksi internet gagal
        internetStatus.value = false;
        if (Get.currentRoute != AppRoutes.splashView) {
          showAlert();
        }
        break;
    }
  }

  /// Show alert internet
  Future<void> showAlert() async {
    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const NetworkErrorView(),
    );
  }

  Future<void> initUniLinks() async {
    /// Listen dari perubahan uni link
    uriLinkStream.listen(processUniLinks);
  }

  void processUniLinks(Uri? uri) async {
    if (uri != null && uri.queryParameters['id_promo'] != null) {
      /// Mendapatkan user dan token dari local DB service
      var user = await LocalDBServices.getUser();
      var token = await LocalDBServices.getToken();

      if (user != null && token != null) {
        /// Navigasi ke detail promo jika sudah login
        await Get.toNamed(
          AppRoutes.detailPromoView,
          arguments: int.parse(uri.queryParameters['id_promo']!),
        );
      }
    }
  }
}
