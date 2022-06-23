import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class TextFieldPassword extends StatelessWidget {
  final TextEditingController controller;

  const TextFieldPassword({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Get.textTheme.bodySmall,
      decoration: InputDecoration(
        labelText: 'Password'.tr,
        labelStyle: Get.textTheme.bodySmall,
        hintText: '****************',
        hintStyle: Get.textTheme.bodySmall!.copyWith(
          color: AppColor.darkColor.withOpacity(0.25),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.blueColor, width: 1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.blueColor, width: 1),
        ),
      ),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required'.tr;
        } else if (value.length < 5) {
          return 'Password must be at least 5 characters'.tr;
        }
        return null;
      },
    );
  }
}
