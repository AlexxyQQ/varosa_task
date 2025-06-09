import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late final SharedPreferences _sharedPreferences;

  SharedPreferencesService._internal();

  static Future<SharedPreferencesService> create() async {
    final instance = SharedPreferencesService._internal();
    await instance._initPrefs();
    return instance;
  }

  Future<void> _initPrefs() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> reload() async {
    await _sharedPreferences.reload();
  }

  Future<String?> readString({required String key}) async {
    try {
      await _sharedPreferences.reload();
      return _sharedPreferences.getString(key);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> writeString({required String key, required String value}) async {
    try {
      await _sharedPreferences.setString(key, value);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> writeBool({required String key, required bool value}) async {
    try {
      await _sharedPreferences.setBool(key, value);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<bool?> readBool({required String key}) async {
    try {
      return _sharedPreferences.getBool(key);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> delete({required String key}) async {
    try {
      await _sharedPreferences.remove(key);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> clear() async {
    try {
      await _sharedPreferences.clear();
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
