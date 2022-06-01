import 'package:get/get.dart';
import 'package:java_code_app/modules/models/menu.dart';
import 'package:java_code_app/modules/models/order_detail.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();

  List<OrderDetail> cart = <OrderDetail>[];

  /// Getter for food items
  List<OrderDetail> get foodItems => cart.where((e) => e.isFood).toList();

  /// Getter for drink items
  List<OrderDetail> get drinkItems => cart.where((e) => e.isDrink).toList();

  /// Getter for total quantities
  int get totalQuantities =>
      cart.fold(0, (total, item) => total + item.quantity);

  /// Getter for total prices
  int get totalPrice => cart.fold(0, (total, item) => total + item.totalPrice);

  OrderDetail? findByMenu(Menu menu) =>
      cart.firstWhereOrNull((e) => e.menu == menu);

  /// add item to cart
  void add(OrderDetail orderDetail) {
    cart.remove(orderDetail);
    cart.add(orderDetail);
    update();
  }

  /// Remove item from cart
  void remove(OrderDetail orderDetail) {
    cart.remove(orderDetail);
    update();
  }

  /// Increment item quantity
  void increment(OrderDetail orderDetail) {
    orderDetail.quantity++;
    update();
  }

  /// Decrement item quantity
  void decrement(OrderDetail orderDetail) {
    if (orderDetail.quantity > 1) {
      orderDetail.quantity--;
      update();
    }
  }

  /// Update note
  void updateNote(OrderDetail orderDetail, String note) {
    orderDetail.note = note;
  }
}
