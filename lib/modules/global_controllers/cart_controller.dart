import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();

  /// Cart
  RxMap<int, int> quantities = RxMap<int, int>();
  RxMap<int, String> notes = RxMap<int, String>();
}
