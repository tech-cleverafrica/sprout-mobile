import 'package:sprout_mobile/src/reources/db_provider.dart';

class Repository {
  final int _cacheDB = 0;

  List<Cache> caches = <Cache>[dbProvider];
}

abstract class Cache {
  Future<String?> getInSharedPreference(String key);
  Future<bool> deleteInSharedPreference(String key);
  Future<dynamic> storeInSharedPreference(String key, value);
  Future<bool?> getBooleanStoredInSharedPreference(String key);
}
