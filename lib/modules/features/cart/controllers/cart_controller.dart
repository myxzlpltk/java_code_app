import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/commons/constants.dart';
import 'package:java_code_app/modules/features/cart/repositories/discount_repository.dart';
import 'package:java_code_app/modules/features/cart/repositories/order_repository.dart';
import 'package:java_code_app/modules/features/cart/repositories/voucher_repository.dart';
import 'package:java_code_app/modules/features/cart/view/components/discount_info.dart';
import 'package:java_code_app/modules/features/cart/view/components/fingerprint_dialog.dart';
import 'package:java_code_app/modules/features/cart/view/components/order_success_dialog.dart';
import 'package:java_code_app/modules/features/cart/view/components/pin_dialog.dart';
import 'package:java_code_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:java_code_app/modules/features/order/controllers/order_controller.dart';
import 'package:java_code_app/modules/models/cart_item.dart';
import 'package:java_code_app/modules/models/discount.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/modules/models/voucher.dart';
import 'package:java_code_app/shared/customs/error_snack_bar.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';
import 'package:java_code_app/utils/services/notification_services.dart';
import 'package:local_auth/local_auth.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    /// Ambil data diskon dan voucher dari API
    getDiscounts();
    getVouchers();
  }

  /// Basic cart functions :
  /// - Add item to cart
  /// - Remove item from cart
  /// - Increment quantity
  /// - Decrement quantity
  /// - Update note
  RxList<CartItem> cart = RxList<CartItem>();

  /// add item to cart
  void add(CartItem cartItem) {
    cart.remove(cartItem);
    cart.add(cartItem);
  }

  /// Remove item from cart
  void remove(CartItem cartItem) {
    cart.remove(cartItem);
  }

  /// Increment item quantity
  void increment(CartItem cartItem) {
    cartItem.quantity++;
    cart.refresh();
  }

  /// Decrement item quantity
  void decrement(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
      cart.refresh();
    } else {
      cart.remove(cartItem);
    }
  }

  /// Update note
  void updateNote(CartItem cartItem, String note) {
    cartItem.note = note;
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
      discounts.value = listDiscountRes.data!;
    } else {
      discounts.value = [];
    }
  }

  /// Get discount for user
  Future<void> getVouchers() async {
    voucherStatus.value = 'loading';
    var listVoucherRes = await VoucherRepository.getAll();

    if (listVoucherRes.status_code == 200) {
      voucherStatus.value = 'success';
      vouchers.value = listVoucherRes.data!;
    } else if (listVoucherRes.status_code == 204) {
      voucherStatus.value = 'empty';
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
    vouchers.refresh();
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
    /// Tutup modal
    Get.until(ModalRoute.withName(AppRoutes.cartView));
    Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const CircularProgressIndicator(
        color: AppColor.blueColor,
      ),
    );

    /// Buat model order
    final cartReq = CartReq(
      user: await LocalDBServices.getUser() as User,
      cart: cart,
      discounts: discounts.isEmpty ? null : discounts.toList(),
      voucher: selectedVoucher.value,
      discountPrice: totalPrice - grandTotalPrice,
      totalPrice: grandTotalPrice,
    );

    /// Kirim request ke API
    final response = await OrderRepository.add(cartReq);

    if (response != null &&
        response.statusCode == 200 &&
        response.data['status_code'] == 200) {
      /// Jika sukses, buka dialog sukses
      openOrderSuccessDialog(response.data['data']['id_order']);
    } else {
      /// Jika gagal, buka dialog error
      Get.until(ModalRoute.withName(AppRoutes.cartView));
      Get.showSnackbar(ErrorSnackBar(
        title: 'Error'.tr,
        message: 'Server error'.tr,
      ));
    }
  }

  /// Verify fingerprint or PIN
  void verify() async {
    /// Mencari tahu jenis otentikasi yang tersedia
    final LocalAuthentication auth = LocalAuthentication();
    final bool isBiometricSupported = await auth.isDeviceSupported();
    final bool canCheckBiometrics = await auth.canCheckBiometrics;

    /// Bisa menggunakan biometrik
    if (isBiometricSupported && canCheckBiometrics) {
      /// Buka modal fingerprint
      final status = await openFingerprintDialog();

      if (status == AppConst.fingerprint) {
        /// Jika pengguna memilih fingerprint, lanjutkan fingerprint
        final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to confirm order'.tr,
          options: const AuthenticationOptions(
            biometricOnly: true,
          ),
        );

        /// Jika fingerprint berhasil, lanjutkan order
        if (didAuthenticate) {
          order();
        }
      } else if (status == AppConst.pin) {
        /// Jika pengguna memilih PIN, lanjutkan PIN
        await openPinDialog();
      }
    } else {
      await openPinDialog();
    }
  }

  /// Open fingerprint dialog
  Future<String?> openFingerprintDialog() async {
    /// Tutup semua modal, buka modal fingerprint
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
    /// Tutup semua modal
    Get.until(ModalRoute.withName(AppRoutes.cartView));

    /// Ambil data user
    final User user = await LocalDBServices.getUser() as User;

    /// Buka modal pin
    final bool didAuthenticate = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: PinDialog(pin: user.pin),
    );

    if (didAuthenticate) {
      /// Jika pin berhasil, lanjutkan order
      order();
    } else {
      /// Jika sudah 3 kali salah, buka dialog error
      Get.until(ModalRoute.withName(AppRoutes.cartView));
      Get.showSnackbar(ErrorSnackBar(
        title: 'Error'.tr,
        message: 'PIN already wrong 3 times. Please try again later.'.tr,
      ));
    }
  }

  /// Open order success dialog
  void openOrderSuccessDialog(int id) async {
    /// Kirim notifikasi
    NotificationServices.sendNotification(
      'Order accepted'.tr,
      'Order is being prepared'.tr,
      {'id_order': id},
    );

    /// Tutup semua modal
    Get.until(ModalRoute.withName(AppRoutes.cartView));
    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const OrderSuccessDialog(),
    );

    /// Atur dasbor ke halaman order dan reload data
    DashboardController.to.tabIndex.value = 1;
    OrderController.to.fetchOnGoing();

    /// Navigasi ke halaman order
    Get.offNamedUntil(
      AppRoutes.detailOrderView,
      ModalRoute.withName(AppRoutes.dashboardView),
      arguments: id,
    );

    /// Hapus data keranjang
    cart.clear();
    selectedVoucher.value = null;
  }
}
