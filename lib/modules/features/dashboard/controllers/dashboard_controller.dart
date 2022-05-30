import 'package:easy_debounce/easy_debounce.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/modules/features/dashboard/repositories/menu_repository.dart';
import 'package:java_code_app/modules/features/dashboard/repositories/promo_repository.dart';
import 'package:java_code_app/modules/models/menu.dart';
import 'package:java_code_app/modules/models/promo.dart';
import 'package:java_code_app/utils/services/location_services.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();

  @override
  void onReady() {
    super.onReady();

    /// Mencari lokasi
    Future.delayed(const Duration(milliseconds: 500), () async {
      Get.toNamed(AppRoutes.getLocationView);
      await getLocation();
    });

    /// Mendapatkan promo
    getListPromo();
    getListMenu();
  }

  /// Navigation bar
  RxInt tabIndex = RxInt(0);

  /// Change tab index
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  /// Location
  RxString statusLocation = RxString('loading');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();

  /// Get current location if location not exists
  Future<void> getLocation() async {
    try {
      position.value = await LocationServices.getCurrentPosition();

      if (LocationServices.isDistanceClose(position.value!)) {
        address.value = await LocationServices.getAddress(position.value!);
        statusLocation.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        Get.back(closeOverlays: true);
      } else {
        statusLocation.value = 'error';
        messageLocation.value = 'distance_not_close'.tr;
      }
    } catch (e) {
      statusLocation.value = 'error';
      messageLocation.value = e.toString();
    }
  }

  /// Promo
  RxString statusPromo = RxString('loading');
  RxString messagePromo = RxString('');
  RxList<Promo> listPromo = RxList<Promo>();

  /// Get all promo
  Future<void> getListPromo() async {
    statusPromo.value = 'loading';

    try {
      var listPromoRes = await PromoRepository.getAll();

      if (listPromoRes.status_code == 200) {
        statusPromo.value = 'success';
        listPromo.value = listPromoRes.data!;
      } else if (listPromoRes.status_code == 204) {
        statusPromo.value = 'error';
        messagePromo.value = 'no_data'.tr;
      } else {
        statusPromo.value = 'error';
        messagePromo.value = listPromoRes.message ?? 'unknown_error'.tr;
      }
    } catch (e) {
      statusPromo.value = 'error';
      messagePromo.value = e.toString();
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

    try {
      var listMenuRes = await MenuRepository.getAll();

      if (listMenuRes.status_code == 200) {
        statusMenu.value = 'success';
        listMenu.value = listMenuRes.data!;
      } else if (listMenuRes.status_code == 204) {
        statusMenu.value = 'error';
        messageMenu.value = 'no_data'.tr;
      } else {
        statusMenu.value = 'error';
        messageMenu.value = listMenuRes.message ?? 'unknown_error'.tr;
      }
    } catch (e) {
      statusMenu.value = 'error';
      messageMenu.value = e.toString();
    }
  }

  /// Get food list
  List<Menu> get foodMenu => _getListMenuByFilter('makanan');

  /// Get drink list
  List<Menu> get drinkMenu => _getListMenuByFilter('minuman');

  List<Menu> _getListMenuByFilter(String category) {
    return listMenu
        .where((e) =>
            e.kategori == category &&
            e.nama.toLowerCase().contains(filterMenu.value.toLowerCase()))
        .toList();
  }

  /// Cart
  RxMap<int, int> quantities = RxMap<int, int>();
  RxMap<int, String> notes = RxMap<int, String>();
}
