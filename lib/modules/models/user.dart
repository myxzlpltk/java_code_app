class User {
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
}

class UserRes {
  final int statusCode;
  final String? message;
  final User? user;
  final String? token;

  const UserRes({
    required this.statusCode,
    this.message,
    this.user,
    this.token,
  });

  /// From Json
  factory UserRes.fromJson(Map<String, dynamic> json) {
    return UserRes(
      statusCode: json['status_code'],
      message: json['message'],
      user: json['status_code'] == 200
          ? User.fromJson(json['data']['user'])
          : null,
      token: json['status_code'] == 200 ? json['data']['token'] : null,
    );
  }

  /// To map
  Map<String, dynamic> toMap() {
    return {
      'status_code': statusCode,
      'message': message,
      'data': {
        'user': user?.toMap(),
        'token': token,
      },
    };
  }
}
