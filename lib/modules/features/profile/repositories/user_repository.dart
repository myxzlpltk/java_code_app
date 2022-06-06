import 'package:dio/dio.dart';
import 'package:java_code_app/constants/cores/api_const.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/utils/services/api_services.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class UserRepository {
  UserRepository._();

  /// Memanggil API untuk mendapatkan user berdasarkan ID
  static Future<UserRes> get() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.get('${ApiConst.detailUser}/${user.id_user}');

      return UserRes.fromJson(response.data);
    } on DioError {
      return const UserRes(status_code: 500);
    }
  }

  /// Memanggil API untuk mengubah data user
  static Future<UserRes> update(Map<String, String> data) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.post(
        '${ApiConst.updateUser}/${user.id_user}',
        data: data,
      );

      return UserRes.fromJson(response.data);
    } on DioError {
      return const UserRes(status_code: 500);
    }
  }

  /// Memanggil API untuk mengubah data foto user
  static Future<UserRes> updatePhoto(String photo) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.post(
        '${ApiConst.updateUserPhoto}/${user.id_user}',
        data: {'image': photo},
      );

      return UserRes.fromJson(response.data);
    } on DioError {
      return const UserRes(status_code: 500);
    }
  }

  /// Memanggil API untuk mengubah data KTP user
  static Future<UserRes> updateKTP(String photo) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.post(
        '${ApiConst.updateUserKTP}/${user.id_user}',
        data: {'image': photo},
      );

      return UserRes.fromJson(response.data);
    } on DioError {
      return const UserRes(status_code: 500);
    }
  }
}
