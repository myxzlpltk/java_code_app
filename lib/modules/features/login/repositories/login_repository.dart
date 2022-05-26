import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/cores/api_const.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/utils/services/api_services.dart';

class LoginRepository {
  LoginRepository._();

  static final Dio _dio = ApiServices.dioCall();

  /// Memanggil API untuk login dengan email dan kata sandi
  /// @author: Saddam Azy
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
      return UserRes(statusCode: 500, message: 'server_error'.tr);
    }
  }
}
