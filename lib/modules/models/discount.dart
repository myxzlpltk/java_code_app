// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class Discount extends Equatable {
  final int id_diskon;
  final int id_user;
  final String nama_user;
  final String nama;
  final int nominal;

  const Discount({
    required this.id_diskon,
    required this.id_user,
    required this.nama_user,
    required this.nama,
    required this.nominal,
  });

  /// From json
  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      id_diskon: json['id_diskon'] as int,
      id_user: json['id_user'] as int,
      nama_user: json['nama_user'] as String,
      nama: json['nama'] as String,
      nominal: json['nominal'] as int,
    );
  }

  /// To map
  Map<String, dynamic> toMap() {
    return {
      'id_diskon': id_diskon,
      'id_user': id_user,
      'nama_user': nama_user,
      'nama': nama,
      'nominal': nominal,
    };
  }

  @override
  List<Object?> get props => [id_diskon];
}

class ListDiscountRes {
  final int status_code;
  final String? message;
  final List<Discount>? data;

  const ListDiscountRes({
    required this.status_code,
    this.message,
    this.data,
  });

  /// From json
  factory ListDiscountRes.fromJson(Map<String, dynamic> json) {
    return ListDiscountRes(
      status_code: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['status_code'] == 200
          ? json['data'].map<Discount>((e) => Discount.fromJson(e)).toList()
          : null,
    );
  }
}
