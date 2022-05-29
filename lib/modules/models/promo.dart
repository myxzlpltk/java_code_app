// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:java_code_app/utils/extensions/currency_extension.dart';
import 'package:java_code_app/utils/extensions/string_case_extension.dart';

class Promo {
  final int id_promo;
  final String nama;
  final String type;
  final int? diskon;
  final int? nominal;
  final int? kadaluarsa;
  final String syarat_ketentuan;
  final String? foto;

  const Promo({
    required this.id_promo,
    required this.nama,
    required this.type,
    this.diskon,
    this.nominal,
    this.kadaluarsa,
    required this.syarat_ketentuan,
    this.foto,
  });

  /// From Json
  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      id_promo: json['id_promo'] as int,
      nama: json['nama'] as String,
      type: json['type'] as String,
      diskon: json['diskon'] as int?,
      nominal: json['nominal'] as int?,
      kadaluarsa: json['kadaluarsa'] as int?,
      syarat_ketentuan: json['syarat_ketentuan'] as String,
      foto: json['foto'] as String?,
    );
  }

  /// To Map
  Map<String, dynamic> toMap() {
    return {
      'id_promo': id_promo,
      'nama': nama,
      'type': type,
      'diskon': diskon,
      'nominal': nominal,
      'kadaluarsa': kadaluarsa,
      'syarat_ketentuan': syarat_ketentuan,
      'foto': foto,
    };
  }

  String get typeLabel => type.tr.toTitleCase();

  String get amountLabel => type == 'diskon' ? '$diskon%' : nominal!.toShortK();

  String get typeAmountLabel => '$typeLabel $amountLabel';
}

class ListPromoRes {
  final int status_code;
  final String? message;
  final List<Promo>? data;

  const ListPromoRes({
    required this.status_code,
    this.message,
    this.data,
  });

  /// From Json
  factory ListPromoRes.fromJson(Map<String, dynamic> json) {
    return ListPromoRes(
      status_code: json['status_code'],
      message: json['message'],
      data: json['status_code'] == 200
          ? json['data'].map<Promo>((e) => Promo.fromJson(e)).toList()
          : null,
    );
  }
}

class PromoRes {
  final int status_code;
  final String? message;
  final Promo? data;

  const PromoRes({
    required this.status_code,
    this.message,
    this.data,
  });

  /// From Json
  factory PromoRes.fromJson(Map<String, dynamic> json) {
    return PromoRes(
      status_code: json['status_code'],
      message: json['message'],
      data: json['status_code'] == 200 ? Promo.fromJson(json['data']) : null,
    );
  }
}
