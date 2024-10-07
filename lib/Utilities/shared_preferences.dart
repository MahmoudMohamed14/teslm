import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences get prefs => GetIt.instance.get<SharedPreferences>();
  static FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  static const String _userToken = "token";
  static const String _userID = "userID";
  static const String loginStatusKey = "loginStatus";
  static const String _theme = "theme";
  static const String _latLng = "latLng";

  // static Future logout() async {
  //   GitIt.instance.registerLazySingleton<UserModel>(
  //     () => UserModel(),
  //   );
  //   await secureStorage.delete(key: _userToken);
  //   setLoginState(false);
  // }

  static Future<void> setToken({required String token}) async {
    await prefs.setString(_userToken, token);
  }

  static String? getToken() {
    return prefs.getString(_userToken);
  }

  ///   [latLng] --- [lat] , [lng]
  static Future<void> setLatLng({required List<String> latLng}) async {
    await prefs.setStringList(_latLng, latLng);
  }

  ///   [latLng] --- [lat] , [lng]
  static List<String>? getLatLng() {
    return prefs.getStringList(_latLng);
  }

  static Future<void> setUserID({required String id}) async {
    await prefs.setString(_userID, id);
  }

  static String? getUserID() {
    return prefs.getString(_userID);
  }

  static Future<void> setTheme(bool themeValue) async {
    await prefs.setBool(_theme, themeValue);
  }

  static bool getTheme() {
    return prefs.getBool(_theme) ?? false;
  }

  static Future setLoginState(bool value) async =>
      await prefs.setBool(loginStatusKey, value);

  static bool getLoginState() => prefs.getBool(loginStatusKey) ?? false;
}
