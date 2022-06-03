import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/modules/features/cart/repositories/discount_repository.dart';
import 'package:java_code_app/modules/features/cart/repositories/voucher_repository.dart';
import 'package:java_code_app/modules/features/cart/view/components/discount_info.dart';
import 'package:java_code_app/modules/features/cart/view/components/fingerprint_dialog.dart';
import 'package:java_code_app/modules/features/cart/view/components/order_success_dialog.dart';
import 'package:java_code_app/modules/features/cart/view/components/pin_dialog.dart';
import 'package:java_code_app/modules/models/detail_order.dart';
import 'package:java_code_app/modules/models/discount.dart';
import 'package:java_code_app/modules/models/voucher.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    getDiscounts();
  }

  /// Basic cart functions :
  /// - Add item to cart
  /// - Remove item from cart
  /// - Increment quantity
  /// - Decrement quantity
  /// - Update note
  RxList<DetailOrder> cart = RxList<DetailOrder>();

  /// add item to cart
  void add(DetailOrder orderDetail) {
    cart.remove(orderDetail);
    cart.add(orderDetail);
  }

  /// Remove item from cart
  void remove(DetailOrder orderDetail) {
    cart.remove(orderDetail);
  }

  /// Increment item quantity
  void increment(DetailOrder orderDetail) {
    orderDetail.quantity++;
    cart.refresh();
  }

  /// Decrement item quantity
  void decrement(DetailOrder orderDetail) {
    if (orderDetail.quantity > 1) {
      orderDetail.quantity--;
      cart.refresh();
    } else {
      cart.remove(orderDetail);
    }
  }

  /// Update note
  void updateNote(DetailOrder orderDetail, String note) {
    orderDetail.note = note;
  }

  /// Getter for food items
  List<DetailOrder> get foodItems => cart.where((e) => e.isFood).toList();

  /// Getter for drink items
  List<DetailOrder> get drinkItems => cart.where((e) => e.isDrink).toList();

  /// Discount and voucher functions
  /// - Get discounts
  /// - Get vouchers
  /// - Update discount and voucher
  RxList<Discount> discounts = RxList<Discount>();
  RxList<Voucher> vouchers = RxList<Voucher>();
  RxString voucherStatus = RxString('loading');

  Rxn<Voucher> selectedVoucher = Rxn<Voucher>();

  /// Get discount for user
  Future<void> getDiscounts() async {
    var listDiscountRes = await DiscountRepository.getAll();

    if (listDiscountRes.status_code == 200) {
      listDiscountRes.data!.shuffle();
      // TODO: Update this code
      discounts.value = listDiscountRes.data!.sublist(0, 2);
    }
  }

  /// Get discount for user
  Future<void> getVouchers() async {
    voucherStatus.value = 'loading';
    var listVoucherList = await VoucherRepository.getAll();

    if (listVoucherList.status_code == 200) {
      voucherStatus.value = 'success';
      vouchers.value = listVoucherList.data!;
    } else {
      voucherStatus.value = 'error';
    }
  }

  /// Open dialog for discount
  void openDiscountDialog() {
    Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: DiscountInfo(discounts: discounts),
    );
  }

  /// Open dialog for voucher
  void openVoucherDialog() {
    if (vouchers.isEmpty) getVouchers();
    Get.toNamed(AppRoutes.chooseVoucherView);
  }

  void setVoucher(Voucher? voucher) {
    selectedVoucher.value = voucher;
  }

  /// Cart calculator using getter
  /// - Total price
  /// - Total discount
  /// - Total voucher
  /// - Total price after discount and voucher
  int get totalPrice => cart.fold(0, (total, item) => total + item.totalPrice);

  int get totalDiscount =>
      discounts.fold(0, (total, discount) => total + discount.nominal);

  int get discountPrice {
    if (selectedVoucher.value == null) {
      return totalPrice * totalDiscount ~/ 100;
    } else {
      return 0;
    }
  }

  int get voucherPrice => selectedVoucher.value!.nominal;

  /// Getter for total price with discount
  int get grandTotalPrice {
    if (selectedVoucher.value != null) {
      return max(totalPrice - voucherPrice, 0);
    } else {
      return max(totalPrice - discountPrice, 0);
    }
  }

  /// Cart action functions
  /// - Order

  void order() {
    openOrderSuccessDialog();
  }

  void openFingerprintDialog() {
    Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const FingerprintDialog(),
    );
  }

  void openPinDialog() {
    Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const PinDialog(),
    );
  }

  void openOrderSuccessDialog() {
    Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const OrderSuccessDialog(),
    );
  }
}
