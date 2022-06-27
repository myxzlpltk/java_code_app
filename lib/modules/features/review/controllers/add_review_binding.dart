import 'package:get/get.dart';
import 'package:java_code_app/modules/features/review/controllers/add_review_controller.dart';

class AddReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddReviewController());
  }
}
