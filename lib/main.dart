import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/localizations/localization.dart';
import 'package:java_code_app/configs/pages/app_pages.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Java Code App",
      initialRoute: AppRoutes.homeView,
      getPages: AppPages.pages(),
      translations: Localization(),
      locale: const Locale('id', 'ID'),
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
