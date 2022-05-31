// ignore_for_file: non_constant_identifier_names

import 'package:java_code_app/constants/commons/constants.dart';

class Menu {
  final int id_menu;
  final String nama;
  final String kategori;
  final int harga;
  final String deskripsi;
  final String foto;
  final int status;

  Menu({
    required this.id_menu,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.foto,
    required this.status,
  });

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

  MenuRes({
    required this.status_code,
    this.message,
    this.data,
  });

  /// From json
  factory MenuRes.fromJson(Map<String, dynamic> json) {
    return MenuRes(
      status_code: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['status_code'] == 200 ? Menu.fromJson(json['data']) : null,
    );
  }
}
