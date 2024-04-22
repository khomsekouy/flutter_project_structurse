import 'package:shared_preferences/shared_preferences.dart';

class StorageImpl implements Storage {

  StorageImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  Future<String?> read({required String key}) async {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<void> delete({required String key}) async {
    await _sharedPreferences.remove(key);
  }

  @override
  Future<void> clear() async {
    await _sharedPreferences.clear();
  }
}

abstract class Storage {
  Future<String?> read({required String key});
  Future<void> write({required String key, required String value});
  Future<void> delete({required String key});
  Future<void> clear();
}
