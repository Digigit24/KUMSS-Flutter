import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper around SharedPreferences for type-safe local storage.
class LocalStorage {
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<String?> getString(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getString(key);
  }

  Future<void> setString(String key, String value) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(key, value);
  }

  Future<bool?> getBool(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getBool(key);
  }

  Future<void> setBool(String key, bool value) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool(key, value);
  }

  Future<void> remove(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.remove(key);
  }

  Future<void> clear() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.clear();
  }
}
