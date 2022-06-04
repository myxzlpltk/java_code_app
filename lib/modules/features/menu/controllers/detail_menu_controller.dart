import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/modules/features/cart/controllers/cart_controller.dart';
import 'package:java_code_app/modules/features/menu/repositories/menu_repository.dart';
import 'package:java_code_app/modules/features/menu/view/components/level_bottom_sheet.dart';
import 'package:java_code_app/modules/features/menu/view/components/note_bottom_sheet.dart';
import 'package:java_code_app/modules/features/menu/view/components/topping_bottom_sheet.dart';
import 'package:java_code_app/modules/models/cart_item.dart';
import 'package:java_code_app/modules/models/menu.dart';
import 'package:java_code_app/shared/styles/shapes.dart';

class DetailMenuController extends GetxController {
  static DetailMenuController get to => Get.find();

  RxString status = RxString('loading');
  RxBool isExistsInCart = RxBool(false);

  Rxn<Menu> menu = Rxn<Menu>();
  RxList<MenuVariant> levels = RxList<MenuVariant>();
  RxList<MenuVariant> toppings = RxList<MenuVariant>();

  RxInt quantity = RxInt(1);
  Rxn<MenuVariant> selectedLevel = Rxn<MenuVariant>();
  RxList<MenuVariant> selectedToppings = RxList<MenuVariant>();
  RxString note = RxString('');

  @override
  void onInit() {
    super.onInit();

    /// Set menu from argument
    menu.value = Get.arguments as Menu;

    /// Set menu from API
    MenuRepository.getFromId(menu.value!.id_menu).then((menuRes) {
      /// Jika request API sukses
      if (menuRes.status_code == 200) {
        status.value = 'success';
        levels.value = menuRes.level;
        toppings.value = menuRes.topping;

        if (levels.isNotEmpty) {
          selectedLevel.value = levels.first;
        }
      } else {
        status.value = 'error';
      }
    });

    /// Cari apakah sudah ada dikeranjang
    final cartOrderDetail =
        CartController.to.cart.firstWhereOrNull((e) => e.menu == menu.value);

    /// Jika ada dikeranjang
    if (cartOrderDetail != null) {
      isExistsInCart.value = true;
      selectedLevel.value = cartOrderDetail.level;
      note.value = cartOrderDetail.note;
      selectedToppings.value = cartOrderDetail.toppings?.toList() ?? [];
      quantity.value = cartOrderDetail.quantity;
    }
  }

  /// On increment quantity
  void onIncrement() {
    quantity.value++;
  }

  /// On decrement quantity
  void onDecrement() {
    if (quantity > 0) quantity.value--;
  }

  /// Open note bottom sheet
  void openNoteBottomSheet() {
    Get.bottomSheet(
      NoteBottomSheet(),
      backgroundColor: Colors.white,
      shape: CustomShape.topRoundedShape,
      isScrollControlled: true,
    );
  }

  /// Set note
  void setNote(String note) {
    this.note.value = note.trim();
    if (Get.isBottomSheetOpen == true) Get.back();
  }

  /// Open level bottom sheet
  void openLevelBottomSheet() {
    Get.bottomSheet(
      const LevelBottomSheet(),
      backgroundColor: Colors.white,
      shape: CustomShape.topRoundedShape,
      isScrollControlled: true,
    );
  }

  /// Set level
  void setLevel(MenuVariant level) {
    selectedLevel.value = level;
    if (Get.isBottomSheetOpen == true) Get.back();
  }

  /// Getter for selected level text
  String get selectedLevelText => selectedLevel.value?.keterangan ?? '-';

  /// Open topping bottom sheet
  void openToppingBottomSheet() {
    Get.bottomSheet(
      const ToppingBottomSheet(),
      backgroundColor: Colors.white,
      shape: CustomShape.topRoundedShape,
      isScrollControlled: true,
    );
  }

  /// Set topping
  void toggleTopping(MenuVariant topping) {
    if (selectedToppings.contains(topping)) {
      selectedToppings.remove(topping);
    } else {
      selectedToppings.add(topping);
    }
    selectedToppings.sort((a, b) => a.keterangan.compareTo(b.keterangan));
  }

  /// Getter for selected topping text
  String get selectedToppingsText => selectedToppings.isNotEmpty
      ? selectedToppings.map((topping) => topping.keterangan).join(', ')
      : 'Choose topping'.tr;

  CartItem get detailOrder => CartItem(
      menu: menu.value!,
      quantity: quantity.value,
      note: note.value,
      level: selectedLevel.value,
      toppings: toppings.isEmpty ? null : selectedToppings.toList());

  /// On add to cart
  void addToCart() {
    if (status.value == 'success' &&
        (selectedLevel.value != null || levels.isEmpty)) {
      CartController.to.add(detailOrder);
      Get.offNamedUntil(
        AppRoutes.cartView,
        ModalRoute.withName(AppRoutes.dashboardView),
      );
    }
  }

  void deleteFromCart() {
    CartController.to.remove(detailOrder);
    Get.offNamedUntil(
      AppRoutes.cartView,
      ModalRoute.withName(AppRoutes.dashboardView),
    );
  }
}
