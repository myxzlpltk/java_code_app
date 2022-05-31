// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id_user;
  final String email;
  final String nama;
  final String pin;
  final String? foto;

  const User({
    required this.id_user,
    required this.email,
    required this.nama,
    required this.pin,
    this.foto,
  });

  /// From Json
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id_user: json['id_user'] as int,
      email: json['email'] as String,
      nama: json['nama'] as String,
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
      'pin': pin,
      'foto': foto,
    };
  }

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

  /// From Json
  factory UserRes.fromJson(Map<String, dynamic> json) {
    return UserRes(
      status_code: json['status_code'],
      message: json['message'],
      user: json['status_code'] == 200
          ? User.fromJson(json['data']['user'])
          : null,
      token: json['status_code'] == 200 ? json['data']['token'] : null,
    );
  }
}
