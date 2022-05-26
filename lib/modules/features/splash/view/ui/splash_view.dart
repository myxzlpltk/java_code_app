import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Get.offNamed(AppRoutes.loginView);
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          AssetConst.iconJavaCode,
          width: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }
}
