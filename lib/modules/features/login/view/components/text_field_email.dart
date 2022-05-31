import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/themes/colors.dart';

class TextFieldEmail extends StatelessWidget {
  final TextEditingController controller;

  const TextFieldEmail({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        labelText: 'email'.tr,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        hintText: 'Lorem.ipsum@gmail.com',
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: darkColor.withOpacity(0.25),
            ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: ValidationBuilder().email().required().build(),
    );
  }
}
