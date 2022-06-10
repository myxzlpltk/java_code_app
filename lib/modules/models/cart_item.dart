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

  /// Apakah menu ini adalah makanan
  bool get isFood => menu.kategori == AppConst.foodCategory;

  /// Apakah menu ini adalah minuman
  bool get isDrink => menu.kategori == AppConst.drinkCategory;

  /// Mendapatkan harga dari level yang digunakan
  int get totalLevelPrice {
    if (level == null) {
      return 0;
    } else {
      return level!.harga;
    }
  }

  /// Mendapatkan harga dari topping yang digunakan
  int get totalToppingsPrice {
    if (toppings == null) {
      return 0;
    } else {
      return toppings!.fold<int>(0, (total, topping) => total + topping.harga);
    }
  }

  /// Mendapatkan harga dari menu beserta level dan topping
  int get price {
    return menu.harga + totalLevelPrice + totalToppingsPrice;
  }

  /// Mendapakan harga total dari menu dikali dengan jumlah yang dipesan
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
