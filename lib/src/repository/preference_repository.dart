import 'package:shared_preferences/shared_preferences.dart';

class PreferenceRepository {
  void setStringPref(String settingKey, String newChoice) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(settingKey, newChoice);
  }

  Future<String> getStringPref(String settingKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(settingKey) ?? "";
  }

  Future<Set<String>> getSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }

  void setBooleanPref(String settingKey, bool newChoice) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(settingKey, newChoice);
  }

  Future<bool> getBooleanPref(String settingKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(settingKey) ?? false;
  }

  Future<bool> getBooleanPrefPositive(String settingKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(settingKey) ?? true;
  }

  void setIntPref(String settingKey, int newChoice) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(settingKey, newChoice);
  }

  Future<int?> getIntPref(String settingKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(settingKey);
  }
}
