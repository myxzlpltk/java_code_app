import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/cores/api_const.dart';
import 'package:java_code_app/modules/models/discount.dart';
import 'package:java_code_app/utils/services/api_services.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class DiscountRepository {
  DiscountRepository._();

  /// Memanggil API untuk mendapatkan semua menu
  static Future<ListDiscountRes> getAll() async {
    // TODO: Update this code
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var response = await dio.get(ApiConst.allDiscount);

      return ListDiscountRes.fromJson(response.data);
    } on DioError {
      return ListDiscountRes(status_code: 500, message: 'server_error'.tr);
    }
  }
}
