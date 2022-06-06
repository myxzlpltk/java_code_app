import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:java_code_app/configs/localizations/localization.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/modules/features/profile/repositories/user_repository.dart';
import 'package:java_code_app/modules/features/profile/view/components/image_picker_dialog.dart';
import 'package:java_code_app/modules/models/user.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  Rx<User> user = Rx<User>(User.dummy);
  Rx<String> currentLanguage = RxString(Localization.currentLanguage);
  RxString deviceInfo = RxString('');

  @override
  void onInit() {
    super.onInit();

    /// Load user data
    LocalDBServices.getUser().then((value) {
      user.value = value!;
      loadData();
    });

    /// Load device info
    DeviceInfoPlugin().androidInfo.then((value) {
      deviceInfo.value = '${value.manufacturer} ${value.model}';
    });
  }

  Future<void> loadData() async {
    UserRes userRes = await UserRepository.get();

    if (userRes.status_code == 200) {
      user.value = User.dummy;
      user.value = userRes.user!;
      await LocalDBServices.setUser(userRes.user!);
    }
  }

  /// Logout user
  void logout() async {
    await LocalDBServices.clearToken();
    await LocalDBServices.clearUser();
    Get.offAllNamed(AppRoutes.loginView);
  }

  /// Update photo
  void openUpdatePhotoDialog() async {
    ImageSource? imageSource = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const ImagePickerDialog(),
    );

    if (imageSource == null) return;
    var image = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 75,
    );

    if (image == null) return;
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper'.tr,
          toolbarColor: blueColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
      ],
    );

    if (croppedFile == null) return;
    final base64Image = base64Encode(await croppedFile.readAsBytes());

    UserRes userRes = await UserRepository.updatePhoto(base64Image);

    if (userRes.status_code == 200) {
      user.value = User.dummy;
      user.value = userRes.user!;
      await LocalDBServices.setUser(userRes.user!);
    }
  }

  /// Update KTP
  void openVerifyIDDialog() async {
    ImageSource? imageSource = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const ImagePickerDialog(),
    );

    if (imageSource == null) return;
    var image = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 1500,
      maxHeight: 1500,
      imageQuality: 90,
    );

    if (image == null) return;
    final base64Image = base64Encode(await image.readAsBytes());

    UserRes userRes = await UserRepository.updateKTP(base64Image);

    if (userRes.status_code == 200) {
      user.value = User.dummy;
      user.value = userRes.user!;
      await LocalDBServices.setUser(userRes.user!);
    }
  }

  /// Update user data
  Future<void> updateUser({String? foto}) async {
    Map<String, String> data = {};

    if (foto != null) data['foto'] = foto;

    UserRes userRes = await UserRepository.update(data);

    if (userRes.status_code == 200) {
      user.value = User.dummy;
      user.value = userRes.user!;
      await LocalDBServices.setUser(userRes.user!);
    }
  }
}
