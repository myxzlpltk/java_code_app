import 'package:easy_debounce/easy_debounce.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/commons/constants.dart';
import 'package:java_code_app/modules/features/home/repositories/menu_repository.dart';
import 'package:java_code_app/modules/features/home/repositories/promo_repository.dart';
import 'package:java_code_app/modules/models/menu.dart';
import 'package:java_code_app/modules/models/promo.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    /// Mendapatkan promo dan menu
    getListPromo();
    getListMenu();
  }

  /// Promo
  RxString statusPromo = RxString('loading');
  RxString messagePromo = RxString('');
  RxList<Promo> listPromo = RxList<Promo>();

  /// Get all promo
  Future<void> getListPromo() async {
    statusPromo.value = 'loading';

    var listPromoRes = await PromoRepository.getAllByUser();

    if (listPromoRes.status_code == 200) {
      statusPromo.value = 'success';
      listPromo.value = listPromoRes.data!;
    } else if (listPromoRes.status_code == 204) {
      statusPromo.value = 'empty';
    } else {
      statusPromo.value = 'error';
      messagePromo.value = listPromoRes.message ?? 'Unknown error'.tr;
    }
  }

  /// Menu
  RxString categoryMenu = RxString('all');
  RxString filterMenu = RxString('');
  RxString statusMenu = RxString('loading');
  RxString messageMenu = RxString('');
  RxList<Menu> listMenu = RxList<Menu>();

  /// Update category filter menu
  Future<void> setCategoryMenu(String value) async {
    categoryMenu.value = value;
  }

  /// Update search filter menu
  Future<void> setFilterMenu(String value) async {
    EasyDebounce.debounce('search-menu', const Duration(milliseconds: 500), () {
      filterMenu.value = value.trim();
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
  List<Menu> get foodMenu => _getListMenuByFilter(foodCategory);

  /// Get drink list
  List<Menu> get drinkMenu => _getListMenuByFilter(drinkCategory);

  List<Menu> _getListMenuByFilter(String category) {
    return listMenu
        .where((e) =>
            e.kategori == category &&
            e.nama.toLowerCase().contains(filterMenu.value.toLowerCase()))
        .toList();
  }
}
