import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageSecureHelper {
  final secureStorage = const FlutterSecureStorage();

  Future<void> savePassword(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<bool> validatePassword(String key, String value) async {
    String data = await secureStorage.read(key: key) ?? '';
    if (data == value) {
      return true;
    }
    return false;
  }

  Future<bool> existPassword() async {
    String data = await secureStorage.read(key: 'password') ?? '';
    if (data != '') {
      return true;
    }
    return false;
  }

  Future<void> deletePassword(String key) async {
    await secureStorage.delete(key: key);
  }
}
