import 'package:equatable/equatable.dart';
import 'package:java_code_app/modules/models/menu.dart';

class OrderDetail extends Equatable {
  final Menu menu;
  final int quantity;
  final String note;
  final MenuVariant? level;
  final List<MenuVariant>? toppings;

  const OrderDetail({
    required this.menu,
    required this.quantity,
    required this.note,
    required this.level,
    required this.toppings,
  });

  @override
  List<Object?> get props => [menu.id_menu];
}
