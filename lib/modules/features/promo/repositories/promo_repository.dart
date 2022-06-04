import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/cores/api_const.dart';
import 'package:java_code_app/modules/models/promo.dart';
import 'package:java_code_app/utils/services/api_services.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class PromoRepository {
  PromoRepository._();

  /// Memanggil API untuk mendapatkan promo berdasarkan id
  static Future<PromoRes> getFromId(int id_promo) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var response = await dio.get('${ApiConst.detailPromo}/$id_promo');

      return PromoRes.fromJson(response.data);
    } on DioError {
      return PromoRes(status_code: 500, message: 'Server error'.tr);
    }
  }
}
