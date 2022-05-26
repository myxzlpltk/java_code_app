import 'package:shared_preferences/shared_preferences.dart';

class LocalDBServices {
  LocalDBServices._();

  static Future<void> setToken(String token) {
    return SharedPreferences.getInstance().then((prefs) {
      prefs.setString('token', token);
    });
  }

  static Future<String?> getToken() {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getString('token');
    });
  }
}
