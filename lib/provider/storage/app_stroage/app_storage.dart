// private key

import '../storage_impl/storage_impl.dart';

const String _languageKey = 'language';
const String _defaultLanguage = 'en';

class AppStorage {
  AppStorage({
    required StorageImpl storageImpl
  }) : _storageImpl = storageImpl;

  final StorageImpl _storageImpl;
  Future<void> saveLanguage(String language) async {
    try {
      await _storageImpl.write(key: _languageKey, value: language);
    } catch (e) {
      print ("Error saving language: $e");
    }
  }
  Future<String> getLanguage() async {
    try {
      final response = await _storageImpl.read(key: _languageKey);
      if (response == null) {
        return _defaultLanguage;
      }
      return response;
    } catch (e) {
      print ("Error getting language: $e");
      return _defaultLanguage;
    }
  }
}
