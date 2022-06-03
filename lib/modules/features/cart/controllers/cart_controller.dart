import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/modules/features/cart/repositories/discount_repository.dart';
import 'package:java_code_app/modules/features/cart/repositories/order_repository.dart';
import 'package:java_code_app/modules/features/cart/repositories/voucher_repository.dart';
import 'package:java_code_app/modules/features/cart/view/components/discount_info.dart';
import 'package:java_code_app/modules/features/cart/view/components/fingerprint_dialog.dart';
import 'package:java_code_app/modules/features/cart/view/components/order_success_dialog.dart';
import 'package:java_code_app/modules/features/cart/view/components/pin_dialog.dart';
import 'package:java_code_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:java_code_app/modules/models/cart_item.dart';
import 'package:java_code_app/modules/models/discount.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/modules/models/voucher.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';
import 'package:local_auth/local_auth.dart';

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
  RxList<CartItem> cart = RxList<CartItem>();

  /// add item to cart
  void add(CartItem orderDetail) {
    cart.remove(orderDetail);
    cart.add(orderDetail);
  }

  /// Remove item from cart
  void remove(CartItem orderDetail) {
    cart.remove(orderDetail);
  }

  /// Increment item quantity
  void increment(CartItem orderDetail) {
    orderDetail.quantity++;
    cart.refresh();
  }

  /// Decrement item quantity
  void decrement(CartItem orderDetail) {
    if (orderDetail.quantity > 1) {
      orderDetail.quantity--;
      cart.refresh();
    } else {
      cart.remove(orderDetail);
    }
  }

  /// Update note
  void updateNote(CartItem orderDetail, String note) {
    orderDetail.note = note;
  }

  /// Getter for food items
  List<CartItem> get foodItems => cart.where((e) => e.isFood).toList();

  /// Getter for drink items
  List<CartItem> get drinkItems => cart.where((e) => e.isDrink).toList();

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
  /// - Verify fingerprint or PIN

  void order() async {
    Get.until(ModalRoute.withName(AppRoutes.cartView));
    Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const CircularProgressIndicator(),
    );

    final cartReq = CartReq(
      user: await LocalDBServices.getUser() as User,
      cart: cart,
      discounts: discounts.isEmpty ? null : discounts.toList(),
      voucher: selectedVoucher.value,
      discountPrice: totalPrice - grandTotalPrice,
      totalPrice: grandTotalPrice,
    );

    int statusCode = await OrderRepository.add(cartReq);

    if (statusCode == 200) {
      openOrderSuccessDialog();
    } else {
      Get.until(ModalRoute.withName(AppRoutes.cartView));
      Get.showSnackbar(GetSnackBar(
        title: 'Error'.tr,
        message: 'Server error'.tr,
        duration: const Duration(seconds: 2),
        backgroundColor: redColor,
      ));
    }
  }

  /// Verify fingerprint or PIN
  void verify() async {
    final LocalAuthentication auth = LocalAuthentication();

    final bool isBiometricSupported = await auth.isDeviceSupported();
    final bool canCheckBiometrics = await auth.canCheckBiometrics;

    /// Bisa menggunakan biometrik
    if (isBiometricSupported && canCheckBiometrics) {
      try {
        final status = await openFingerprintDialog();
        if (status == 'fingerprint') {
          final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to confirm order'.tr,
            options: const AuthenticationOptions(
              biometricOnly: true,
            ),
          );

          if (didAuthenticate) {
            order();
          }
        } else if (status == 'pin') {
          openPinDialog();
        }
      } on PlatformException {
        await openPinDialog();
      }
    } else {
      await openPinDialog();
    }
  }

  /// Open fingerprint dialog
  Future<String?> openFingerprintDialog() async {
    Get.until(ModalRoute.withName(AppRoutes.cartView));
    final arguments = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const FingerprintDialog(),
    );

    return arguments;
  }

  /// Open pin dialog
  Future<void> openPinDialog() async {
    Get.until(ModalRoute.withName(AppRoutes.cartView));

    int tries = 0;
    final User user = await LocalDBServices.getUser() as User;

    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: PinDialog(
        onCheckPin: (String? pin) {
          if (pin == user.pin) {
            order();
            return null;
          } else {
            tries++;
            if (tries >= 3) {
              Get.until(ModalRoute.withName(AppRoutes.cartView));
              Get.showSnackbar(GetSnackBar(
                title: 'Error'.tr,
                message:
                    'PIN already wrong 3 times. Please try again later.'.tr,
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ));
              return null;
            } else {
              return 'PIN wrong! n chances left.'.trParams({
                'n': (3 - tries).toString(),
              });
            }
          }
        },
      ),
    );
  }

  /// Open order success dialog
  void openOrderSuccessDialog() async {
    Get.until(ModalRoute.withName(AppRoutes.cartView));
    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const OrderSuccessDialog(),
    );

    /// TODO: redirect to detail order in dashboard -> orders -> detail order
    DashboardController.to.tabIndex.value = 1;
    Get.until(ModalRoute.withName(AppRoutes.dashboardView));

    cart.clear();
    selectedVoucher.value = null;
  }
}
