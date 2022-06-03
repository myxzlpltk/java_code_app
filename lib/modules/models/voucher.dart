// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class Voucher extends Equatable {
  final int id_voucher;
  final int id_user;
  final String nama;
  final String nama_user;
  final int nominal;
  final String info_voucher;
  final DateTime periode_mulai;
  final DateTime periode_selesai;
  final int type;
  final int status;
  final String? catatan;

  const Voucher({
    required this.id_voucher,
    required this.id_user,
    required this.nama,
    required this.nama_user,
    required this.nominal,
    required this.info_voucher,
    required this.periode_mulai,
    required this.periode_selesai,
    required this.type,
    required this.status,
    required this.catatan,
  });

  /// From json
  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id_voucher: json['id_voucher'] as int,
      id_user: json['id_user'] as int,
      nama: json['nama'] as String,
      nama_user: json['nama_user'] as String,
      nominal: json['nominal'] as int,
      info_voucher: json['info_voucher'] as String,
      periode_mulai: DateTime.parse(json['periode_mulai'] as String),
      periode_selesai: DateTime.parse(json['periode_selesai'] as String),
      type: json['type'] as int,
      status: json['status'] as int,
      catatan: json['catatan'] as String,
    );
  }

  @override
  List<Object?> get props => [id_voucher];
}

class ListVoucherRes {
  final int status_code;
  final String? message;
  final List<Voucher>? data;

  ListVoucherRes({
    required this.status_code,
    this.message,
    this.data,
  });

  /// From json
  factory ListVoucherRes.fromJson(Map<String, dynamic> json) {
    return ListVoucherRes(
      status_code: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['status_code'] == 200
          ? json['data'].map<Voucher>((e) => Voucher.fromJson(e)).toList()
          : null,
    );
  }
}
