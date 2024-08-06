import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  DatabaseService();

  late SharedPreferences _prefs;

  static Future<SharedPreferences> init() async =>
      await SharedPreferences.getInstance();

  Future<int?> getInt(String key) async {
    try {
      _prefs = await DatabaseService.init();
      int? result = _prefs.getInt(key);
      return result;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> setInt(String key, int value) async {
    try {
      _prefs = await DatabaseService.init();
      bool result = await _prefs.setInt(key, value);
      return result;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<double?> getDouble(String key) async {
    try {
      _prefs = await DatabaseService.init();
      double? result = _prefs.getDouble(key);
      return result;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> setDouble(String key, double value) async {
    try {
      _prefs = await DatabaseService.init();
      bool result = await _prefs.setDouble(key, value);
      return result;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> hasKey(String key) async {
    try {
      _prefs = await DatabaseService.init();
      bool result = _prefs.containsKey(key);
      return result;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
