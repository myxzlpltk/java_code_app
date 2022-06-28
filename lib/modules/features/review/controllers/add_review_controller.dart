import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:java_code_app/shared/widgets/image_picker_dialog.dart';

class AddReviewController extends GetxController {
  static AddReviewController get to => Get.find();

  /// Widget controller
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController reviewController = TextEditingController();
  final List<String> reviewTypes = [
    'Harga',
    'Rasa',
    'Penyajian makanan',
    'Pelayanan',
    'Fasilitas'
  ];

  /// Data
  RxnDouble selectedRating = RxnDouble();
  RxnString selectedReviewType = RxnString('');
  Rxn<File> selectedImage = Rxn<File>();

  void setReviewType(String reviewType) {
    selectedReviewType.value = reviewType;
  }

  void setRating(double rating) {
    selectedRating.value = rating;
  }

  Future<void> addImage() async {
    /// Buka dialog input sumber gambar
    ImageSource? imageSource = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const ImagePickerDialog(),
    );

    /// Jika pilih sumber gambar, buka dialog ambil gambar sesuai sumber
    if (imageSource == null) return;
    var image = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 1500,
      maxHeight: 1500,
      imageQuality: 90,
    );

    /// Jika gambar diambil, encode gambar ke base64
    if (image == null) return;
    selectedImage.value = File(image.path);
  }

  Future<void> sendReview() async {
    // final String base64Image = base64.encode(await selectedImage.value.readAsBytes());
  }
}
