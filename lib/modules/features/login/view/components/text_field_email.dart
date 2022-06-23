import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class TextFieldEmail extends StatelessWidget {
  final TextEditingController controller;

  const TextFieldEmail({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Get.textTheme.bodySmall,
      decoration: InputDecoration(
        labelText: 'Email'.tr,
        labelStyle: Get.textTheme.bodySmall,
        hintText: 'Lorem.ipsum@gmail.com',
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
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (!GetUtils.isEmail(value ?? '')) {
          return 'Email is not valid'.tr;
        }
        return null;
      },
    );
  }
}
