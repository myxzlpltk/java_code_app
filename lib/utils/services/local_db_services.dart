import 'dart:convert';

import 'package:java_code_app/modules/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDBServices {
  LocalDBServices._();

  /// Set, Get, Clear User
  static Future<void> setUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(user.toMap()));
  }

  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');
    if (user == null) return null;
    return User.fromJson(json.decode(user));
  }

  static Future<void> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  /// Set, Get, Clear Token
  static Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  /// Set, Get, Clear Language
  static Future<void> setLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  static Future<String?> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language');
  }

  static Future<void> clearLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('language');
  }
}
