import 'package:dio/dio.dart';
import 'package:java_code_app/constants/cores/api_const.dart';
import 'package:java_code_app/modules/models/order.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/utils/services/api_services.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class OrderRepository {
  OrderRepository._();

  /// Memanggil API untuk mendapatkan semua menu
  static Future<ListOrderRes> getOnGoing() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.get('${ApiConst.onGoingOrder}/${user.id_user}');

      return ListOrderRes.fromJson(response.data);
    } on DioError {
      return const ListOrderRes(status_code: 500);
    }
  }
}
