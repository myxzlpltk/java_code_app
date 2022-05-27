import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/login/controllers/login_controller.dart';
import 'package:java_code_app/modules/features/login/view/components/login_button_apple.dart';
import 'package:java_code_app/modules/features/login/view/components/login_button_google.dart';
import 'package:java_code_app/modules/features/login/view/components/text_field_email.dart';
import 'package:java_code_app/modules/features/login/view/components/text_field_password.dart';
import 'package:java_code_app/shared/widgets/divider_with_text.dart';
import 'package:java_code_app/shared/widgets/primary_button.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetConst.bgPattern1),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            children: [
              /// Logo
              SizedBox(height: 80.h),
              Image.asset(AssetConst.iconJavaCode, width: 270.w),
              SizedBox(height: 120.h),

              /// Heading
              Text(
                'continue_to_sign_in'.tr,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),

              /// Email
              TextFieldEmail(controller: _emailController),
              SizedBox(height: 20.h),

              /// Password
              TextFieldPassword(controller: _passwordController),
              SizedBox(height: 40.h),

              /// Login Button
              PrimaryButton(
                text: 'Masuk',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    LoginController.to.loginWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    );
                  }
                },
              ),

              SizedBox(height: 70.h),
              const DividerWithText('atau'),
              SizedBox(height: 20.h),

              /// Google Button
              LoginButtonGoogle(onPressed: () {
                LoginController.to.loginWithGoogle();
              }),
              SizedBox(height: 15.h),

              /// Apple Button
              LoginButtonApple(onPressed: () {}),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
