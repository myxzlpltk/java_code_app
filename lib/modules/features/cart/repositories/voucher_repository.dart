import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/cores/api_const.dart';
import 'package:java_code_app/modules/models/voucher.dart';
import 'package:java_code_app/utils/services/api_services.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class VoucherRepository {
  VoucherRepository._();

  /// Memanggil API untuk mendapatkan semua menu
  static Future<ListVoucherRes> getAll() async {
    // TODO: Update this code
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var response = await dio.get(ApiConst.allVoucher);

      return ListVoucherRes.fromJson(response.data);
    } on DioError {
      return ListVoucherRes(status_code: 500, message: 'server_error'.tr);
    }
  }
}
