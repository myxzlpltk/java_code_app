import 'package:get/get.dart';
import 'package:java_code_app/modules/features/review/controllers/reply_review_controller.dart';

class ReplyReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ReplyReviewController());
  }
}
