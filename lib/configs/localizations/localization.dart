import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/localizations/langs/en_us.dart';
import 'package:java_code_app/configs/localizations/langs/id_id.dart';

class Localization extends Translations {
  /// Default locale
  static const locale = Locale('id', 'ID');
  static const fallbackLocale = Locale('en', 'US');

  /// Supported languages
  static const langs = [
    'English',
    'Indonesia',
  ];

  /// Supported locales
  static const locales = [
    Locale('en', 'US'),
    Locale('id', 'ID'),
  ];

  /// Translations
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'id_ID': idID,
      };

  /// Change locale
  static void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  /// Finds language in `langs` list and returns it as Locale
  static Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return currentLocale;
  }

  /// Returns current language
  static Locale get currentLocale {
    return Get.locale ?? fallbackLocale;
  }

  static String get currentLanguage {
    return langs.elementAt(locales.indexOf(currentLocale));
  }
}
