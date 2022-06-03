import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/cores/api_const.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/utils/services/api_services.dart';

class LoginRepository {
  LoginRepository._();

  static final Dio _dio = ApiServices.dioCall();

  /// Memanggil API untuk login dengan email dan kata sandi
  /// @author: Saddam Azy (myxzlpltk@gmail.com)
  static Future<UserRes> getUserWithEmailAndPassword(
      String email, String password) async {
    /// Memanggil API login dengan method POST
    try {
      var response = await _dio.post(ApiConst.login, data: {
        'email': email,
        'password': password,
      });

      return UserRes.fromJson(response.data);
    } on DioError {
      return UserRes(status_code: 500, message: 'Server error'.tr);
    }
  }

  /// Memanggil API untuk login dengan email google dan kata sandi
  /// @author: Saddam Azy (myxzlpltk@gmail.com)
  static Future<UserRes> getUserFromGoogle(String nama, String email) async {
    /// Memanggil API login dengan method POST
    try {
      var response = await _dio.post(ApiConst.login, data: {
        'nama': nama,
        'email': email,
        'is_google': 'is_google',
      });

      return UserRes.fromJson(response.data);
    } on DioError {
      return UserRes(status_code: 500, message: 'Server error'.tr);
    }
  }
}
