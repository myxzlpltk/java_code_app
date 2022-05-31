import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/cores/api_const.dart';
import 'package:java_code_app/modules/models/menu.dart';
import 'package:java_code_app/utils/services/api_services.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class MenuRepository {
  MenuRepository._();

  /// Memanggil API untuk mendapatkan menu berdasarkan id
  static Future<MenuRes> getFromId(int id_menu) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var response = await dio.get('${ApiConst.menu}/$id_menu');

      return MenuRes.fromJson(response.data);
    } on DioError {
      return MenuRes(status_code: 500, message: 'server_error'.tr);
    }
  }
}
