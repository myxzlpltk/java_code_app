import 'package:get/get.dart';
import 'package:java_code_app/modules/models/menu.dart';
import 'package:java_code_app/modules/models/order_detail.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();

  RxList<OrderDetail> cart = RxList<OrderDetail>();

  int get totalCart => cart.fold(0, (total, item) => total + item.quantity);

  /// add item to cart
  void add(OrderDetail orderDetail) {
    cart.remove(orderDetail);
    cart.add(orderDetail);

    print(cart.length);
  }

  /// Remove item from cart
  void remove(OrderDetail orderDetail) {
    cart.remove(orderDetail);
  }

  bool isMenuExists(Menu menu) {
    return cart.firstWhereOrNull((el) => el.menu == menu) != null;
  }
}
