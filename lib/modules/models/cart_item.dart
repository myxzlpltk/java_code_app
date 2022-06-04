// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:java_code_app/constants/commons/constants.dart';
import 'package:java_code_app/modules/models/discount.dart';
import 'package:java_code_app/modules/models/menu.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/modules/models/voucher.dart';

class CartItem extends Equatable {
  Menu menu;
  int quantity;
  String note;
  MenuVariant? level;
  List<MenuVariant>? toppings;

  CartItem({
    required this.menu,
    required this.quantity,
    required this.note,
    required this.level,
    required this.toppings,
  });

  /// Getter untuk makanan
  bool get isFood => menu.kategori == foodCategory;

  /// Getter untuk minuman
  bool get isDrink => menu.kategori == drinkCategory;

  /// Total level price
  int get totalLevelPrice {
    if (level == null) {
      return 0;
    } else {
      return level!.harga;
    }
  }

  /// Total topping price
  int get totalToppingsPrice {
    if (toppings == null) {
      return 0;
    } else {
      return toppings!.fold<int>(0, (total, topping) => total + topping.harga);
    }
  }

  /// Price per item with level or topping
  int get price {
    return menu.harga + totalLevelPrice + totalToppingsPrice;
  }

  /// Total price = price * quantity
  int get totalPrice {
    return price * quantity;
  }

  @override
  List<Object?> get props => [menu.id_menu];
}

class CartReq {
  final User user;
  final List<CartItem> cart;
  final List<Discount>? discounts;
  final Voucher? voucher;
  final int discountPrice;
  final int totalPrice;

  CartReq({
    required this.user,
    required this.cart,
    this.discounts,
    this.voucher,
    required this.discountPrice,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'order': {
        'id_user': user.id_user,
        'id_voucher': voucher?.id_voucher,
        'id_diskon': discounts?.isEmpty ?? true
            ? null
            : discounts?.map((e) => e.id_diskon).toList(),
        'diskon': voucher == null ? 1 : 0,
        'potongan': discountPrice,
        'total_bayar': totalPrice,
      },
      'menu': cart
          .map((e) => {
                'id_menu': e.menu.id_menu,
                'harga': e.price,
                'level': e.level?.id_detail,
                'topping': e.toppings?.isEmpty ?? true
                    ? null
                    : e.toppings?.map((e) => e.id_detail).toList(),
                'jumlah': e.quantity,
              })
          .toList(),
    };
  }
}
