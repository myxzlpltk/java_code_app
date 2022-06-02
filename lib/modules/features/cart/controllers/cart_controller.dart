import 'package:get/get.dart';
import 'package:java_code_app/modules/features/cart/repositories/discount_repository.dart';
import 'package:java_code_app/modules/features/cart/view/components/discount_info.dart';
import 'package:java_code_app/modules/models/detail_order.dart';
import 'package:java_code_app/modules/models/discount.dart';
import 'package:java_code_app/modules/models/menu.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    getDiscount();
  }

  List<DetailOrder> cart = <DetailOrder>[];
  List<Discount> discounts = [];

  /// Get discount for user
  Future<void> getDiscount() async {
    var listDiscountRes = await DiscountRepository.getAll();

    if (listDiscountRes.status_code == 200) {
      listDiscountRes.data!.shuffle();
      discounts = listDiscountRes.data!.sublist(0, 2);
      update();
    }
  }

  /// Getter for food items
  List<DetailOrder> get foodItems => cart.where((e) => e.isFood).toList();

  /// Getter for drink items
  List<DetailOrder> get drinkItems => cart.where((e) => e.isDrink).toList();

  /// Getter for total quantities
  int get totalQuantities =>
      cart.fold(0, (total, item) => total + item.quantity);

  /// Getter for total prices
  int get totalPrice => cart.fold(0, (total, item) => total + item.totalPrice);

  /// Getter for total discount
  int get totalDiscount => discounts.isEmpty
      ? 0
      : discounts.fold(0, (total, discount) => total + discount.nominal);

  int get totalDiscountPrice => (totalPrice * totalDiscount / 100).round();

  /// Getter for total price with discount
  int get grandTotalPrice => totalPrice - totalDiscountPrice;

  DetailOrder? findByMenu(Menu menu) =>
      cart.firstWhereOrNull((e) => e.menu == menu);

  /// add item to cart
  void add(DetailOrder orderDetail) {
    cart.remove(orderDetail);
    cart.add(orderDetail);
    update();
  }

  /// Remove item from cart
  void remove(DetailOrder orderDetail) {
    cart.remove(orderDetail);
    update();
  }

  /// Increment item quantity
  void increment(DetailOrder orderDetail) {
    orderDetail.quantity++;
    update();
  }

  /// Decrement item quantity
  void decrement(DetailOrder orderDetail) {
    if (orderDetail.quantity > 1) {
      orderDetail.quantity--;
      update();
    } else {
      cart.remove(orderDetail);
      update();
    }
  }

  /// Update note
  void updateNote(DetailOrder orderDetail, String note) {
    orderDetail.note = note;
  }

  /// Open dialog for discount
  void openDiscountDialog() {
    Get.defaultDialog(
      title: 'info_discount'.tr,
      titleStyle: Get.textTheme.headlineMedium!.copyWith(
        color: Get.theme.colorScheme.primary,
      ),
      content: DiscountInfo(discounts: discounts),
    );
  }
}
