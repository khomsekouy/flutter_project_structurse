import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  factory Storage() => _instance;
  Storage._internal();
  static final Storage _instance = Storage._internal();

  // storage instance
  late SharedPreferences _sharedPreferences;
  //initialize storage
  Future<void> initial() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    print('Storage initialized');
  }
  // set data to storage
  Future<bool> set(String key, dynamic value) async {
    if (value is String) {
      return _sharedPreferences.setString(key, value);
    } else if (value is int) {
      return _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      return _sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      return _sharedPreferences.setStringList(key, value);
    } else if (value is Map<String, dynamic>) {
      final json = jsonEncode(value);
      return _sharedPreferences.setString(key, json);
    } else {
      return false;
    }
  }

  // Get string
  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  // Get int
  int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  // Get double
  double? getDouble(String key) {
    return _sharedPreferences.getDouble(key);
  }

  // Get bool
  bool getBool(String key) {
    return _sharedPreferences.getBool(key) ?? false;
  }

  // Get list string
  List<String>? getListString(String key) {
    return _sharedPreferences.getStringList(key);
  }

  //get map from storage
  Map<String, dynamic>? getMap(String key) {
    final json = _sharedPreferences.getString(key);
    if (json != null) {
      final map = jsonDecode(json);
      if (map is Map<String, dynamic>) {
        return map;
      }
    }
    return null;
  }
  // remove data from storage
  Future<bool> remove(String key) async {
    return _sharedPreferences.remove(key);
  }
  // clear all data from storage
  Future<bool> clear() async {
    return _sharedPreferences.clear();
  }
  // contains key
  bool containsKey(String key) {
    return _sharedPreferences.containsKey(key);
  }
  // get all keys
  Set<String> getKeys() {
    return _sharedPreferences.getKeys();
  }

  // static key
  static const String user = 'data';
  static const String accessToken = 'accessToken';

  // get user data
  Map<String, dynamic>? getUser() {
    return getMap(user);
  }
  // write user data
  Future<void> write({required String key, required String value}) {
    return Future.value();
  }
  // read user data
  Future<String> read({required String key}) {
    return Future.value('');
  }
}

class StorageException implements Exception {
  const StorageException(this.error);
  final Object error;
}
