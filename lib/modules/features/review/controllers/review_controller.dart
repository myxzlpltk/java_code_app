import 'package:get/get.dart';
import 'package:java_code_app/modules/features/review/repositories/review_repository.dart';
import 'package:java_code_app/modules/models/review.dart';

class ReviewController extends GetxController {
  static ReviewController get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    fetchReview();
  }

  RxString status = RxString('loading');
  RxString message = RxString('');
  RxList<Review> listReview = RxList<Review>();

  Future<void> fetchReview() async {
    status.value = 'loading';

    var listMenuRes = await ReviewRepository.listReview();

    if (listMenuRes.status_code == 200) {
      status.value = 'success';
      listReview.value = listMenuRes.data!;
    } else if (listMenuRes.status_code == 204 ||
        listMenuRes.status_code == 422) {
      status.value = 'empty';
    } else {
      status.value = 'error';
      message.value = listMenuRes.message ?? 'Unknown error'.tr;
    }
  }
}
