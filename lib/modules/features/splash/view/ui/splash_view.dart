import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/constants/cores/asset_const.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AssetConst.iconJavaCode,
          width: 0.8.sw,
        ),
      ),
    );
  }
}
