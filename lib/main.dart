import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/localizations/localization.dart';
import 'package:java_code_app/configs/pages/app_pages.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/light_theme.dart';
import 'package:java_code_app/constants/commons/constants.dart';
import 'package:java_code_app/modules/global_controllers/global_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Screen Util Init berdasarkan ukuran desain aplikasi
    return ScreenUtilInit(
      designSize: AppConst.appDesignSize,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: GlobalBinding(),
        title: AppConst.appName,
        initialRoute: AppRoutes.splashView,
        getPages: AppPages.pages(),
        translations: Localization(),
        locale: Localization.locale,
        fallbackLocale: Localization.fallbackLocale,
        theme: AppTheme.lightTheme,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: Localization.locales,
      ),
    );
  }
}
