import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/localizations/localization.dart';
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
          color: darkColor.withOpacity(0.25),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: blueColor, width: 1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: blueColor, width: 1),
        ),
      ),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator:
          ValidationBuilder(localeName: Localization.currentLocale.languageCode)
              .required()
              .minLength(5)
              .build(),
    );
  }
}
