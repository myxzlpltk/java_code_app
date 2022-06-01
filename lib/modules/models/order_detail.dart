// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:java_code_app/constants/commons/constants.dart';
import 'package:java_code_app/modules/models/menu.dart';

class OrderDetail extends Equatable {
  Menu menu;
  int quantity;
  String note;
  MenuVariant? level;
  List<MenuVariant>? toppings;

  OrderDetail({
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

  /// Getter untuk total harga
  int get totalPrice => quantity * menu.harga;

  @override
  List<Object?> get props => [menu.id_menu];
}
