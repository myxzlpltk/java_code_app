import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class TextFieldPassword extends StatelessWidget {
  final TextEditingController controller;

  const TextFieldPassword({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        labelText: 'password'.tr,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        hintText: '****************',
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: darkColor.withOpacity(0.25),
            ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: blueColor, width: 2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: blueColor, width: 2),
        ),
      ),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: ValidationBuilder().required().minLength(5).build(),
    );
  }
}
