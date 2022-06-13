import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:java_code_app/constants/commons/constants.dart';
import 'package:java_code_app/modules/features/home/repositories/menu_repository.dart';
import 'package:java_code_app/modules/features/home/repositories/promo_repository.dart';
import 'package:java_code_app/modules/models/menu.dart';
import 'package:java_code_app/modules/models/promo.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final TextEditingController searchController = TextEditingController();
  final Debouncer debouncer =
      Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void onInit() {
    super.onInit();

    /// Mendapatkan promo dan menu
    getListPromo();
    getListMenu();
  }

  @override
  void onClose() {
    /// Hentikan timer dan hapus text editing controller
    debouncer.cancel();
    searchController.dispose();

    super.onClose();
  }

  /// Reload data
  Future<void> reload() async {
    /// Bersihkan pencarian
    searchController.clear();
    setQueryMenu('');

    /// Bersihkan filter kategori
    setCategoryMenu('all');

    /// Fetch data
    await Future.any([
      HomeController.to.getListPromo(),
      HomeController.to.getListMenu(),
    ]);
  }

  /// Promo
  RxString statusPromo = RxString('loading');
  RxString messagePromo = RxString('');
  RxList<Promo> listPromo = RxList<Promo>();

  /// Get all promo
  Future<void> getListPromo() async {
    statusPromo.value = 'loading';

    /// Ambil data dari API
    var listPromoRes = await PromoRepository.getAllByUser();

    if (listPromoRes.status_code == 200) {
      /// Jika request API sukses
      statusPromo.value = 'success';
      listPromo.value = listPromoRes.data!;
    } else if (listPromoRes.status_code == 204) {
      /// Jika request API kosong
      statusPromo.value = 'empty';
    } else {
      /// Jika request API gagal, tampilkan pesan error
      statusPromo.value = 'error';
      messagePromo.value = listPromoRes.message ?? 'Unknown error'.tr;
    }
  }

  /// Menu
  RxString categoryMenu = RxString('all');
  RxString queryMenu = RxString('');
  RxString statusMenu = RxString('loading');
  RxString messageMenu = RxString('');
  RxList<Menu> listMenu = RxList<Menu>();

  /// Update category filter menu
  Future<void> setCategoryMenu(String value) async {
    categoryMenu.value = value;
  }

  /// Update search filter menu
  Future<void> setQueryMenu(String value) async {
    debouncer.call(() {
      queryMenu.value = value.trim();
    });
  }

  /// Fetch List Menu
  Future<void> getListMenu() async {
    statusMenu.value = 'loading';

    var listMenuRes = await MenuRepository.getAll();

    if (listMenuRes.status_code == 200) {
      statusMenu.value = 'success';
      listMenu.value = listMenuRes.data!;
    } else if (listMenuRes.status_code == 204) {
      statusMenu.value = 'empty';
    } else {
      statusMenu.value = 'error';
      messageMenu.value = listMenuRes.message ?? 'Unknown error'.tr;
    }
  }

  /// Get food list
  List<Menu> get foodMenu => _getListMenuByFilter(AppConst.foodCategory);

  /// Get drink list
  List<Menu> get drinkMenu => _getListMenuByFilter(AppConst.drinkCategory);

  List<Menu> _getListMenuByFilter(String category) {
    return listMenu
        .where((e) =>
            e.kategori == category &&
            e.nama.toLowerCase().contains(queryMenu.value.toLowerCase()))
        .toList();
  }
}
