import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/modules/features/cart/controllers/cart_controller.dart';
import 'package:java_code_app/modules/features/home/controllers/home_controller.dart';
import 'package:java_code_app/modules/features/order/repositories/order_repository.dart';
import 'package:java_code_app/modules/models/cart_item.dart';
import 'package:java_code_app/modules/models/order.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    /// Ambil data pesanan yang sedang berjalan dan riwayat pesanan
    fetchOnGoing();
    fetchHistory();
  }

  /// Data pesanan yang sedang berjalan
  RxString onGoingStatus = RxString('loading');
  RxList<Order> onGoingOrders = RxList<Order>();

  /// Ambil data pesanan yang sedang berjalan
  Future<void> fetchOnGoing() async {
    onGoingStatus.value = 'loading';

    /// Fetch data pesanan yang sedang berjalan
    ListOrderRes listOrderRes = await OrderRepository.getOnGoing();

    if (listOrderRes.status_code == 200) {
      /// Jika berhasil, tampilkan data
      onGoingOrders.value =
          listOrderRes.data!.where((e) => e.status != 4).toList();

      if (onGoingOrders.value.isEmpty) {
        onGoingStatus.value = 'empty';
      } else {
        onGoingStatus.value = 'success';
      }
    } else if (listOrderRes.status_code == 204) {
      onGoingStatus.value = 'empty';
    } else {
      onGoingStatus.value = 'error';
    }
  }

  /// Data riwayat pesanan
  RxString historyStatus = RxString('loading');
  RxList<Order> historyOrders = RxList<Order>();

  /// Data filter riwayat pesanan
  String selectedCategory = 'all';
  DateTimeRange selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );

  /// Atur filter riwayat pesanan
  void setFilter({String? category, DateTimeRange? dateRange}) {
    selectedCategory = category ?? 'all';
    selectedDateRange = dateRange ?? selectedDateRange;
    historyOrders.refresh();
  }

  /// Filter riwayat pesanan
  List<Order> get historyOrderFiltered {
    List<Order> list = historyOrders.toList();

    /// Filter category
    if (selectedCategory == 'canceled') {
      list.removeWhere((e) => e.status != 4);
    } else if (selectedCategory == 'completed') {
      list.removeWhere((e) => e.status != 3);
    }

    /// Filter date
    list.removeWhere((e) =>
        e.tanggal.isBefore(selectedDateRange.start) ||
        e.tanggal.isAfter(selectedDateRange.end));

    /// Sort based on date
    list.sort((a, b) => b.tanggal.compareTo(a.tanggal));

    return list;
  }

  /// Ambil data riwayat pesanan
  Future<void> fetchHistory() async {
    historyStatus.value = 'loading';

    /// Fetch data riwayat pesanan
    ListOrderRes listOrderRes = await OrderRepository.getHistory();

    if (listOrderRes.status_code == 200) {
      /// Jika berhasil, tampilkan data
      historyStatus.value = 'success';
      historyOrders.value = listOrderRes.data!;
    } else if (listOrderRes.status_code == 204) {
      historyStatus.value = 'empty';
    } else {
      historyStatus.value = 'error';
    }
  }

  /// Memesan menu lagi
  void onOrderAgain(Order order) {
    for (var detail in order.menu) {
      /// Apakah data menu masih ada
      var menu = HomeController.to.listMenu
          .firstWhereOrNull((e) => e.id_menu == detail.id_menu);

      if (menu != null) {
        /// Jika menu ada, tambahkan ke cart
        CartController.to.add(CartItem(
          menu: menu,
          quantity: detail.jumlah,
          note: '',
          level: null,
          toppings: null,
        ));
      }
    }

    /// Kembali ke halaman keranjang
    Get.toNamed(AppRoutes.cartView);
  }
}
