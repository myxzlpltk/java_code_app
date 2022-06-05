import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/cores/api_const.dart';
import 'package:java_code_app/modules/models/promo.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/utils/services/api_services.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class PromoRepository {
  PromoRepository._();

  /// Memanggil API untuk mendapatkan semua promo
  static Future<ListPromoRes> getAllByUser() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response =
          await dio.get('${ApiConst.allPromoPerUser}/${user.id_user}');

      return ListPromoRes.fromJson(response.data);
    } on DioError {
      return ListPromoRes(status_code: 500, message: 'Server error'.tr);
    }
  }
}
