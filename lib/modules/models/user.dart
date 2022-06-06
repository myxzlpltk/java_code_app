// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id_user;
  final String email;
  final String nama;
  final DateTime? tgl_lahir;
  final String? alamat;
  final String? telepon;
  final String? ktp;
  final String pin;
  final String? foto;

  const User({
    required this.id_user,
    required this.email,
    required this.nama,
    required this.tgl_lahir,
    required this.alamat,
    required this.telepon,
    required this.ktp,
    required this.pin,
    required this.foto,
  });

  /// From Json
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id_user: json['id_user'] as int,
      email: json['email'] as String,
      nama: json['nama'] as String,
      tgl_lahir: json['tgl_lahir'] as DateTime?,
      alamat: json['alamat'] as String?,
      telepon: json['telepon'] as String?,
      ktp: json['ktp'] as String?,
      pin: json['pin'] as String,
      foto: json['foto'] as String?,
    );
  }

  /// To Map
  Map<String, dynamic> toMap() {
    return {
      'id_user': id_user,
      'email': email,
      'nama': nama,
      'tgl_lahir': tgl_lahir,
      'alamat': alamat,
      'tele pon': telepon,
      'ktp': ktp,
      'pin': pin,
      'foto': foto,
    };
  }

  static User dummy = const User(
    id_user: 0,
    email: '',
    nama: '',
    tgl_lahir: null,
    alamat: '',
    telepon: '',
    ktp: '',
    pin: '',
    foto: '',
  );

  @override
  List<Object?> get props => [id_user];
}

class UserRes {
  final int status_code;
  final String? message;
  final User? user;
  final String? token;

  const UserRes({
    required this.status_code,
    this.message,
    this.user,
    this.token,
  });

  /// From Login Json
  factory UserRes.fromLoginJson(Map<String, dynamic> json) {
    return UserRes(
      status_code: json['status_code'],
      message: json['message'],
      user: json['status_code'] == 200
          ? User.fromJson(json['data']['user'])
          : null,
      token: json['status_code'] == 200 ? json['data']['token'] : null,
    );
  }

  /// From Login Json
  factory UserRes.fromJson(Map<String, dynamic> json) {
    return UserRes(
      status_code: json['status_code'],
      message: json['message'],
      user: json['status_code'] == 200 ? User.fromJson(json['data']) : null,
    );
  }
}
