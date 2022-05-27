import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';
import 'package:java_code_app/modules/features/splash/controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

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
