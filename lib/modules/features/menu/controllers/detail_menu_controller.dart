import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/modules/features/menu/repositories/menu_repository.dart';
import 'package:java_code_app/modules/features/menu/view/components/level_bottom_sheet.dart';
import 'package:java_code_app/modules/features/menu/view/components/note_bottom_sheet.dart';
import 'package:java_code_app/modules/features/menu/view/components/topping_bottom_sheet.dart';
import 'package:java_code_app/modules/models/menu.dart';
import 'package:java_code_app/shared/styles/shapes.dart';

class DetailMenuController extends GetxController {
  static DetailMenuController get to => Get.find();

  Rxn<Menu> menu = Rxn<Menu>();

  RxString status = RxString('loading');
  RxString message = RxString('');

  RxList<MenuVariant> levels = RxList<MenuVariant>();
  RxList<MenuVariant> toppings = RxList<MenuVariant>();

  RxInt quantity = RxInt(1);
  Rxn<MenuVariant> selectedLevel = Rxn<MenuVariant>();
  Rxn<MenuVariant> selectedTopping = Rxn<MenuVariant>();
  RxString note = RxString('');

  @override
  void onInit() {
    super.onInit();

    /// Set menu from argument
    menu.value = Get.arguments as Menu;

    /// Set menu from API
    MenuRepository.getFromId(menu.value!.id_menu).then((menuRes) {
      if (menuRes.status_code == 200) {
        status.value = 'success';
        if (menuRes.level.isNotEmpty) {
          levels.value = menuRes.level;
          selectedLevel.value = menuRes.level.first;
        }
        if (menuRes.topping.isNotEmpty) {
          toppings.value = menuRes.topping;
          selectedTopping.value = menuRes.topping.first;
        }
      } else {
        status.value = 'error';
        message.value = menuRes.message!;
      }
    });
  }

  /// On increment quantity
  void onIncrement() {
    quantity.value++;
  }

  /// On decrement quantity
  void onDecrement() {
    if (quantity > 1) quantity.value--;
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
  void setTopping(MenuVariant topping) {
    selectedTopping.value = topping;
    if (Get.isBottomSheetOpen == true) Get.back();
  }

  bool get isAllowedToOrder =>
      status.value == 'success' &&
      (selectedLevel.value != null || levels.isEmpty) &&
      (selectedTopping.value != null || toppings.isEmpty);

  /// On add to cart
  void addToOrder() {}
}
