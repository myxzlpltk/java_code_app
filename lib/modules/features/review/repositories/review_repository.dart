import 'package:dio/dio.dart';
import 'package:java_code_app/constants/cores/api_const.dart';
import 'package:java_code_app/modules/models/review.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/utils/services/api_services.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class ReviewRepository {
  /// Memastikan class ini tidak dapat diinstansiasi
  ReviewRepository._();

  /// Memanggil API untuk mendapatkan semua riwayat
  static Future<ListReviewRes> listReview() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.get('${ApiConst.allReview}/${user.id_user}');

      return ListReviewRes.fromJson(response.data);
    } on DioError {
      return const ListReviewRes(status_code: 500);
    }
  }
}
