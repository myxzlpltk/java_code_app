import 'package:equatable/equatable.dart';
import 'package:java_code_app/constants/commons/constants.dart';

class DetailOrder extends Equatable {
  final int id_menu;
  final String kategori;
  final String topping;
  final String nama;
  final String? foto;
  final int jumlah;
  final String harga;
  final int total;
  final String catatan;

  const DetailOrder({
    required this.id_menu,
    required this.kategori,
    required this.topping,
    required this.nama,
    required this.foto,
    required this.jumlah,
    required this.harga,
    required this.total,
    required this.catatan,
  });

  /// Getter untuk makanan
  bool get isFood => kategori == foodCategory;

  /// Getter untuk minuman
  bool get isDrink => kategori == drinkCategory;

  /// From json
  factory DetailOrder.fromJson(Map<String, dynamic> json) {
    return DetailOrder(
      id_menu: json['id_menu'] as int,
      kategori: json['kategori'] as String,
      topping: json['topping'] as String,
      nama: json['nama'] as String,
      foto: json['foto'] as String?,
      jumlah: json['jumlah'] as int,
      harga: json['harga'] as String,
      total: json['total'] as int,
      catatan: json['catatan'] as String,
    );
  }

  @override
  List<Object?> get props => [];
}
