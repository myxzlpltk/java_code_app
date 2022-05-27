import 'package:dio/dio.dart';
import 'package:java_code_app/constants/cores/api_const.dart';

class ApiServices {
  /// Define singleton instance for ApiServices
  ApiServices._();

  static Dio dioCall({int timeout = 20000, String? token}) {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if(token != null) {
      headers['token'] = token;
    }

    var dio = Dio(
      BaseOptions(
        headers: headers,
        baseUrl: ApiConst.apiBaseUrl,
        connectTimeout: timeout,
      ),
    );

    return dio;
  }
}