import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/cores/api_const.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/modules/models/voucher.dart';
import 'package:java_code_app/utils/services/api_services.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class VoucherRepository {
  VoucherRepository._();

  /// Memanggil API untuk mendapatkan semua menu
  static Future<ListVoucherRes> getAll() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response =
          await dio.get('${ApiConst.allVoucherPerUser}/${user.id_user}');

      return ListVoucherRes.fromJson(response.data);
    } on DioError {
      return ListVoucherRes(status_code: 500, message: 'Server error'.tr);
    }
  }
}
