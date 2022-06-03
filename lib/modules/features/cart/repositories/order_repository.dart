import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:java_code_app/constants/cores/api_const.dart';
import 'package:java_code_app/modules/models/cart_item.dart';
import 'package:java_code_app/utils/services/api_services.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class OrderRepository {
  OrderRepository._();

  /// Memanggil API untuk mendapatkan semua menu
  static Future<int> add(CartReq cartReq) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var response = await dio.post(
        ApiConst.addOrder,
        data: json.encode(cartReq.toMap()),
      );

      return response.data['status_code'];
    } on DioError {
      return 500;
    }
  }
}
