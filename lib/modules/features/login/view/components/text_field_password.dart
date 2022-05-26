import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class TextFieldPassword extends StatelessWidget {
  final TextEditingController controller;

  const TextFieldPassword({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'password'.tr,
        labelStyle: Theme.of(context).textTheme.subtitle2,
        hintText: '****************',
        hintStyle: Theme.of(context).textTheme.bodyText2,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: ValidationBuilder().required().minLength(5).build(),
    );
  }
}
