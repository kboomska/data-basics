import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _SharedPreferencesKeys {
  static const nameKey = 'name_key';
}

abstract class _SecureStorageKeys {
  static const tokenKey = 'token';
}

class ExampleWidgetModel {
  final _storage = SharedPreferences.getInstance();
  final _secureStorage = const FlutterSecureStorage();

  Future<void> readName() async {
    final storage = await _storage;
    final name = storage.getString(_SharedPreferencesKeys.nameKey);
    print(name);
  }

  Future<void> setName() async {
    final storage = await _storage;
    // final success = await storage.setString('name_key', 'Ivan');
    // print(success); // true
    await storage.setString(_SharedPreferencesKeys.nameKey, 'Ivan');
  }

  Future<void> readToken() async {
    final token = await _secureStorage.read(key: _SecureStorageKeys.tokenKey);
    print(token);
  }

  Future<void> setToken() async {
    await _secureStorage.write(
        key: _SecureStorageKeys.tokenKey, value: 'al083f54kt');
  }
}
