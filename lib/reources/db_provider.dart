import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprout_mobile/reources/repository.dart';

class DBProvider implements Cache {
  // -- SHARED_PREFERENCE
  @override
  Future<bool> deleteInSharedPreference(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.remove(key);
  }

  @override
  Future<dynamic> storeInSharedPreference(String key, value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.setString(key, value);
  }

  @override
  Future<String?> getInSharedPreference(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(key) ?? "";
  }

  @override
  Future<bool?> getBooleanStoredInSharedPreference(String key) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getBool(key);
  }

  void setBooleanPref(String settingKey, bool newChoice) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(settingKey, newChoice);
  }
}

final dbProvider = DBProvider();
