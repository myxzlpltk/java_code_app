// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:java_code_app/constants/commons/constants.dart';

class Menu extends Equatable {
  final int id_menu;
  final String nama;
  final String kategori;
  final int harga;
  final String deskripsi;
  final String foto;
  final int status;

  const Menu({
    required this.id_menu,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.foto,
    required this.status,
  });

  /// Apakah menu ini adalah makanan
  bool get isFood => kategori == foodCategory;

  /// Apakah menu ini adalah minuman
  bool get isDrink => kategori == drinkCategory;

  /// From json
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id_menu: json['id_menu'] as int,
      nama: json['nama'] as String,
      kategori: json['kategori'] as String,
      harga: json['harga'] as int,
      deskripsi: json['deskripsi'] as String,
      foto: (json['foto'] ?? defaultMenuPhoto) as String,
      status: json['status'] as int,
    );
  }

  /// To map
  Map<String, dynamic> toMap() {
    return {
      'id_menu': id_menu,
      'nama': nama,
      'kategori': kategori,
      'harga': harga,
      'deskripsi': deskripsi,
      'foto': foto,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [id_menu];
}

class MenuVariant extends Equatable {
  final int id_detail;
  final String keterangan;
  final String type;
  final int harga;

  const MenuVariant({
    required this.id_detail,
    required this.keterangan,
    required this.type,
    required this.harga,
  });

  /// From json
  factory MenuVariant.fromJson(Map<String, dynamic> json) {
    return MenuVariant(
      id_detail: json['id_detail'] as int,
      keterangan: json['keterangan'] as String,
      type: json['type'] as String,
      harga: json['harga'] as int,
    );
  }

  /// To map
  Map<String, dynamic> toMap() {
    return {
      'id_detail': id_detail,
      'keterangan': keterangan,
      'type': type,
      'harga': harga,
    };
  }

  @override
  List<Object?> get props => [id_detail];
}

class ListMenuRes {
  final int status_code;
  final String? message;
  final List<Menu>? data;

  ListMenuRes({
    required this.status_code,
    this.message,
    this.data,
  });

  /// From json
  factory ListMenuRes.fromJson(Map<String, dynamic> json) {
    return ListMenuRes(
      status_code: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['status_code'] == 200
          ? json['data'].map<Menu>((e) => Menu.fromJson(e)).toList()
          : null,
    );
  }
}

class MenuRes {
  final int status_code;
  final String? message;
  final Menu? data;
  final List<MenuVariant> topping;
  final List<MenuVariant> level;

  MenuRes({
    required this.status_code,
    this.message,
    this.data,
    this.topping = const <MenuVariant>[],
    this.level = const <MenuVariant>[],
  });

  /// From json
  factory MenuRes.fromJson(Map<String, dynamic> json) {
    return MenuRes(
      status_code: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['status_code'] == 200
          ? Menu.fromJson(json['data']['menu'])
          : null,
      topping: json['status_code'] == 200 && json['data']['topping'] is List
          ? json['data']['topping']
              .map<MenuVariant>((e) => MenuVariant.fromJson(e))
              .toList()
          : const <MenuVariant>[],
      level: json['status_code'] == 200 && json['data']['level'] is List
          ? json['data']['level']
              .map<MenuVariant>((e) => MenuVariant.fromJson(e))
              .toList()
          : const <MenuVariant>[],
    );
  }
}
