import 'package:get/get.dart';
import 'package:java_code_app/modules/features/review/controllers/review_controller.dart';

class ReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ReviewController());
  }
}
