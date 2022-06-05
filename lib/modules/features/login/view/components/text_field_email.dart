import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/localizations/localization.dart';
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
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator:
          ValidationBuilder(localeName: Localization.currentLocale.languageCode)
              .email()
              .required()
              .build(),
    );
  }
}
