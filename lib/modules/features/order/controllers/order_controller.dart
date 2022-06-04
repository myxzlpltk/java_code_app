import 'package:get/get.dart';
import 'package:java_code_app/modules/features/order/repositories/order_repository.dart';
import 'package:java_code_app/modules/models/order.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    fetchOnGoing();
  }

  RxString onGoingStatus = RxString('loading');
  RxList<Order> onGoingOrders = RxList<Order>();

  Future<void> fetchOnGoing() async {
    onGoingStatus.value = 'loading';
    ListOrderRes listOrderRes = await OrderRepository.getOnGoing();

    if (listOrderRes.status_code == 200) {
      onGoingStatus.value = 'success';
      onGoingOrders.value = listOrderRes.data!;
    } else if (listOrderRes.status_code == 204) {
      onGoingStatus.value = 'empty';
    } else {
      onGoingStatus.value = 'error';
    }
  }
}
