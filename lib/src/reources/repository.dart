import 'package:sprout_mobile/src/reources/db_provider.dart';

class Repository {
  final int _cacheDB = 0;

  List<Cache> caches = <Cache>[dbProvider];

  Future<bool> deleteInSharedPreference(String key) async {
    return caches[_cacheDB].deleteInSharedPreference(key);
  }

  Future<dynamic> storeInSharedPreference(String key, String value) async {
    return caches[_cacheDB].storeInSharedPreference(key, value);
  }

  Future<String?> getInSharedPreference(String key) {
    return caches[_cacheDB].getInSharedPreference(key);
  }
}

abstract class Cache {
  Future<String?> getInSharedPreference(String key);
  Future<bool> deleteInSharedPreference(String key);
  Future<dynamic> storeInSharedPreference(String key, value);
  Future<bool?> getBooleanStoredInSharedPreference(String key);
}
