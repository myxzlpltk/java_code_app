import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/localizations/localization.dart';
import 'package:java_code_app/configs/pages/app_pages.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/light_theme.dart';
import 'package:java_code_app/constants/commons/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValidationBuilder.setLocale('id');

    return ScreenUtilInit(
      designSize: appDesignSize,
      builder: (context, _) => GetMaterialApp(
        title: appName,
        initialRoute: AppRoutes.splashView,
        getPages: AppPages.pages(),
        translations: Localization(),
        locale: const Locale('id', 'ID'),
        fallbackLocale: const Locale('en', 'US'),
        theme: lightTheme,
      ),
    );
  }
}
