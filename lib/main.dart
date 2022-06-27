import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/localizations/localization.dart';
import 'package:java_code_app/configs/pages/app_pages.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/light_theme.dart';
import 'package:java_code_app/constants/commons/constants.dart';
import 'package:java_code_app/modules/global_controllers/global_binding.dart';
import 'package:java_code_app/utils/services/notification_services.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// Force potrait mode
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// Firebase
    await Firebase.initializeApp();
    await NotificationServices.init();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    runApp(
      DevicePreview(
        enabled: kProfileMode,
        builder: (context) => const MyApp(), // Wrap your app
      ),
    );
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
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
