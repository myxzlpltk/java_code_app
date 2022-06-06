import 'package:get/get.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  late Rx<User> user;

  @override
  void onInit() {
    super.onInit();

    LocalDBServices.getUser().then((value) {
      user = Rx<User>(value!);
      loadData();
    });
  }

  Future<void> loadData() async {}
}
