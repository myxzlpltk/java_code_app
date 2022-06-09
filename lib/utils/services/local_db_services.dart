import 'dart:convert';

import 'package:java_code_app/modules/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local DB Service menggunakan shared preferences
class LocalDBServices {
  /// Memastikan class ini tidak bisa diinstansiasi
  LocalDBServices._();

  /// Menyimpan data user ke shared preferences
  static Future<void> setUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(user.toMap()));
  }

  /// Mendapatkan data user dari shared preferences
  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');
    if (user == null) {
      return null;
    } else {
      return User.fromJson(json.decode(user));
    }
  }

  /// Menghapus data user dari shared preferences
  static Future<void> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  /// Menyimpan data token ke shared preferences
  static Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  /// Mendapatkan data token dari shared preferences
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// Menghapus data token dari shared preferences
  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  /// Menyimpan data bahasa ke shared preferences
  static Future<void> setLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  /// Mendapatkan data bahasa dari shared preferences
  static Future<String?> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language');
  }

  /// Menghapus data bahasa dari shared preferences
  static Future<void> clearLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('language');
  }
}
